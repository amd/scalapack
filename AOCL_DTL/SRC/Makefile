dlvl = ../..
include $(dlvl)/SLmake.inc

#  --------------------------
#  The aocldtl routines
#  --------------------------
dtl  = aocldtl.o aoclfal.o aoclflist.o aoclos.o

#  ----------------------------
#  The fortran and C interfaces
#  ----------------------------
Fintobj   = $(dtl)
Cintobj   = $(dtl:.o=.oo)

lib : all

$(Fintobj): aocldtl.h aocldtlcf.h aoclflist.h aoclos.h aocltpdef.h

#  ---------------------------------------
#  Make both C and fortran interface BLACS
#  ---------------------------------------
all : $(Fintobj) $(Cintobj)
	$(ARCH) $(ARCHFLAGS) ../../$(SCALAPACKLIB) $(Fintobj) $(Cintobj)
	$(RANLIB) ../../$(SCALAPACKLIB)

#  -----------------------
#  Delete the object files
#  -----------------------
clean :
	rm -f $(Cintobj) $(Fintobj)

#  ------------------------------------------------------------------------
#  We move C .o files to .oo so that we can use the portable suffix rule for
#  compilation, and still have them coexist with the fortran interface
#  .o files.
#  ------------------------------------------------------------------------

.SUFFIXES: .o .oo
.c.oo:
	$(CC) -o C$*.o -c $(CDEFS) $(CCFLAGS) -DCallFromC $<
	mv C$*.o $*.oo
.c.o:
	$(CC) -c $(CDEFS) $(CCFLAGS) $<

