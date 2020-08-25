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

/*
 * Row Panel U broadcast
 */
void pdpanel_ucast_( double * A, int *N, int *I, int *J, pd_panel * panel )
{
   PBTYP_T *type;
   char    *umem, *top;
   int     coff, Xrow, Xcol, Xii, Xjj;
   int     nprow, npcol, myrow, mycol;

   if(panel->nprow < 2)
      return;
/*
*  Get type structure
*/
   type = PB_Cdtypeset();
   top  = PB_Ctop( &panel->ictxt, BCAST, COLUMN, TOP_GET );
   umem = Mptr( ((char *) panel->umem), 0,
                   panel->uoff, panel->ldu,
                   type->size );

   if( panel->myrow == panel->iarow )
   {
      type->Cgebs2d( panel->ictxt, COLUMN, " " /*top*/,
                     panel->JB, *N,
                     umem, panel->ldu );
   }
   else
   {
      type->Cgebr2d( panel->ictxt, COLUMN, " " /*top*/,
                     panel->JB, *N /*panel->ucols*/, umem,
                     panel->JB, panel->iarow, panel->mycol );
   }
   return;
/*
*  End of pdpanel_ucast_
*/
}

