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

void pdpanel_pfree_(pd_panel * panel)
{
   free(panel->lmem);

   if(panel->dtype)
     free(panel->dtype);

   if(panel->request)
     free(panel->request);

   if(panel->status)
     free(panel->status);

   return;
}

