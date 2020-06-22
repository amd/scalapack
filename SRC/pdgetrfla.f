*  =====================================================================
*     SUBROUTINE PDGETRFLA
*  =====================================================================
      SUBROUTINE PDGETRFLA( M, N, A, IA, JA, DESCA, IPIV, INFO )
*
*  -- ScaLAPACK routine (version 2.1.0) --
*     Copyright (c) 2020 Advanced Micro Devices, Inc.  All rights reserved.
*     June 10, 2020
*
*     .. Scalar Arguments ..
      INTEGER            IA, INFO, JA, M, N
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
*     .. Parameters ..
      INTEGER            BLOCK_CYCLIC_2D, CSRC_, CTXT_, DLEN_, DTYPE_,
     $                   LLD_, MB_, M_, NB_, N_, RSRC_
      PARAMETER          ( BLOCK_CYCLIC_2D = 1, DLEN_ = 9, DTYPE_ = 1,
     $                     CTXT_ = 2, M_ = 3, N_ = 4, MB_ = 5, NB_ = 6,
     $                     RSRC_ = 7, CSRC_ = 8, LLD_ = 9 )
      DOUBLE PRECISION   ONE
      PARAMETER          ( ONE = 1.0D+0 )
*     ..
*     .. Local Scalars ..
      CHARACTER          COLBTOP, COLCTOP, ROWBTOP
      INTEGER            I, ICOFF, ICTXT, IINFO, IN, IROFF, J, JB, JN,
     $                   MN, MYCOL, MYROW, NPCOL, NPROW
      INTEGER            NU 
*     ..
*     .. Local Arrays ..
      INTEGER            IDUM1( 1 ), IDUM2( 1 )
      INTEGER            LC1, LC2, NS, IAROW, IACOL, LACOL, JO, FSWAP
      INTEGER            II, JJ, LB, PIDX( 2 )
*
*     Panel Structure definition
*
      TYPE PD_PANEL
           INTEGER   ::   TM, TN, GM, GN, LDA
           INTEGER   ::   BROWS, BCOLS, FSEND, IACOL, MYROW
           INTEGER   ::   FCAST, ICTXT, XII, XJJ, LDM
           INTEGER   ::   SN, K1, K2, KB
           INTEGER   ::   PMEMSIZ
           DOUBLE PRECISION, allocatable :: PMEM (:)
      END TYPE PD_PANEL
*
      TYPE(PD_PANEL) :: PANEL(2)
      INTEGER, allocatable :: TPIV (:)
*     ..
*     .. External Subroutines ..
      EXTERNAL           BLACS_GRIDINFO, CHK1MAT, IGAMN2D, PCHK1MAT,
     $                   PB_TOPGET, PB_TOPSET, PDGEMM, PDGETF2,
     $                   PDLASWP, PDTRSM, PXERBLA, PDUPDATE
     $                   PDGETF2_COMM, PDGETF2K, ICOPYPV
*     ..
*     .. External Functions ..
      INTEGER            ICEIL
      EXTERNAL           ICEIL
*     ..
*     .. Intrinsic Functions ..
      INTRINSIC          MIN, MOD
*     ..
*     .. Executable Statements ..
*
*     Get grid parameters
*
      ICTXT = DESCA( CTXT_ )
      CALL BLACS_GRIDINFO( ICTXT, NPROW, NPCOL, MYROW, MYCOL )
*
      CALL INFOG2L( IA, JA, DESCA, NPROW, NPCOL, MYROW, MYCOL, I, J,
     $              IAROW, IACOL )

      LC1 = 1
      LC2 = 2
      PIDX(1) = 2
      PIDX(2) = 1
      
      LACOL = MOD( IACOL+1, NPCOL ) 
*
*     Test the input parameters
*
      INFO = 0
      IF( NPROW.EQ.-1 ) THEN
         INFO = -(600+CTXT_)
      ELSE
         CALL CHK1MAT( M, 1, N, 2, IA, JA, DESCA, 6, INFO )
         IF( INFO.EQ.0 ) THEN
            IROFF = MOD( IA-1, DESCA( MB_ ) )
            ICOFF = MOD( JA-1, DESCA( NB_ ) )
            IF( IROFF.NE.0 ) THEN
               INFO = -4
            ELSE IF( ICOFF.NE.0 ) THEN
               INFO = -5
            ELSE IF( DESCA( MB_ ).NE.DESCA( NB_ ) ) THEN
               INFO = -(600+NB_)
            END IF
         END IF
         CALL PCHK1MAT( M, 1, N, 2, IA, JA, DESCA, 6, 0, IDUM1,
     $                  IDUM2, INFO )
      END IF
