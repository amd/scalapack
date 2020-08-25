*  =====================================================================
*     SUBROUTINE PDUPDATE
*  =====================================================================
      SUBROUTINE PDUPDATE( M, N, I, J, JO, JB, JN, IA, JA, A, DESCA,
     $                     TPIV, IPIV, PANEL, BPANEL, DS, BCAST, INFO)
*
*  -- ScaLAPACK routine --
*     Copyright (c) 2020 Advanced Micro Devices, Inc.  All rights reserved.
*     June 10, 2020
*
*     .. Scalar Arguments ..
      INTEGER         M, N, I, J, JO, JB, JA, IA, DS, BCAST, INFO
*     ..
*     .. Array Arguments ..
      DOUBLE PRECISION   A( * )
      INTEGER            DESCA( * ), TPIV( * ), IPIV( * )
*
      TYPE PD_PANEL
           INTEGER           ::   TM, LN
           INTEGER           ::   BROWS, IAROW, IACOL
           INTEGER           ::   MYROW, MYCOL, NPROW, NPCOL
           INTEGER           ::   MSGID, ICTXT
           INTEGER           ::   XII, XJJ, LDM, LDA
           INTEGER           ::   SN, K1, K2, KB
*
           INTEGER           ::   PSIZE, UCOLS, LDU, UOFF, USIZE
*
           CLASS(*), POINTER ::   PMEM
           CLASS(*), POINTER ::   LMEM
           CLASS(*), POINTER ::   UMEM
           CLASS(*), POINTER ::   AMEM
*
           CLASS(*), POINTER ::   PBUFF
           CLASS(*), POINTER ::   DTYPE
           CLASS(*), POINTER ::   REQUEST
           CLASS(*), POINTER ::   STATUS
      END TYPE PD_PANEL
*
      TYPE(PD_PANEL) :: PANEL
      TYPE(PD_PANEL) :: BPANEL
*     ..
*
*  Purpose
*  =======
*
*  PDUPDATE computes the TRSM and trailing matrix update of
*  LU factorizattion of distributed matrix sub( A ). This function
*  is an internal function called by LU factorization using
*  lookahead panel optimization. In addition, broadcast of the
*  lookahead panel is also done interleaved with computations.
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
*  This routine requires N <= NB_A-MOD(JA-1, NB_A) and square block
*  decomposition ( MB_A = NB_A ).
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
*          columns of the distributed submatrix sub( A ).
*          NB_A-MOD(JA-1, NB_A) >= N >= 0.
*
*  I       (global input) INTEGER
*          The row index in the global array A indicating the row from
*          where the update starts.
*
*  J       (global input) INTEGER
*          The column index in the global array A indicating the column
*          from where the update starts.
*
*  JO      (global input) INTEGER
*          Column offset that has been already updated in lookhead path.
*
*  JB      (global input) INTEGER
*          Block length of panel factorization.
*
*  JN      (local input) INTEGER
*          Number of columns to be updated for the local process.
*
*  A       (local input/local output) DOUBLE PRECISION pointer into the
*          local memory to an array of dimension (LLD_A, LOCc(JA+N-1)).
*          On entry, this array contains the local pieces of the M-by-N
*          distributed matrix sub( A ). On exit, this array contains
*          the local pieces of the factors L and U from the factoriza-
*          tion sub( A ) = P*L*U; the unit diagonal elements of L are
*          not stored.
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
*  PANEL   (local input) pointer to pd_panel struct
*          The PANEL structure contains pointers to i/o matrices,  their
*          sizes &  other parameters related to lookahead implementation
*
*  BPANEL  (local input) pointer to pd_panel struct
*          The BPANEL struct points to the lookahead panel to be 
*          broadcasted. 
*
*  DS      (global input) INTEGER
*          Flag to indicate need for swap of already factorized part of
*          global matrix
*
*  BCAST   (global input) INTEGER
*          Flag to indicate need for broadcast of lookahead panel
*
*  INFO    (local output) INTEGER
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
      INTEGER           JI, SJ, NB, INB, NB_, BTEST
      INTEGER           NPCOL, MYCOL, NXCOL, IACOL, MYDIST
*
      DOUBLE PRECISION   ONE
      PARAMETER          ( ONE = 1.0D+0 )
      PARAMETER          ( NB_ = 6 )
*     ..
*     .. External Subroutines ..
      EXTERNAL     PDLASWP, PDTRSM, PDGEMM, PDGEMMLA, PDTRSMLA,
     $             PXERBLA, BLACS_ABORT, BLACS_GRIDINFO, CHK1MAT,
     $             ICOPYPV, ICOPY
*     ..
*     .. Intrinsic Functions ..
      INTRINSIC          MIN, MOD
*     ..
*     .. Executable Statements ..
*
*        Broadcast PANEL
*
      BTEST = 2
      IF( BCAST.EQ.1 )
     $    CALL PDPANEL_BCAST( A, BPANEL, BTEST )
*
*     Apply interchanges to columns JA:J-JA.
*
      IF( J-JA.GT.0 .AND. DS.EQ.1  ) THEN
          CALL PDLASWP( 'Forward', 'Rowwise', J-JA, A, IA, JA, DESCA,
     $                   I, I+JB-1, IPIV )
      END IF
*
*     Apply interchanges to columns J+JB:JA+N-1.
*
      IF( J-JA+JB+1.LE.N ) THEN
          CALL PDLASWP( 'Forward', 'Rowwise', N-J-JB+JA-JO, A, IA,
     $                   J+JB+JO, DESCA, I, I+JB-1, IPIV )
      END IF
