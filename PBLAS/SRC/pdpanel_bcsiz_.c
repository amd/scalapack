/* ---------------------------------------------------------------------
*
*  -- PBLAS routine (version 2.1.0) --
*     Copyright (c) 2020 Advanced Micro Devices, Inc. All rights reserved.
*     June 2, 2020
*
*  ---------------------------------------------------------------------
*/
/*
*  Include files
*/
#include "pblas.h"
#include "PBpblas.h"
#include "PBtools.h"
#include "PBblacs.h"
#include "PBblas.h"

void pdpanel_bcsiz_(double * A, int * M, int * N,
                    int * IA, int * JA, int * II,
                    int * JJ, int * JB, int * desca,
                    pd_panel * panel )
{
   int nprow, npcol, myrow, mycol, rsrc, csrc;
   int ictxt;
   int INB, NB, IMB, MB;
   int IIA, JJA;

   int TM, TN, GM, GN;
   int psize;
   
   int Ad[DLEN_], lda;
   int Ai, Aj;
   int iarow, iacol;
   int remr, remc;
   int trsm_alloc, gemm_alloc;
   int trsm_bcast, gemm_bcast;

   PBTYP_T        * type;

   ictxt = desca[CTXT1_];
   rsrc = desca[RSRC1_]; 
   csrc = desca[CSRC1_]; 

   NB = desca[NB1_];
   MB = desca[MB1_];

   Cblacs_gridinfo( ictxt, &nprow, &npcol, &myrow, &mycol );

   PB_CargFtoC( *IA, *JA, desca, &Ai, &Aj, Ad );
   PB_Cinfog2l( *II-1, *JJ-1, Ad, nprow, npcol, myrow, mycol,
                &IIA, &JJA, &iarow, &iacol); 
  
   INB = Ad[INB_];
   IMB = Ad[IMB_];
   lda = Ad[LLD_];

   Mnumroc( remr, *M-*II+1, *II-1, IMB, MB, iarow, rsrc, nprow );
   Mnumroc( remc, *N-*JJ+1, *JJ-1, INB, NB, iacol, csrc, npcol );

   /* TRSM Broadcast Data Size calculation */
   trsm_bcast = 1;
   TM = *JB;
   TN = *JB;
   if(iacol == mycol && iarow == myrow)
   {
     trsm_alloc = -1; /* Local Matrix */
   }
   else if(iacol != mycol && iarow == myrow)
   {
     trsm_alloc = 1; /* Allocate Local Buffer to receive data */
   }
   else
   {
     TM = 0;
     TN = 0;
     trsm_alloc = 0; /* Doesn't require LL (TRSM input) data */
     trsm_bcast = 0;
   }
   if(*JB < NB)
     trsm_bcast = 0;

   /* GEMM Broadcast Data Size calculation */
   gemm_bcast = 1;
   GM = remr;
   GN = *JB;
   if(iacol == mycol && iarow == myrow)
   {
     GM = remr - TM;
     GN = *JB;
     gemm_alloc = -1; /* Local Matrix */
   }
   else if(iacol == mycol && iarow != myrow)
   {
     GM = remr;
     GN = *JB;
     gemm_alloc = -1; /* Local Matrix */
   }
   else if(iacol != mycol && iarow == myrow)
   {
     GM = remr - TM;
     GN = *JB;
     gemm_alloc = 1; /* Allocate Local Buffer to receive data */
   }
   else
   {
     GM = remr;
     GN = *JB;
     gemm_alloc = 1; /* Allocate Local Buffer to receive data */
   }
   if(GM <= 0)
     gemm_bcast = 0;

   /* Check even though we have data, should it be broadcasted
    * since the recepients may not want the data */
   // if(trsm_alloc == -1 && remc == (*N-*JJ+1))
   if(remc == (*N-*JJ+1))
   {
     trsm_bcast = 0;
     gemm_bcast = 0;
   }

   if(trsm_bcast || gemm_bcast)
   {
     int bcast_size, i;
     int brows, bcols;

     brows = TM + GM;
     bcols = MAX(TN, GN); /* These two should be same */

     bcast_size = brows * bcols;
     if(iacol == mycol)
     {
       psize = 0;
     }
     else
     {
       psize = bcast_size;
     }
   }
   else
   {
     psize = 0;
   }
  
   /* Fill the panel broadcast buffer structure with 
    * trsm, gemm data sizes */
   {
     int Xrow, Xcol, Xii, Xjj;

     Minfog2l( *II-1, *JJ-1, Ad, nprow, npcol, myrow, mycol, Xii, Xjj, Xrow, Xcol );
     panel->TM = TM;
     panel->TN = TN;
     panel->GM = GM;
     panel->GN = GN;
     panel->lda = (TM + GM);
     panel->psize = psize;
     panel->brows = TM + GM;
     panel->bcols = MAX(TN, GN); /* These two should be same */
     panel->fcast = (trsm_bcast || gemm_bcast);
     panel->fsend = (iacol == mycol);
     panel->iacol = iacol;
     panel->myrow = myrow;
     panel->ictxt = ictxt;
     panel->Xii = Xii;
     panel->Xjj = Xjj;
     panel->ldm = lda;
   }

   return;
}

