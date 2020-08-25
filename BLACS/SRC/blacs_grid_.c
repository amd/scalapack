/* ---------------------------------------------------------------------
*
*  -- BLACS routine (version 2.1.0) --
*     Copyright (c) 2020 Advanced Micro Devices, Inc.  All rights reserved.
*     August 11, 2020
*
*  ---------------------------------------------------------------------
*/

#include "Bdef.h"

#if (INTFACE == C_CALL)
void Cblacs_gridexit(int ConTxt)
#else
F_VOID_FUNC blacs_gridexit_(int *ConTxt)
#endif
{
   int i;
   BLACSCONTEXT *ctxt;
   extern int BI_MaxNCtxt;
   extern BLACSCONTEXT **BI_MyContxts;

   if ( (Mpval(ConTxt) < 0) || (Mpval(ConTxt) >= BI_MaxNCtxt) )
      BI_BlacsErr(Mpval(ConTxt), __LINE__, __FILE__,
 	          "Trying to exit non-existent context");

   if (BI_MyContxts[Mpval(ConTxt)] == NULL)
      BI_BlacsErr(Mpval(ConTxt), __LINE__, __FILE__,
	          "Trying to exit an already freed context");

   MGetConTxt(Mpval(ConTxt), ctxt);
/*
 * Destroy context
 */
   MPI_Comm_free(&ctxt->pscp.comm);
   MPI_Comm_free(&ctxt->ascp.comm);
   MPI_Comm_free(&ctxt->rscp.comm);
   MPI_Comm_free(&ctxt->cscp.comm);
#ifdef ENABLE_LOOK_AHEAD_FOR_LU
   MPI_Comm_free(&ctxt->lscp.comm);
#endif /* ENABLE_LOOK_AHEAD_FOR_LU */
   free(ctxt);
   BI_MyContxts[Mpval(ConTxt)] = NULL;
}
