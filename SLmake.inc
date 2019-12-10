############################################################################
#
#  Program:         ScaLAPACK
#
#  Module:          SLmake.inc
#
#  Purpose:         Top-level Definitions
#
#  Creation date:   November 05, 2019
#
#  Modified:        December 10, 2019
#
#
############################################################################
#
#  C preprocessor definitions:  set CDEFS to one of the following:
#
#     -DNoChange (fortran subprogram names are lower case without any suffix)
#     -DUpCase   (fortran subprogram names are upper case without any suffix)
#     -DAdd_     (fortran subprogram names are lower case with "_" appended)

CDEFS         = -DAdd_

#
#  The fortran and C compilers, loaders, and their flags
#

FC            = mpif90
CC            = mpicc 
NOOPT         = -O0
FCFLAGS       = -cpp -DLIBFLAME -O3
# Comment the above line when not linking with LibFlame and Uncomment the below line
#FCFLAGS       = -O3 
CCFLAGS       = -O3
FCLOADER      = $(FC)
CCLOADER      = $(CC)
FCLOADFLAGS   = $(FCFLAGS)
CCLOADFLAGS   = $(CCFLAGS)

#
#  The archiver and the flag(s) to use when building archive (library)
#  Also the ranlib routine.  If your system has no ranlib, set RANLIB = echo
#

ARCH          = ar
ARCHFLAGS     = cr
RANLIB        = ranlib

#
#  The name of the ScaLAPACK library to be created
#

SCALAPACKLIB  = libscalapack.a

#
#  BLAS, LAPACK (and possibly other) libraries needed for linking test programs
#

#BLASLIB       = -lblas
#LAPACKLIB     = -llapack

# AMD optimized Scalapack requires 'Blis' and 'LibFlame' libraries pre-installed.
# Provide Blis and LibFlame library paths (as below)
BLASLIB_PATH   :=
LAPACKLIB_PATH :=

BLASLIB       = $(BLASLIB_PATH)/libblis.a
LAPACKLIB     = $(LAPACKLIB_PATH)/libflame.a

LIBS          = $(LAPACKLIB) $(BLASLIB)
