/* ---------------------------------------------------------------------
*
*  -- PBLAS routine (version 2.1.0) --
*     Copyright (c) 2020 Advanced Micro Devices, Inc.  All rights reserved.
*     June 10, 2020
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

void pdpanel_bcast_(double * A, pd_panel * panel)
{
   PBTYP_T *type;
   char *top;

   if(panel->fcast)
   {
/*
*  Get type structure
*/
     type = PB_Cdtypeset();

     if(panel->fsend)
     {
       double *XAPTR;
       XAPTR = Mptr( ((char *)A), panel->Xii, panel->Xjj, panel->ldm, type->size );
       top = PB_Ctop( &panel->ictxt, BCAST, ROW, TOP_GET );
       type->Cgebs2d( panel->ictxt, ROW, top,
                      panel->brows, panel->bcols,
                      XAPTR, panel->ldm );
     }
     else
     {
       top = PB_Ctop( &panel->ictxt, BCAST, ROW, TOP_GET );
       type->Cgebr2d( panel->ictxt, ROW, top,
                      panel->brows, panel->bcols, panel->pmem,
                      panel->brows, panel->myrow, panel->iacol );
     }
   }
  return;
/*
*  End of pdpanel_bcast_
*/
}

