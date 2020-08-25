/* ---------------------------------------------------------------------
*
*  -- PBLAS routine --
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

void pdpanel_bcast_(double * A, pd_panel * panel, int * btest)
{
   PBTYP_T *type;
   char *top;
   int rank, next, prev, size;

   if((size = panel->npcol) < 2)
   {
     *btest = AOCL_SUCCESS;
     return;
   }
/*
*  Get type structure
*/
   type = PB_Cdtypeset();
   rank = panel->mycol;

   *btest = type->Cgesr2d(panel->ictxt, "Row", "SRing", panel->msgid, panel->pbuff, 1,
                          panel->mycol, panel->iacol, panel->dtype, panel->status);

   return;
/*
*  End of pdpanel_bcast_
*/
}

