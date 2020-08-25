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

void pdpanel_pinit_(pd_panel * panel, int *jb)
{
   panel->lmem = (double *) malloc(*jb * *jb * sizeof(double));

   panel->dtype = (MPI_Datatype *) malloc(sizeof(MPI_Datatype));
   panel->request = (MPI_Request *) malloc(sizeof(MPI_Request));
   panel->status = (MPI_Status *) malloc(sizeof(MPI_Status));

   return;
}