*
      IF( INFO.NE.0 ) THEN
         CALL PXERBLA( ICTXT, 'PDGETRF', -INFO )
         RETURN
      END IF
*
*     Quick return if possible
*
      IF( DESCA( M_ ).EQ.1 ) THEN
         IPIV( 1 ) = 1
         RETURN
      ELSE IF( M.EQ.0 .OR. N.EQ.0 ) THEN
         RETURN
      END IF
*
*     Split-ring topology for the communication along process rows
*
      CALL PB_TOPGET( ICTXT, 'Broadcast', 'Rowwise', ROWBTOP )
      CALL PB_TOPGET( ICTXT, 'Broadcast', 'Columnwise', COLBTOP )
      CALL PB_TOPGET( ICTXT, 'Combine', 'Columnwise', COLCTOP )
      CALL PB_TOPSET( ICTXT, 'Broadcast', 'Rowwise', 'S-ring' )
      CALL PB_TOPSET( ICTXT, 'Broadcast', 'Columnwise', ' ' )
      CALL PB_TOPSET( ICTXT, 'Combine', 'Columnwise', ' ' )
*
*     Handle the first block of columns separately
*
      MN = MIN( M, N )
      IN = MIN( ICEIL( IA, DESCA( MB_ ) )*DESCA( MB_ ), IA+M-1 )
      JN = MIN( ICEIL( JA, DESCA( NB_ ) )*DESCA( NB_ ), JA+MN-1 )
      JB = JN - JA + 1

*     WRITE(*,*) 'Process Co-ordinates:', MYROW, MYCOL

      allocate(TPIV(JB))
*
*     Factor diagonal and subdiagonal blocks and test for exact
*     singularity.
*
      JJ = JN+1
      KB = MIN( MN-JJ+JA, DESCA( NB_ ) )
      II =  IA + JJ - JA

      CALL PDGETF2K( M, JB, A, IA, JA, DESCA, TPIV, INFO )
*
      IF( JB+1.LE.N ) THEN
*
*        Calculate Panel Data Size (TRSM + GEMM Inputs)
*
         CALL PDPANEL_BCSIZ( A, M, N, IA, JA, IA, JA, JB, DESCA,
     $                       PANEL(LC1) )
*
*        Allocate Panel and broadcast
*
         allocate(PANEL(LC1)%PMEM(PANEL(LC1)%PMEMSIZ))
         CALL ICOPYPV( M, JB, A, IA, JA, DESCA, TPIV, IPIV, INFO )
         CALL PDPANEL_BCAST( A, PANEL(LC1) )
         CALL PDGETF2_COMM( M, JB, A, IA, JA, DESCA, IPIV, INFO )
*
*        Update trailing matrix
*
*        WRITE(*, *) MYROW, MYCOL
         IF( MYCOL.EQ.LACOL ) THEN
            JO = JB
            FSWAP = 0
            NU = MIN(JA+2*JB-1, N)
*
*           Update small trailing matrix
*
            CALL PDUPDATE( M, NU, IA, JA, 0, JB, IA, JA, A, DESCA, TPIV,
     $                     IPIV, PANEL(LC1), PANEL(LC2), 1, 0, INFO )
*
*           Look Ahead Panel Factorization
*
            CALL PDGETF2K( M-JJ+JA, KB, A, II, JJ, DESCA, TPIV, IINFO )
            IF( INFO.EQ.0 .AND. IINFO.GT.0 )
     $          INFO = IINFO + JJ - JA
         ELSE
            NU = 0
            JO = 0
            FSWAP = 1
         END IF

*        IF( N.GT.NU ) THEN
*
*           Look Ahead Panel Broadcast Init and allocate
*
            CALL PDPANEL_BCSIZ( A, M, N, IA, JA, II, JJ, KB, DESCA,
     $                          PANEL(LC2) )
            allocate(PANEL(LC2)%PMEM(PANEL(LC2)%PMEMSIZ))
