      SUBROUTINE ICOPYPV( M, N, A, IA, JA, DESCA, TPIV, IPIV, INFO )
*
*  -- AOCL ScaLAPACK routine --
*     Copyright (c) 2020 Advanced Micro Devices, Inc.  All rights reserved.
*     June 10, 2020
*

*     .. Scalar Arguments ..
      INTEGER            IA, INFO, JA, M, N
*     ..
*     .. Array Arguments ..
      INTEGER            DESCA( * ), IPIV( * ), TPIV( * )
      DOUBLE PRECISION   A( * )
*     ..
*
*  Purpose
*  =======
*
*  ICOPYPV copies pivot buffer of current LU iteration from  temporary 
*  pivot array into global pivot buffer.
*
*  Arguments
*  =========
*
*  M       (global input) INTEGER
*          The number of rows to be operated on, i.e. the number of rows
*          of the distributed submatrix sub( A ). M >= 0.
*
*  N       (global input) INTEGER
*          The number of columns to be operated on, i.e. the number of
*          columns of the distributed submatrix sub( A ). N >= 0.
*
*  A       (local input/local output) DOUBLE PRECISION pointer into the
*          local memory to an array of dimension (LLD_A, LOCc(JA+N-1)).
*          On entry, this array contains the local pieces of the M-by-N
*          distributed matrix sub( A ) to be factored. On exit, this
*          array contains the local pieces of the factors L and U from
*          the factorization sub( A ) = P*L*U; the unit diagonal ele-
*          ments of L are not stored.
*
*  IA      (global input) INTEGER
*          The row index in the global array A indicating the first
*          row of sub( A ).
*
*  JA      (global input) INTEGER
*          The column index in the global array A indicating the
*          first column of sub( A ).
*
*  DESCA   (global and local input) INTEGER array of dimension DLEN_.
*          The array descriptor for the distributed matrix A.
*
*  TPIV    (local input) INTEGER array, dimension ( MB_A )
*          This array contains the pivoting information for current
*          block under processing.
*          TPIV(i) -> The global row local row i was swapped with.
*
*  IPIV    (local output) INTEGER array, dimension ( LOCr(M_A)+MB_A )
*          This array contains the pivoting information.
*          IPIV(i) -> The global row local row i was swapped with.
*          This array is tied to the distributed matrix A.
*
*  INFO    (global output) INTEGER
*          = 0:  successful exit
*          < 0:  If the i-th argument is an array and the j-entry had
*                an illegal value, then INFO = -(i*100+j), if the i-th
*                argument is a scalar and had an illegal value, then
*                INFO = -i.
*          > 0:  If INFO = K, U(IA+K-1,JA+K-1) is exactly zero.
*                The factorization has been completed, but the factor U
*                is exactly singular, and division by zero will occur if
*                it is used to solve a system of equations.
*
*  =====================================================================
*
*     .. Parameters ..
      INTEGER            I, IACOL, IAROW, ICTXT,
     $                   J, MN, MYCOL, MYROW, NPCOL, NPROW
      PARAMETER          ( CTXT_ = 2 )
*     ..
*     .. External Subroutines ..
      EXTERNAL           BLACS_ABORT, BLACS_GRIDINFO, CHK1MAT, IGEBR2D,
     $                   IGEBS2D, INFOG2L, PDAMAX, ICOPY
     $                   PDSCAL, PDSWAP, PB_TOPGET, PXERBLA
*     ..
*     .. Executable Statements ..
*
*     Get grid parameters.
*
      ICTXT = DESCA( CTXT_ )
      CALL BLACS_GRIDINFO( ICTXT, NPROW, NPCOL, MYROW, MYCOL )
*
      MN = MIN( M, N )
      CALL INFOG2L( IA, JA, DESCA, NPROW, NPCOL, MYROW, MYCOL, I, J,
     $              IAROW, IACOL )
*
*     IF( MYCOL.EQ.IACOL ) THEN

      CALL ICOPY( MN, TPIV, 1, IPIV ( I ), 1 )

*     ENDIF
*
      RETURN
*
*     End of ICOPYPV
*
      END


