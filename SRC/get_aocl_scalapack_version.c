

/* ---------------------------------------------------------------------
*
*  -- AOCL ScaLAPACK routine (version 2.2.1) --
*     Copyright (c) 2020 Advanced Micro Devices, Inc.  All rights reserved.
*     July 13, 2020
*
*  ---------------------------------------------------------------------
*/

/*
 * Include Files
 */
#include <stdio.h>

#ifdef __STDC__
void get_aocl_scalapack_version_( char * version )
#else
void get_aocl_scalapack_version_( version )
   char * version;
#endif
{

  //  version = "AOCL x.y ScaLAPACK. Baseline Netlib ScaLAPACK m.n.p";
  version[ 0] = 'A';
  version[ 1] = 'O';
  version[ 2] = 'C';
  version[ 3] = 'L';
  version[ 4] = ' ';
  version[ 5] = '2';
  version[ 6] = '.';
  version[ 7] = '2';
  version[ 8] = '.';
  version[ 9] = '1';
  version[10] = ' ';

  return;
}

