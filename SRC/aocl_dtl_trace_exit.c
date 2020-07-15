

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
#include <string.h>
#include "../AOCL_DTL/SRC/aocldtl.h"

#ifdef __STDC__
void aocl_dtl_trace_exit_( const char * fileName, unsigned int * lineNumber,
                           const char * message )
#else
void aocl_dtl_trace_exit_( fileName, lineNumber, message )
  const char   * fileName;
  unsigned int * lineNumber;
  const char   * message;
#endif
{
#if AOCL_DTL_TRACE_ENABLE 
  char * funcName = NULL;
  int    i, fnlen, cval;

  fnlen = strlen( fileName );
  funcName = (char *) malloc( fnlen );

  if( funcName != NULL)
  {
    strncpy( funcName, fileName, fnlen );
  
    funcName[ fnlen - 2 ] = '\0';

    i = 0;
    while( funcName[ i ] != '\0' )
    {
      cval = (int) funcName[ i ];
      if( cval >= 'a'  && cval <= 'z' )
      {
        cval -= 32;
      }

      funcName[ i ] = cval;
      i++;
    }

    DTL_Trace( AOCL_DTL_TRACE_LEVEL, TRACE_TYPE_FEXIT, fileName, funcName,
               *lineNumber, NULL );
  
    free( funcName );
  }
  else
  {
    DTL_Trace( AOCL_DTL_TRACE_LEVEL, TRACE_TYPE_FEXIT, fileName, fileName,
               *lineNumber, NULL );
  }
#endif
  return;
}


