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

#ifdef __STDC__
void pdtrsmla_( F_CHAR_T SIDE, F_CHAR_T UPLO, F_CHAR_T TRANS, F_CHAR_T DIAG,
                int * M, int * N, double * ALPHA, pd_panel *PANEL )
#else
void pdtrsmla_( SIDE, UPLO, TRANS, DIAG, M, N, ALPHA, PANEL )
/*
*  .. Scalar Arguments ..
*/
   F_CHAR_T       DIAG, SIDE, TRANS, UPLO;
   int            * M, * N;
   double         * ALPHA;
   pd_panel       * PANEL;
#endif
{
/*
*  Purpose
*  =======
*
*  PDTRSM  solves one of the matrix equations
*
*     op( A )*X = alpha*B,   or
*
*     X*op( A ) = alpha*B,
*
*  where
*
*  Alpha is a scalar, X and B are m by n submatrices, A is
*  a unit, or non-unit, upper or lower  triangular submatrix and op( Y )
*  is one of
*
*     op( Y ) = Y   or   op( Y ) = Y'.
*
*  The submatrix X is overwritten on B.
*
*  Note
*  ====
*
*  This function is part of panel lookahead implementation where a panel
*  data structure contains information about input and  ouptput matrices
*  including the matrix memory locations.
*
*  Arguments
*  =========
*
*  SIDE    (global input) CHARACTER*1
*          On entry,  SIDE  specifies  whether op( A ) appears on
*          the left or right of X as follows:
*
*             SIDE = 'L' or 'l'   op( A )*X = alpha*B,
*
*             SIDE = 'R' or 'r'   X*op( A ) = alpha*B.
*
*  UPLO    (global input) CHARACTER*1
*          On entry,  UPLO  specifies whether the submatrix  A is
*          an upper or lower triangular submatrix as follows:
*
*             UPLO = 'U' or 'u'   A is an upper triangular
*                                 submatrix,
*
*             UPLO = 'L' or 'l'   A is a  lower triangular
*                                 submatrix.
*
*  TRANSA  (global input) CHARACTER*1
*          On entry,  TRANSA  specifies the form of op( A ) to be
*          used in the matrix multiplication as follows:
*
*             TRANSA = 'N' or 'n'   op( A ) = A,
*
*             TRANSA = 'T' or 't'   op( A ) = A',
*
*             TRANSA = 'C' or 'c'   op( A ) = A'.
*
*  DIAG    (global input) CHARACTER*1
*          On entry,  DIAG  specifies  whether or not  A  is unit
*          triangular as follows:
*
*             DIAG = 'U' or 'u'  A  is  assumed to be unit trian-
*                                gular,
*
*             DIAG = 'N' or 'n'  A is not assumed to be unit tri-
*                                angular.
*
*  M       (global input) INTEGER
*          On entry,  M  specifies the number of rows of  the  submatrix
*          B. M  must be at least zero.
*
*  N       (global input) INTEGER
*          On entry, N  specifies the number of columns of the submatrix
*          B. N  must be at least zero.
*
*  ALPHA   (global input) DOUBLE PRECISION
*          On entry, ALPHA specifies the scalar alpha.   When  ALPHA  is
*          supplied  as  zero  then  the  local entries of  the array  B
*          corresponding to the entries of the submatrix  B  need
*          not be set on input.
*
*  PANEL   (local input) pointer to pd_panel struct
*          The PANEL structure contains pointers to i/o matrices,  their
*          sizes &  other parameters related to lookahead implementation
*
*  ---------------------------------------------------------------------
*/
   PBTYP_T  * type;
   char     * Aptr, * Bptr;
   int        ln;
/*
*  Get type structure
*/
   type = PB_Cdtypeset();

   ln = MIN(*N, PANEL->LN);

   Bptr = Mptr( ( ( char * ) PANEL->umem ), 0,
                PANEL->uoff, PANEL->ldu, type->size );
   type->Ftrsm( SIDE, UPLO, TRANS, DIAG,
                &PANEL->JB, &ln, ALPHA,
                PANEL->lmem, &PANEL->JB,
                Bptr, &PANEL->ldu );
   return;
/*
*  End of pdtrsmla_
*/
}
