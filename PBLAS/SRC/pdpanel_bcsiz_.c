/* ---------------------------------------------------------------------
*
*  -- PBLAS routine --
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
                    pd_panel * panel, int * tpiv,
                    int * tag )
{
   int nprow, npcol, myrow, mycol, rsrc, csrc;
   int ictxt;
   int INB, NB, IMB, MB;
   int IIA, JJA;

   int TM, GM;
   
   int Ad[DLEN_], lda;
   int Ai, Aj;
   int iarow, iacol;
   int remr, remc;

   int Xrow, Xcol, Xii, Xjj;

   PBTYP_T        * type;

/*
*  Get type structure
*/
   type = PB_Cdtypeset();
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

   /* Remaining rows / columns in own process (self)  */
   Mnumroc( remr, *M-*II+1, *II-1, IMB, MB, myrow, rsrc, nprow );
   Mnumroc( remc, *N-*JJ+1, *JJ-1, INB, NB, mycol, csrc, npcol );

   /* TRSM  & GEMM Broadcast Data Size calculation */
   TM = (myrow != iarow) ? 0 : *JB;
   GM = (iarow == myrow) ? remr - TM : remr;
  
   /* Fill the panel broadcast buffer structure with 
    * trsm, gemm data sizes */

   {
      Minfog2l( *II-1, *JJ-1, Ad, nprow, npcol, myrow, mycol, Xii, Xjj, Xrow, Xcol );
      panel->lda   = lda;
      panel->TM    = TM;
      panel->brows = GM;

      panel->msgid = *tag;
      panel->nprow = nprow;
      panel->npcol = npcol;
      panel->iarow = iarow;
      panel->iacol = iacol;
      panel->myrow = myrow;
      panel->mycol = mycol;
      panel->ictxt = ictxt;

      panel->SN = MIN(*M - *JJ + *JA, *JB);
      panel->K1 = *II;
      panel->K2 = *JJ;
      panel->JB = *JB;

      panel->LN = remc;

      /* Allocate memory for column panel (L11||L21) */
      panel->pmem  = NULL;
      panel->psize = 0;

      if(mycol == iacol)
      {
         panel->LN  -= *JB;
         panel->ldm  = lda;
         panel->pmem = Mptr( ((char *) A), Xii + TM, Xjj, panel->ldm, type->size );
      }
      else
      {
         panel->ldm   = GM;
         panel->psize = panel->brows * *JB;
         if(panel->psize > 0)
            panel->pmem  = malloc(panel->psize * sizeof(double));
      }

      /* Pack column panel for broadcast */
      pdpanel_bpack_(panel, tpiv);

      panel->Xii = Xii;
      panel->Xjj = Xjj + *JB * (mycol == iacol);

      /* Allocate memory for row panel U */
      panel->umem  = NULL;
      panel->usize = 0;
      panel->uoff  = 0;
      panel->ucols = (mycol == iacol) ? (remc - *JB) : remc;

      if(myrow == iarow)
      {
         panel->ldu  = lda;
         panel->umem = Mptr(((char *) A), Xii, panel->Xjj, lda, type->size);
      }
      else
      {
         panel->ldu   = *JB;
         panel->usize = *JB * panel->ucols;
         if(panel->usize > 0)
            panel->umem = malloc(panel->usize * sizeof(double));
      }

      panel->amem = A;
   }

   return;
}

