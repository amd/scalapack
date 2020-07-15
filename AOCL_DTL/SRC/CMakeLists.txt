##Copyright (C) 2020, Advanced Micro Devices, Inc ##

#  ---------------------
#  The aocldtl routines
#  ---------------------
set (dtl
      aocldtl.c aoclfal.c aoclflist.c aocllos.c )


#
# Note on CMAKE (from Brad - Kitware)
#
#CMake hides the intermediate object files from its interface so there is
#no direct way to do this within a single target.  This limitation comes
#from the requirement to support generation of build systems like VS IDE
#project files that do not expose object files explicitly.

# Solution 1 : Build separate libraries, one for each block of objects
#set(blacsFint ${comm} ${supp})
#add_library(blacsCint ${comm} ${supp})
#set_property(TARGET blacsCint PROPERTY COMPILE_DEFINITIONS CallFromC)
#add_library(scalapack ${internal} ${blacsFint})
#target_link_libraries(scalapack blacsCint)

# Solution 2 : Create an extra source file that #include-s the original one
set(srcs ${dtl})
set(srcs_C)
foreach(src ${srcs})
#  string(REPLACE ".c" "-C.c" src_C "${CMAKE_CURRENT_BINARY_DIR}/${src}")
  string(REPLACE ".c" "-C.c" src_C "${src}")
  configure_file(src-C.c.in ${src_C} @ONLY)
  list(APPEND srcs_C ${src_C})
endforeach()

set(aocldtl ${srcs} ${srcs_C} ${dtl})
#add_library(scalapack ${srcs} ${srcs_C} ${internal})
#scalapack_install_library(scalapack)

