

/* ---------------------------------------------------------------------
*
*  -- AOCL ScaLAPACK routine --
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
/*
* version = "AOCL 3.0 ScaLAPACK. Supports Netlib ScaLAPACK 2.1.0"
*/
  version[ 0] = 'A';
  version[ 1] = 'O';
  version[ 2] = 'C';
  version[ 3] = 'L';
  version[ 4] = ' ';
  version[ 5] = '3';
  version[ 6] = '.';
  version[ 7] = '0';
  version[ 8] = ' ';
  version[ 9] = ' ';
  version[10] = ' ';

  return;
}

