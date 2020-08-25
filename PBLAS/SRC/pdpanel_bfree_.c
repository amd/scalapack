/* ---------------------------------------------------------------------
*
*  -- PBLAS routine --
*     Copyright (c) 2020 Advanced Micro Devices, Inc.  All rights reserved.
*     June 30, 2020
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

void pdpanel_bfree_(pd_panel * panel)
{
   if(panel->nprow > 1)
   {
      if(panel->usize > 0)
        free(panel->umem);

      panel->umem = NULL;
      panel->usize = 0;
   }

   if(panel->npcol > 1)
   {
      if(panel->psize > 0)
         free(panel->pmem);

      panel->pmem = NULL;
      panel->psize = 0;
   }

   return;
/*
*  End of pdpanel_bfree_
*/
}

