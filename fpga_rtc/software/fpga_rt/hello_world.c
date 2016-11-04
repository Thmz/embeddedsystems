/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <inttypes.h>
#include <stdio.h>
#include "system.h"
#include "io.h"

int main()
{
  printf("Hello from Nios II!\n");
  /*
  //init
  IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x1, 0x0);
  IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x2, 0x0);
  IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x3, 0x0);
  //*/

  ///*end
  //hundreds
  IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x1, 0x0);
  //seconds
   IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x2, 0b01010101);
   //minutes
   IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x3, 0b10011001);
   //*/
  return 0;
}
