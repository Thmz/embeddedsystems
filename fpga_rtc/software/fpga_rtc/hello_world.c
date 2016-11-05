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

  ///*1m30s
  //hundreds
  IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x1, 0x0);
  //seconds
   IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x2, 0b00110000);
   //minutes
   IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x3, 0b00000001);
   //*/

   /*end
   //hundreds
   IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x1, 0x0);
   //seconds
    IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x2, 0b01010101);
    //minutes
    IOWR_8DIRECT(RTC_MODULE_0_BASE, 0x3, 0b10011001);
    //*/

	while (1) {
		int delay = 0;
		while (delay < 800000) {
			delay++;
		}
		uint8_t hun = IORD_8DIRECT(RTC_MODULE_0_BASE, 0x1);
		hun = hun % 16 + (hun/16)*10;
		uint8_t sec = IORD_8DIRECT(RTC_MODULE_0_BASE, 0x2);
		sec = sec % 16 + (sec/16)*10;
		uint8_t min = IORD_8DIRECT(RTC_MODULE_0_BASE, 0x3);
		min = min % 16 + (min/16)*10;
		printf( "It's %d:%d:%d \n", min,sec,hun);
	}

  return 0;
}
