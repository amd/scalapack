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

void pdpanel_bwait_(pd_panel * panel)
{
   if(panel->npcol < 2)
      return;

   MPI_Type_free(panel->dtype);

   return;
/*
*  End of pdpanel_bfree_
*/
}


