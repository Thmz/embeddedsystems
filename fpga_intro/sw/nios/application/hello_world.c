#include <inttypes.h>
#include <stdio.h>
#include "system.h"
#include "io.h"

int main() {
//  printf("Hello from Nios II!\n");
//  uint32_t pio_data = IORD_ALTERA_AVALON_PIO_DATA(PIO_0_BASE);
//  return 0;
	uint8_t count = 0x01;
	int delay;
	printf("Hello from Nios II!\n");


	// Switch
	IOWR_8DIRECT(PARALLELPORT2_0_BASE, 0x0, 0x0);

	// LED
	IOWR_8DIRECT(PARALLELPORT2_1_BASE, 0x0, 0xFF);

	while (1) {
//		IOWR(PARALLELPORT2_1_BASE, 0x0, count);
		delay = 0;
		while (delay < 800000) {
			delay++;
		}
//		count = count << 1;
//		if(count == 0x0) count = 0x01;

		// 0 is switch
		uint8_t pio_data = IORD_8DIRECT(PARALLELPORT2_0_BASE, 0x1);

		IOWR_8DIRECT(PARALLELPORT2_1_BASE, 0x2, pio_data);
		printf( " %d", pio_data);
	}
	return 0;
}
