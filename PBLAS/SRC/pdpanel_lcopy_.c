/* ---------------------------------------------------------------------
*
*  -- PBLAS routine --
*     Copyright (c) 2020 Advanced Micro Devices, Inc.  All rights reserved.
*     August 12, 2020
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

void pdpanel_lcopy_( double * A, int * IA, int * JA, int *LDA, 
                     int * M, pd_panel *panel )
{
   PBTYP_T  * type;
   double   * Aptr, * Lptr;
   int        i, j, IC, JC;
/*
*  Get type structure
*/
   type = PB_Cdtypeset();

   IC = panel->Xii;
   JC = panel->Xjj - panel->JB;

   for( i = 0; i < *M; i++ )
   {
      Aptr = Mptr( ( ( char * ) A ), IC, JC + i, *LDA, type->size );
      Lptr = Mptr( ( ( char * ) panel->lmem ), 0, i, *M, type->size );

      for( j = 0; j < *M; j++ )
      {
         Lptr[j] = Aptr[j];
      }
   }
   return;
/*
*  End of pdpanel_bcast_
*/
}