*
      NPCOL = PANEL%NPCOL
      IF( NPCOL.EQ.1 .OR. BCAST.EQ.0 ) THEN
*
*        Qx1 Case: No panel broadcast 
*
         IF( J-JA+JB+1.LE.N ) THEN
*
*           Broadcast U
*
            CALL PDPANEL_UCAST( A, JN, I, J+JB+JO, PANEL )
*
*           Compute block row of U.
*
            CALL PDTRSMLA( 'Left', 'Lower', 'No transpose', 'Unit',
     $                      JB, JN, ONE, PANEL )
*
            IF( BCAST.EQ.1 ) THEN
               CALL ICOPYPV( BPANEL%SN, BPANEL%KB, A, BPANEL%K1,
     $                       BPANEL%K2, DESCA, TPIV, IPIV, INFO )
            END IF
*
            IF( J-JA+JB+1.LE.M ) THEN
*
*              Update trailing submatrix.
*
               CALL PDGEMMLA( 'No transpose', 'No transpose', M-J-JB+JA,
     $                         N-J-JB+JA-JO, JB, -ONE, ONE, PANEL )
            END IF
            PANEL%XJJ  = PANEL%XJJ + JN
            PANEL%UOFF = PANEL%UOFF + JN
            PANEL%LN   = PANEL%LN - JN
         END IF
      ELSE
*
*        Broadcast Panel if ready
*
         IF( BTEST.EQ.2 )
     $       CALL PDPANEL_BCAST( A, BPANEL, BTEST )
*
*        Panel broadcast Cases
*
         NB     = DESCA( NB_ )
         MYCOL  = PANEL%MYCOL
         IACOL  = PANEL%IACOL
         NXCOL  = MOD( IACOL+1, NPCOL )
         MYDIST = MOD( NPCOL+MYCOL-IACOL, NPCOL )
*
         IF( IACOL.EQ.MYCOL ) THEN
            SJ = J + NB * NPCOL - NB + JB
         ELSE IF( MYCOL.EQ.NXCOL ) THEN
            SJ = J + NB * NPCOL + JB
         ELSE
            SJ = J + MYDIST * NB - NB + JB
         END IF
*
*        Broadcast U
*
         CALL PDPANEL_UCAST( A, PANEL%LN, I, J+JB+JO, PANEL )
*
*        Broadcast Panel if ready
*
         IF( BTEST.EQ.2 )
     $       CALL PDPANEL_BCAST( A, BPANEL, BTEST )
*
*        If PFACT is done for less than NB columns
*        do the update for remaining columns
*
         IF( JO.LT.NB .AND. MYCOL.EQ.NXCOL ) THEN
            IF( JO+J-JA+JB+1.LE.N ) THEN
*
               INB = MIN( NB-JO, PANEL%LN )
*
*              Compute block row of U.
*
               CALL PDTRSMLA( 'Left', 'Lower', 'No transpose', 'Unit',
     $                         JB, INB, ONE, PANEL )
*
* 
               IF( J-JA+JB+1.LE.M ) THEN
*
*                 Update trailing submatrix.
*
                  CALL PDGEMMLA( 'No transpose', 'No transpose',
     $                            M-J-JB+JA, INB, JB, -ONE, ONE,
     $                            PANEL )
               END IF
               PANEL%XJJ  = PANEL%XJJ + INB
               PANEL%UOFF = PANEL%UOFF + INB
               PANEL%LN   = PANEL%LN - INB 
            END IF
         END IF
*
         JI = SJ
         DO WHILE ( BTEST.EQ.2 )
*
            IF( JI-JA+1.LE.N ) THEN
*
               INB = MIN( NB, N-JI+JA )
*
*              Compute block row of U.
*
               CALL PDTRSMLA( 'Left', 'Lower', 'No transpose', 'Unit',
     $                         JB, INB, ONE, PANEL )
* 
               IF( J-JA+JB+1.LE.M ) THEN
*
*                 Update trailing submatrix.
*
                  CALL PDGEMMLA( 'No transpose', 'No transpose',
     $                            M-J-JB+JA, INB, JB, -ONE, ONE,
     $                            PANEL )
               END IF
               JI = JI + NB*NPCOL
               PANEL%XJJ  = PANEL%XJJ + INB
               PANEL%UOFF = PANEL%UOFF + INB
               PANEL%LN   = PANEL%LN - INB 
            END IF
            CALL PDPANEL_BCAST( A, BPANEL, BTEST )
         END DO
*
*        Remaining columns
*
         IF( JI-JA+1.LE.N ) THEN
*
            INB = PANEL%LN
*
*           Compute block row of U.
*
            CALL PDTRSMLA( 'Left', 'Lower', 'No transpose', 'Unit',
     $                      JB, INB, ONE, PANEL )

            IF( J-JA+JB+1.LE.M ) THEN
*
*              Update trailing submatrix.
*
               INB = N-JI+JA
               CALL PDGEMMLA( 'No transpose', 'No transpose',
     $                         M-J-JB+JA, INB, JB, -ONE, ONE,
     $                         PANEL )
            END IF
         END IF
*
*        Finish broadcast and copy pivot values
*
         IF ( BCAST.EQ.1 ) THEN
              CALL PDPANEL_BWAIT( BPANEL )
              CALL ICOPYPV( BPANEL%SN, BPANEL%KB, A, BPANEL%K1,
     $                      BPANEL%K2, DESCA, TPIV, IPIV, INFO )
         END IF
      END IF
*
      RETURN
*
*     End of PDUPDATE
*
      END