*
*           Update remaining large trailing matrix
*           and broadcast Look Ahead panel
*
            CALL PDUPDATE( M, N, IA, JA, JO, JB, IA, JA, A, DESCA, TPIV,
     $                     IPIV, PANEL(LC1), PANEL(LC2), FSWAP, 1,
     $                     INFO )
*        END IF
*
*        De-allocate Panel
*
         deallocate(PANEL(LC1)%PMEM)
      END IF

      LC1 = LC2
      LC2 = PIDX(LC2) 
*
*     Loop over the remaining blocks of columns.
*
      DO 10 J = JN+1, JA+MN-1-JB, DESCA( NB_ )
         JB = MIN( MN-J+JA, DESCA( NB_ ) )
         I = IA + J - JA

         JJ = J + DESCA( NB_ )
         II = IA + JJ - JA
         KB = MIN( MN-JJ+JA, DESCA( NB_ ) )
         LACOL = MOD( LACOL+1, NPCOL ) 
*
*        Update trailing matrix
*
*        WRITE(*, *) MYROW, MYCOL
         IF( MYCOL.EQ.LACOL ) THEN
            JO = KB
            FSWAP = 0
            NU = MIN(J+2*JB-1, N)
*
*           Update small trailing matrix
*
            CALL PDUPDATE( M, NU, I, J, 0, JB, IA, JA, A, DESCA, TPIV,
     $                     IPIV, PANEL(LC1), PANEL(LC2), 1, 0, INFO )
*
*           Look Ahead Panel Factorization
*
            CALL PDGETF2K( M-JJ+JA, KB, A, II, JJ, DESCA, TPIV, IINFO )
            IF( INFO.EQ.0 .AND. IINFO.GT.0 )
     $          INFO = IINFO + JJ - JA
         ELSE
            NU = 0
            JO = 0
            FSWAP = 1
         END IF
*        IF( N.GT.NU ) THEN
*
*           Look Ahead Panel Broadcast Init and allocate
*
            CALL PDPANEL_BCSIZ( A, M, N, IA, JA, II, JJ, KB, DESCA,
     $                          PANEL(LC2) )
            allocate(PANEL(LC2)%PMEM(PANEL(LC2)%PMEMSIZ))
*
*           Update remaining large trailing matrix
*           and broadcast Look Ahead panel
*
            CALL PDUPDATE( M, N, I, J, JO, JB, IA, JA, A, DESCA, TPIV,
     $                     IPIV, PANEL(LC1), PANEL(LC2), FSWAP, 1,
     $                     INFO )
*        END IF
*
*        De-allocate Panel
*
         deallocate(PANEL(LC1)%PMEM)
         LC1 = LC2
         LC2 = PIDX(LC2) 
*
   10 CONTINUE
*
*     CALL ICOPYPV( M-JJ+JA, KB, A, II, JJ, DESCA, TPIV, IPIV, INFO )
*     CALL PDGETF2_COMM( M-JJ+JA, KB, A, II, JJ, DESCA, IPIV, INFO )
      CALL PDUPDATE( M, N, II, JJ, 0, KB, IA, JA, A, DESCA, TPIV, IPIV,
     $               PANEL(LC1), PANEL(LC2), 1, 0, INFO )

*     IF( N.GT.NU ) THEN
         deallocate(PANEL(LC1)%PMEM)
*     END IF
      deallocate(TPIV)

      IF( INFO.EQ.0 )
     $   INFO = MN + 1
      CALL IGAMN2D( ICTXT, 'Rowwise', ' ', 1, 1, INFO, 1, IDUM1, IDUM2,
     $              -1, -1, MYCOL )
      IF( INFO.EQ.MN+1 )
     $   INFO = 0
*
      CALL PB_TOPSET( ICTXT, 'Broadcast', 'Rowwise', ROWBTOP )
      CALL PB_TOPSET( ICTXT, 'Broadcast', 'Columnwise', COLBTOP )
      CALL PB_TOPSET( ICTXT, 'Combine', 'Columnwise', COLCTOP )
*
      RETURN
*
*     End of PDGETRF
*
      END
