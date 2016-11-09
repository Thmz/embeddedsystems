/*
 * Real Time Clock
 *
 * Lukas Moser - Thomas Verelst
 *
 */

#include <inttypes.h>
#include <stdio.h>
#include "system.h"
#include "io.h"

const uint8_t HUNDREDS_OFFSET = 0x1;
const uint8_t SECONDS_OFFSET  = 0x2;
const uint8_t MINUTES_OFFSET  = 0x3;

/*
Returns the 8 bit decimal equivalent of an 8 bit BCD number.
*/
uint8_t int_to_bcd(uint8_t in){
    uint8_t units = in % 10;
    uint8_t decimals = in / 10;
    return (decimals << 4) + units;
}

/*
Returns the 8 bit BCD equivalent of an 8 bit decimal number between 0 and 99
*/
uint8_t bcd_to_int(uint8_t bcd){
    return bcd % 16 + (bcd/16)*10;
}

/*
Write a decimal number between 0 and 99 (not in BCD format!) to the RTC 
*/ 
void write_rtc(uint8_t offset, int value){
   IOWR_8DIRECT(RTC_MODULE_0_BASE, ofset, int_to_bcd(value));
}

/*
Read a decimal number between 0 and 99 (not in BCD format!) from the RTC 
*/ 
uint8_t read_rtc(uint8_t offset){
   bcd_to_int(IORD_8DIRECT(RTC_MODULE_0_BASE, offset));
}


int main()
{
  printf("Hello from Nios II with RTC!\n");

  // initialize RTC to 1m30s15h
  //hundreds
  write_rtc(HUNDREDS_OFFSET, 15);
  //seconds
  write_rtc(SECONDS_OFFSET, 30);
  //minutes
  write_rtc(MINUTES_OFFSET, 1);
  
  uint32_t delay = 0;

	while (1) {

		delay = 0;
		while (delay < 1000000) {
			delay++;
		}


		uint8_t hun = read_rtc(HUNDREDS_OFFSET);
		uint8_t sec = read_rtc(SECONDS_OFFSET);
		uint8_t min = read_rtc(MINUTES_OFFSET);
		printf( "It's %dm%ds%dh \n", min,sec,hun);
	}

  return 0;
}
