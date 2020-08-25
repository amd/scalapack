*  =====================================================================
*     SUBROUTINE PDGETRF
*  =====================================================================
      SUBROUTINE PDGETRF( M, N, A, IA, JA, DESCA, IPIV, INFO )
*
*  -- ScaLAPACK routine (version 2.1.0) --
*     Copyright (c) 2020 Advanced Micro Devices, Inc.  All rights reserved.
*     June 10, 2020
*
*  -- ScaLAPACK routine (version 1.7) --
*     University of Tennessee, Knoxville, Oak Ridge National Laboratory,
*     and University of California, Berkeley.
*     May 25, 2001
*
*     .. Scalar Arguments ..
      INTEGER            INFO, IA, JA, M, N
*     ..
*     .. Array Arguments ..
      INTEGER            DESCA( * ), IPIV( * )
      DOUBLE PRECISION   A( * )
*     ..
*
*  Purpose
*  =======
*
*  PDGETRF computes an LU factorization of a general M-by-N distributed
*  matrix sub( A ) = (IA:IA+M-1,JA:JA+N-1) using partial pivoting with
*  row interchanges.
*
*  The factorization has the form sub( A ) = P * L * U, where P is a
*  permutation matrix, L is lower triangular with unit diagonal ele-
*  ments (lower trapezoidal if m > n), and U is upper triangular
*  (upper trapezoidal if m < n). L and U are stored in sub( A ).
*
*  This is the right-looking Parallel Level 3 BLAS version of the
*  algorithm.
*
*  Notes
*  =====
*
*  Each global data object is described by an associated description
*  vector.  This vector stores the information required to establish
*  the mapping between an object element and its corresponding process
*  and memory location.
*
*  Let A be a generic term for any 2D block cyclicly distributed array.
*  Such a global array has an associated description vector DESCA.
*  In the following comments, the character _ should be read as
*  "of the global array".
*
*  NOTATION        STORED IN      EXPLANATION
*  --------------- -------------- --------------------------------------
*  DTYPE_A(global) DESCA( DTYPE_ )The descriptor type.  In this case,
*                                 DTYPE_A = 1.
*  CTXT_A (global) DESCA( CTXT_ ) The BLACS context handle, indicating
*                                 the BLACS process grid A is distribu-
*                                 ted over. The context itself is glo-
*                                 bal, but the handle (the integer
*                                 value) may vary.
*  M_A    (global) DESCA( M_ )    The number of rows in the global
*                                 array A.
*  N_A    (global) DESCA( N_ )    The number of columns in the global
*                                 array A.
*  MB_A   (global) DESCA( MB_ )   The blocking factor used to distribute
*                                 the rows of the array.
*  NB_A   (global) DESCA( NB_ )   The blocking factor used to distribute
*                                 the columns of the array.
*  RSRC_A (global) DESCA( RSRC_ ) The process row over which the first
*                                 row of the array A is distributed.
*  CSRC_A (global) DESCA( CSRC_ ) The process column over which the
*                                 first column of the array A is
*                                 distributed.
*  LLD_A  (local)  DESCA( LLD_ )  The leading dimension of the local
*                                 array.  LLD_A >= MAX(1,LOCr(M_A)).
*
*  Let K be the number of rows or columns of a distributed matrix,
*  and assume that its process grid has dimension p x q.
*  LOCr( K ) denotes the number of elements of K that a process
*  would receive if K were distributed over the p processes of its
*  process column.
*  Similarly, LOCc( K ) denotes the number of elements of K that a
*  process would receive if K were distributed over the q processes of
*  its process row.
*  The values of LOCr() and LOCc() may be determined via a call to the
*  ScaLAPACK tool function, NUMROC:
*          LOCr( M ) = NUMROC( M, MB_A, MYROW, RSRC_A, NPROW ),
*          LOCc( N ) = NUMROC( N, NB_A, MYCOL, CSRC_A, NPCOL ).
*  An upper bound for these quantities may be computed by:
*          LOCr( M ) <= ceil( ceil(M/MB_A)/NPROW )*MB_A
*          LOCc( N ) <= ceil( ceil(N/NB_A)/NPCOL )*NB_A
*
*  This routine requires square block decomposition ( MB_A = NB_A ).
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
#ifdef ENABLE_LOOK_AHEAD_FOR_LU
*     ..
*     .. Local Scalars ..

*     Defining the threshold to invoke look-ahead      
      INTEGER            CTXT_, LU_THRESHOLD, NB_, MN, NB
      INTEGER            ICTXT, MYCOL, MYROW, NPCOL, NPROW
*     ..
*     LU_THRESHOLD is used to filter out lower size matrices
*     from taking lookahead path as it may not provide any gain
*
      PARAMETER          (CTXT_ = 2, LU_THRESHOLD = 0, NB_ = 6)
*     ..
*     .. External Subroutines ..
      EXTERNAL           BLACS_GRIDINFO, PDGETRFLA, PDGETRF0
*     ..
*     .. Intrinsic Functions ..
      INTRINSIC          MIN
*     ..
*     .. Executable Statements ..
*
*     Get grid parameters
*
      ICTXT = DESCA( CTXT_ )
      CALL BLACS_GRIDINFO( ICTXT, NPROW, NPCOL, MYROW, MYCOL )
*
#ifdef AOCL_DTL_ADVANCED_TRACE_ENABLE
      CALL AOCL_DTL_TRACE_ENTRY(__FILE__, __LINE__, ' ')
#endif
      MN = MIN( M, N )
      NB = DESCA( NB_ )
*
      IF( ( MN.LT.LU_THRESHOLD ).OR.( NB.GE.MN ) ) THEN
*
*        Default LU for small matrices and
*        when block size is larger than matrix size
*
         CALL PDGETRF0( M, N, A, IA, JA, DESCA, IPIV, INFO )
      ELSE
         IF( NPCOL.LT.2 ) THEN
*
*           Default LU when number of process colums is 1
*
            CALL PDGETRF0( M, N, A, IA, JA, DESCA, IPIV, INFO )
         ELSE
*
*           LU with Look Ahead Depth 1
*
            CALL PDGETRFLA( M, N, A, IA, JA, DESCA, IPIV, INFO )
         END IF
      END IF
#else /* ENABLE_LOOK_AHEAD_FOR_LU */
      CALL PDGETRF0( M, N, A, IA, JA, DESCA, IPIV, INFO )
#endif /* ENABLE_LOOK_AHEAD_FOR_LU */
*
#ifdef AOCL_DTL_ADVANCED_TRACE_ENABLE
      CALL AOCL_DTL_TRACE_EXIT(__FILE__, __LINE__, ' ')
#endif
      RETURN
*
*     End of PDGETRF
*
      END
