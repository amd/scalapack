*  =====================================================================
*     SUBROUTINE PDUPDATE
*  =====================================================================
      SUBROUTINE PDUPDATE( M, N, I, J, JO, JB, IA, JA, A, DESCA, 
     $                    IPIV, PANEL, DS, INFO)
*
*  -- ScaLAPACK routine (version 2.1.0) --
*     Copyright (c) 2020 Advanced Micro Devices, Inc.  All rights reserved.
*     June 10, 2020
*
*     .. Scalar Arguments ..
      INTEGER         M, N, I, J, JO, JB, JA, IA, DS, INFO
*     ..
*     .. Array Arguments ..
      DOUBLE PRECISION   A( * )
      INTEGER            DESCA( * ), IPIV( * )
*
      TYPE PD_PANEL
           INTEGER   ::   TM, TN, GM, GN, LDA
           INTEGER   ::   BROWS, BCOLS, FSEND, IACOL, MYROW
           INTEGER   ::   FCAST, ICTXT, XII, XJJ, LDM
           INTEGER   ::   PMEMSIZ
           DOUBLE PRECISION, allocatable :: PMEM (:)
      END TYPE PD_PANEL
*
      TYPE(PD_PANEL) :: PANEL 
*
      DOUBLE PRECISION   ONE
      PARAMETER          ( ONE = 1.0D+0 )
*     ..
*     .. External Subroutines ..
      EXTERNAL     PDLASWP, PDTRSM, PDGEMM, PDGEMMLA, PXERBLA
     $              BLACS_ABORT, BLACS_GRIDINFO, CHK1MAT
*     ..
*     .. Executable Statements ..
*
*     Apply interchanges to columns JA:J-JA.
*
      IF( J-JA.GT.0 .AND. DS.EQ.1  ) THEN
         CALL PDLASWP( 'Forward', 'Rowwise', J-JA, A, IA, JA, DESCA,
     $                 I, I+JB-1, IPIV )
      END IF
*
*     WRITE(*, *) JO, M-J-JB+JA, N-J-JB+JA-JO, J-JA+JB+1, N
      IF( J-JA+JB+1.LE.N ) THEN
*
*        Apply interchanges to columns J+JB:JA+N-1.
*
         CALL PDLASWP( 'Forward', 'Rowwise', N-J-JB+JA-JO, A, IA,
     $                 J+JB+JO, DESCA, I, I+JB-1, IPIV )
*
*        Compute block row of U.
*
         CALL PDTRSMLA( 'Left', 'Lower', 'No transpose', 'Unit', JB,
     $                N-J-JB+JA-JO, ONE, A, I, J, DESCA, A, I, J+JB+JO,
     $                DESCA, PANEL, PANEL%PMEM )
*
         IF( J-JA+JB+1.LE.M ) THEN
*
*           Update trailing submatrix.
*
            CALL PDGEMMLA( 'No transpose', 'No transpose', M-J-JB+JA,
     $                     N-J-JB+JA-JO, JB, -ONE, A, I+JB, J, DESCA, A,
     $                     I, J+JB+JO, DESCA, ONE, A, I+JB, J+JB+JO,
     $                     DESCA, PANEL, PANEL%PMEM )
         END IF
      END IF
*
      RETURN
*
*     End of PDUPDATE
*
      END
