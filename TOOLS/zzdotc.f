      SUBROUTINE ZZDOTC( N, DOTC, X, INCX, Y, INCY )
*
*  -- ScaLAPACK tools routine (version 1.7) --
*     University of Tennessee, Knoxville, Oak Ridge National Laboratory,
*     and University of California, Berkeley.
*     May 1, 1997
*
*     .. Scalar Arguments ..
      INTEGER            INCX, INCY, N
      COMPLEX*16         DOTC
*     ..
*     .. Array Arguments ..
      COMPLEX*16         X( * ), Y( * )
*     ..
*
*  Purpose
*  =======
*
*  ZZDOTC is a simple FORTRAN wrapper around the BLAS function
*  ZDOTC returning the result in the parameter list instead.
*
*  =====================================================================
*
*     .. External Functions ..
      COMPLEX*16         ZDOTC
      EXTERNAL           ZDOTC
#ifdef F2C_COMPLEX
      EXTERNAL           ZDOTC_F2C
#endif
*     ..
*     .. Executable Statements ..
*
#ifdef F2C_COMPLEX
      CALL ZDOTC_F2C( DOTC, N, X, INCX, Y, INCY )
#else
      DOTC = ZDOTC( N, X, INCX, Y, INCY )
#endif
*
      RETURN
*
*     End of ZZDOTC
*
      END
