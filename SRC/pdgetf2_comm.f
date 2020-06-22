      SUBROUTINE PDGETF2_COMM( M, N, A, IA, JA, DESCA, IPIV, INFO )
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

      INTEGER            I, IACOL, IAROW, ICOFF, ICTXT, IIA, IROFF, J,
     $                   JJA, MN, MYCOL, MYROW, NPCOL, NPROW

*     .. Parameters ..
      INTEGER            BLOCK_CYCLIC_2D, CSRC_, CTXT_, DLEN_, DTYPE_,
     $                   LLD_, MB_, M_, NB_, N_, RSRC_
      PARAMETER          ( BLOCK_CYCLIC_2D = 1, DLEN_ = 9, DTYPE_ = 1,
     $                     CTXT_ = 2, M_ = 3, N_ = 4, MB_ = 5, NB_ = 6,
     $                     RSRC_ = 7, CSRC_ = 8, LLD_ = 9 )
  
      DOUBLE PRECISION   ONE, ZERO
      PARAMETER          ( ONE = 1.0D+0, ZERO = 0.0D+0 )
  
*     .. External Subroutines ..
      EXTERNAL           BLACS_ABORT, BLACS_GRIDINFO, CHK1MAT, IGEBR2D,
     $                   IGEBS2D, INFOG2L, PDAMAX,
     $                   PDSCAL, PDSWAP, PB_TOPGET, PXERBLA

*     ..
*     .. Executable Statements ..
*
*     Get grid parameters.
*
      ICTXT = DESCA( CTXT_ )
      CALL BLACS_GRIDINFO( ICTXT, NPROW, NPCOL, MYROW, MYCOL )


      MN = MIN( M, N )
      CALL INFOG2L( IA, JA, DESCA, NPROW, NPCOL, MYROW, MYCOL, IIA, JJA,
     $              IAROW, IACOL )
      CALL PB_TOPGET( ICTXT, 'Broadcast', 'Rowwise', ROWBTOP )
*
      IF( MYCOL.EQ.IACOL ) THEN

         CALL IGEBS2D( ICTXT, 'Rowwise', ROWBTOP, MN, 1, IPIV( IIA ),
     $                 MN )
*
      ELSE
*
         CALL IGEBR2D( ICTXT, 'Rowwise', ROWBTOP, MN, 1, IPIV( IIA ),
     $                 MN, MYROW, IACOL )
*
      END IF
*
      RETURN
*
*     End of PDGETF2_COMM
*
      END

      SUBROUTINE ICOPYPV( M, N, A, IA, JA, DESCA, TPIV, IPIV, INFO )

*     .. Scalar Arguments ..
      INTEGER            IA, INFO, JA, M, N
*     ..
*     .. Array Arguments ..
      INTEGER            DESCA( * ), IPIV( * ), TPIV( * )
      DOUBLE PRECISION   A( * )

      INTEGER            I, IACOL, IAROW, ICOFF, ICTXT, IIA, IROFF, J,
     $                   JJA, MN, MYCOL, MYROW, NPCOL, NPROW

*     .. Parameters ..
      INTEGER            BLOCK_CYCLIC_2D, CSRC_, CTXT_, DLEN_, DTYPE_,
     $                   LLD_, MB_, M_, NB_, N_, RSRC_
      PARAMETER          ( BLOCK_CYCLIC_2D = 1, DLEN_ = 9, DTYPE_ = 1,
     $                     CTXT_ = 2, M_ = 3, N_ = 4, MB_ = 5, NB_ = 6,
     $                     RSRC_ = 7, CSRC_ = 8, LLD_ = 9 )

      DOUBLE PRECISION   ONE, ZERO
      PARAMETER          ( ONE = 1.0D+0, ZERO = 0.0D+0 ) 
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


      MN = MIN( M, N )
      CALL INFOG2L( IA, JA, DESCA, NPROW, NPCOL, MYROW, MYCOL, IIA, JJA,
     $              IAROW, IACOL )
      CALL PB_TOPGET( ICTXT, 'Broadcast', 'Rowwise', ROWBTOP )
*
      IF( MYCOL.EQ.IACOL ) THEN

         CALL ICOPY( MN, TPIV, 1, IPIV ( IIA ), 1 )

      ENDIF
*
      RETURN
*
*     End of ICOPYPV
*
      END

