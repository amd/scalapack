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

void pdpanel_bpack_(pd_panel *panel, int *tpiv)
{
   /* Create MPI derived datatype and commit 
      to pack panel and ipiv */
   int          nvecs, ivec, ldim, i;
   void         * * vecs = NULL;
   int          * vlen   = NULL;
   MPI_Datatype * vtype  = NULL;
   MPI_Aint     * vdis   = NULL;
   char         * mat;
   PBTYP_T      * type;
   int          ierr = MPI_SUCCESS;

   if(panel->npcol < 2)
      return;

   type = PB_Cdtypeset();
   nvecs = panel->JB + 2; /* L1 + No. of columns + pivot vector */

   /* Allocate temporary memory for buffers, len, disp and type */
   vecs  = (void       * *) malloc(nvecs * sizeof(void *));
   vlen  = (int          *) malloc(nvecs * sizeof(int          *));
   vtype = (MPI_Datatype *) malloc(nvecs * sizeof(MPI_Datatype *));
   vdis  = (MPI_Aint   * *) malloc(nvecs * sizeof(MPI_Aint   * *));

   /* local starting location of broadcast mem and leading dim */
   ldim = panel->ldm;
   mat  = panel->pmem;

   /* Pack the columns of panel */
   for(i = 0; i < panel->JB; i++)
   {
      vecs [i] = (void *) Mptr(mat, 0, i, ldim, type->size);
      vlen [i] = panel->brows;
      vtype[i] = MPI_DOUBLE;
      if(ierr == MPI_SUCCESS)
         ierr = MPI_Get_address(vecs[i], &vdis[i]);
   }

   /* Pack the L11 Buffer */
   vecs [nvecs - 2] = (void *) panel->lmem;
   vlen [nvecs - 2] = panel->JB * panel->JB;
   vtype[nvecs - 2] = MPI_DOUBLE;
   if(ierr == MPI_SUCCESS)
      ierr = MPI_Get_address(vecs[nvecs - 2], &vdis[nvecs - 2]);

   /* Pack the pivot array */
   vecs [nvecs - 1] = (void *) tpiv;
   vlen [nvecs - 1] = panel->JB;
   vtype[nvecs - 1] = MPI_INTEGER;
   if(ierr == MPI_SUCCESS)
      ierr = MPI_Get_address(vecs[nvecs - 1], &vdis[nvecs - 1]);

   for(i = 1; i < nvecs; i++)
   {
      vdis[i] = vdis[i] - vdis[0];
   }
   vdis[0] = 0;

   panel->pbuff = (char *) vecs[0];

   if(ierr == MPI_SUCCESS)
      ierr =  MPI_Type_create_struct( nvecs, vlen, vdis, vtype,
                                      panel->dtype);
   /* Free the temporary buffers */
   if(vecs ) free(vecs);
   if(vlen ) free(vlen);
   if(vtype) free(vtype);
   if(vdis ) free(vdis);

   if(ierr == MPI_SUCCESS)
      ierr =  MPI_Type_commit(panel->dtype);
}

