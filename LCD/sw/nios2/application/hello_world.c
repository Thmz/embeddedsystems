/*

#include <assert.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>

#include "io.h"
#include "system.h"

//#define HPS_0_BRIDGES_BASE (0x0000)            /* address_span_expander base address from system.h (ADAPT TO YOUR DESIGN)
//#define HPS_0_BRIDGES_SPAN (256 * 1024 * 1024) /* address_span_expander span from system.h (ADAPT TO YOUR DESIGN)

#define ONE_MB (1024 * 1024)

int main(void) {
    uint32_t megabyte_count = 0;

    printf("sizeof %d \n",sizeof(uint32_t));

    for (uint32_t i = 0; i < HPS_0_BRIDGES_SPAN; i += sizeof(uint32_t)) {

        // Print progress through 256 MB memory available through address span expander
        if ((i % ONE_MB) == 0) {
            //printf("megabyte_count = %" PRIu32 "\n", megabyte_count);
        	printf("megabyte_count = %d \n", megabyte_count);
            megabyte_count++;
        }

        uint32_t addr = HPS_0_BRIDGES_BASE + i;

        // Write through address span expander
        uint32_t writedata = i;
        IOWR_32DIRECT(addr, 0, writedata);

        // Read through address span expander
        uint32_t readdata = IORD_32DIRECT(addr, 0);

        // Check if read data is equal to written data
        assert(writedata == readdata);
        if (writedata == readdata){
        	//printf("ok %d \n",i);
        }
    }

    return EXIT_SUCCESS;
}





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
 */


#include <inttypes.h>
#include <stdio.h>
#include <assert.h>
#include <stdlib.h>

//#include "altera_avalon_pio_regs.h"
#include "io.h"
#include "system.h"

#define ONE_MB (1024 * 1024)

uint32_t ISBUSY() { // Busy if first bit of length reg is 1
	uint32_t len_reg = IORD_32DIRECT(LT24_0_BASE,3*4);
	uint32_t temp = 1;
	return len_reg & (temp << 31);
}

void LCD_SET_DMA_LENGTH(uint32_t len) {
	while(ISBUSY()>0){}
	IOWR_32DIRECT(LT24_0_BASE, 3*4, len);
}


void LCD_SHOW_FRAME(uint32_t addr) {
	while(ISBUSY()>0){}
	IOWR_32DIRECT(LT24_0_BASE, 2*4, addr);
}


void LCD_WR_REG(uint32_t cmd) {
	while(ISBUSY()>0){}
	IOWR_32DIRECT(LT24_0_BASE, 0*4, cmd);
}

void LCD_WR_DATA(uint32_t data) {
	while(ISBUSY()>0){}
	IOWR_32DIRECT(LT24_0_BASE, 1*4, data);
}

void LCD_RST(){
	while(ISBUSY()>0){}
	//IOWR_32DIRECT(LT24_0_BASE, 2*4, '0x00000080');
	IOWR_32DIRECT(LT24_0_BASE, 0*4, '0x00008000');
}



void LCD_Init()
{
	printf("INIT STARTED \n");

	LCD_RST();
	//Delay_Ms(1);
	//Clr_LCD_RST;
	//Delay_Ms(10);       // Delay 10ms // This delay time is necessary
	//Set_LCD_RST;
	//Delay_Ms(120);       // Delay 120 ms
//	Clr_LCD_CS;



	LCD_WR_REG(0x0011); //Exit Sleep
	LCD_WR_REG(0x00CF);
		LCD_WR_DATA(0x0000);
		LCD_WR_DATA(0x0081);
		LCD_WR_DATA(0X00c0);

	LCD_WR_REG(0x00ED);
		LCD_WR_DATA(0x0064);
		LCD_WR_DATA(0x0003);
		LCD_WR_DATA(0X0012);
		LCD_WR_DATA(0X0081);

	LCD_WR_REG(0x00E8);
		LCD_WR_DATA(0x0085);
		LCD_WR_DATA(0x0001);
		LCD_WR_DATA(0x00798);

	LCD_WR_REG(0x00CB);
		LCD_WR_DATA(0x0039);
		LCD_WR_DATA(0x002C);
		LCD_WR_DATA(0x0000);
		LCD_WR_DATA(0x0034);
		LCD_WR_DATA(0x0002);

	LCD_WR_REG(0x00F7);
		LCD_WR_DATA(0x0020);

	LCD_WR_REG(0x00EA);
		LCD_WR_DATA(0x0000);
		LCD_WR_DATA(0x0000);

	LCD_WR_REG(0x00B1);
		LCD_WR_DATA(0x0000);
		LCD_WR_DATA(0x001b);

	LCD_WR_REG(0x00B6);
		LCD_WR_DATA(0x000A);
		LCD_WR_DATA(0x00A2);

	LCD_WR_REG(0x00C0);    //Power control
		LCD_WR_DATA(0x0005);   //VRH[5:0]

	LCD_WR_REG(0x00C1);    //Power control
		LCD_WR_DATA(0x0011);   //SAP[2:0];BT[3:0]

	LCD_WR_REG(0x00C5);    //VCM control
		LCD_WR_DATA(0x0045);       //3F
		LCD_WR_DATA(0x0045);       //3C

	 LCD_WR_REG(0x00C7);    //VCM control2
		 LCD_WR_DATA(0X00a2);

	 LCD_WR_REG(0x0036);    // Memory Access Control will be overwritten below
		LCD_WR_DATA(0x0008);//48

	LCD_WR_REG(0x00F2);    // 3Gamma Function Disable
		LCD_WR_DATA(0x0000);

	LCD_WR_REG(0x0026);    //Gamma curve selected
		LCD_WR_DATA(0x0001);

	LCD_WR_REG(0x00E0);    //Set Gamma
		LCD_WR_DATA(0x000F);
		LCD_WR_DATA(0x0026);
		LCD_WR_DATA(0x0024);
		LCD_WR_DATA(0x000b);
		LCD_WR_DATA(0x000E);
		LCD_WR_DATA(0x0008);
		LCD_WR_DATA(0x004b);
		LCD_WR_DATA(0X00a8);
		LCD_WR_DATA(0x003b);
		LCD_WR_DATA(0x000a);
		LCD_WR_DATA(0x0014);
		LCD_WR_DATA(0x0006);
		LCD_WR_DATA(0x0010);
		LCD_WR_DATA(0x0009);
		LCD_WR_DATA(0x0000);

	LCD_WR_REG(0X00E1);    //Set Gamma
		LCD_WR_DATA(0x0000);
		LCD_WR_DATA(0x001c);
		LCD_WR_DATA(0x0020);
		LCD_WR_DATA(0x0004);
		LCD_WR_DATA(0x0010);
		LCD_WR_DATA(0x0008);
		LCD_WR_DATA(0x0034);
		LCD_WR_DATA(0x0047);
		LCD_WR_DATA(0x0044);
		LCD_WR_DATA(0x0005);
		LCD_WR_DATA(0x000b);
		LCD_WR_DATA(0x0009);
		LCD_WR_DATA(0x002f);
		LCD_WR_DATA(0x0036);
		LCD_WR_DATA(0x000f);

	LCD_WR_REG(0x002A);
		LCD_WR_DATA(0x0000);
		LCD_WR_DATA(0x0000);
		LCD_WR_DATA(0x0000);
		LCD_WR_DATA(0x00ef);

	 LCD_WR_REG(0x002B);
		LCD_WR_DATA(0x0000);
		LCD_WR_DATA(0x0000);
		LCD_WR_DATA(0x0001);
		LCD_WR_DATA(0x003f);

	LCD_WR_REG(0x003A);
		LCD_WR_DATA(0x0055);

	LCD_WR_REG(0x00f6);
		LCD_WR_DATA(0x0001);
		LCD_WR_DATA(0x0030);
		LCD_WR_DATA(0x0000);



	// Change MADCTL
    // Set LCD in reverse mode (row/column) exchange:  MADCTL B5='1'
    // BGR: MADCTL B3='1'
	LCD_WR_REG(0x0036);

	int32_t MH  = 1 <<2;
	int32_t BGR = 1 <<3;
	int32_t ML  = 1 <<4;
	int32_t MV  = 1 <<5;
	int32_t MX  = 1 <<6;
	int32_t MY  = 1 <<7;
	LCD_WR_DATA(MH + BGR + ML + MV + MY);


	// Change adresses

	// Column
	LCD_WR_REG(0x002A);
	LCD_WR_DATA(0x0000);
	LCD_WR_DATA(0x0000);
	LCD_WR_DATA(0x0001);
	LCD_WR_DATA(0x003F);

	// Row
	LCD_WR_REG(0x002B);
	LCD_WR_DATA(0x0000);
	LCD_WR_DATA(0x0000);
	LCD_WR_DATA(0x0000);
	LCD_WR_DATA(0x00EF);


	LCD_WR_REG(0x0029); //display on

	LCD_WR_REG(0x002c);    // 0x2C

	printf("INIT DONE \n");

	// Clear screen
	for (int i = 0; i < 240; i++) {
		//uint16_t color;
		//if(i % 5 == 0){
			//color =0xFFFF;
		//}else{
		//color= 0xF000;
		//}

		for (int j = 0 ; j< 320; j++){
			uint16_t color;
					if(j % 10 == 0){
						color = 0x000F;
					}else{
						color = 0xF000;
					}
			LCD_WR_DATA(color);
		}
	}


	printf("WHTIE PRINTED \n");


}


void LCD_Easy(int it){
		//LCD_WR_REG(0x0029); //display on

		LCD_WR_REG(0x002c);    // 0x2C


		// Clear screen
		for (int i = 0; i < 180; i++) {
			//uint16_t color;
			//if(i % 5 == 0){
				//color =0xFFFF;
			//}else{
			//color= 0xF000;
			//}

			for (int j = 0 ; j< 320; j++){
				uint16_t color;
						if(j % 30 < 5){
							color = 0xF800;//blue !!! in fact red
						}else{
							if (j % 30 < 20 ){
								color = 0x07E0+it*4;//green
							}else{
								color = 0x001F;//red !!! in fact blue
							}
						}
				LCD_WR_DATA(color);
			}
		}


		printf("WHTIE PRINTED \n");

}



void LCD_Pic(int it){
		//LCD_WR_REG(0x0029); //display on

		LCD_WR_REG(0x002c);    // 0x2C
		
			char* filename = "/mnt/host/crazy_wall.bin" ;
			FILE *foutput = NULL;
			foutput = fopen(filename, "rb");
			if (!foutput){
				printf("Error: could not open \"%s\" for reading\n", filename);
			}


		printf("ok before bef be\n");
		// Clear screen
		for (int i = 0; i < 160 * 240; i++) {
			uint16_t color;
			color = 0xF000; //-- roughly red

			
			unsigned char buffer[4];

			fread(buffer,sizeof(buffer),1,foutput);
			
			color = (buffer[2]<<8) + buffer[3];
			LCD_WR_DATA(color);
			
			color = (buffer[0]<<8) + buffer[1];
			LCD_WR_DATA(color);			

		}
		/*
		printf("ok before bef\n");

		char* filename = "/mnt/host/workfile.bin" ;
		printf("ok before\n");
		//LCD_WR_DATA(0x07E0);
		FILE *foutput = NULL;
		foutput = fopen(filename, "rb");
		LCD_WR_DATA(0x07E0);
		if (!foutput)
		{
			printf("Error: could not open \"%s\" for reading\n", filename);
		}

		printf("ok\n");
		LCD_WR_DATA(0x07E0);
	    unsigned char buffer[4];


	    fread(buffer,sizeof(buffer),1,foutput); // read 4 bytes to our buffer

	    unsigned int pix = (buffer[0]<<24) + (buffer[1]<<16) + (buffer[2]<<8) + buffer[3];
	    printf("u = %u\n",pix);
			*/
		printf("WHTIE PRINTED \n");

}


void WR_LEN(uint32_t len) {
	while(ISBUSY()>0){}
	IOWR_32DIRECT(LT24_0_BASE, 3*4, len);
}

void WR_ADDR(uint32_t addr) {
	while(ISBUSY()>0){}
	IOWR_32DIRECT(LT24_0_BASE, 2*4, addr);
}

uint32_t RD_LEN() {
	while(ISBUSY()>0){}
	return IORD_32DIRECT(LT24_0_BASE, 3*4);
}

uint32_t RD_ADDR() {
	while(ISBUSY()>0){}
	return IORD_32DIRECT(LT24_0_BASE, 2*4);
}


void RAM_Init(){
	uint32_t megabyte_count = 0;
	//ONLY one MB
	printf("in ram\n");
	for (uint32_t i = 0; i < HPS_0_BRIDGES_SPAN/256 + 1; i += sizeof(uint32_t)) {

	        // Print progress through 256 MB memory available through address span expander
	        if ((i % ONE_MB) == 0) {
	            //printf("megabyte_count = %" PRIu32 "\n", megabyte_count);
	        	printf("megabyte_count = %d \n", megabyte_count);
	            megabyte_count++;
	        }

	        uint32_t addr = HPS_0_BRIDGES_BASE + i;

	        // Write through address span expander
	        uint32_t writedata = 0x07E007E0;//0x0;//i;//0x12345678;
	        IOWR_32DIRECT(addr, 0, writedata);

	        // Read through address span expander
	        uint32_t readdata = IORD_32DIRECT(addr, 0);

	        // Check if read data is equal to written data
	        assert(writedata == readdata);
	}

}



void RAM_Init_Pic(uint32_t start, char* filename ){


	FILE *foutput = NULL;
	foutput = fopen(filename, "rb");
	if (!foutput){
		printf("Error: could not open \"%s\" for reading\n", filename);
	}

	printf("in ram file open\n");
	for (uint32_t i = start; i < 160*240*sizeof(uint32_t)+start; i += sizeof(uint32_t)) {

			unsigned char buffer[4];

			fread(buffer,sizeof(buffer),1,foutput);

	        uint32_t addr = HPS_0_BRIDGES_BASE + i;

	        // Write through address span expander
	        uint32_t writedata = (buffer[0]<<24) + (buffer[1]<<16) + (buffer[2]<<8) + buffer[3];
	        IOWR_32DIRECT(addr, 0, writedata);

	        // Read through address span expander
	        uint32_t readdata = IORD_32DIRECT(addr, 0);

	        // Check if read data is equal to written data
	        assert(writedata == readdata);
	}

}


void Start_DMA(uint32_t len,uint32_t addr){
	//init len
	printf("addr = %d\n",addr);
	WR_LEN(len);
	uint32_t rd_len = RD_LEN();

	if (len == rd_len){
		printf("ok rd_len = %d\n",rd_len);
	}

	//!!! start DMA

	//WR_ADDR(addr);
	printf("stated dma \n");
	uint32_t rd_addr = RD_ADDR();

	if (addr == rd_addr){
		printf("ok rd_addr = %d\n",rd_addr);
	}

}

int main(void) {

  printf("START ");
  LCD_Init();
  Start_DMA(38400,HPS_0_BRIDGES_BASE);

  char* filename = "/mnt/host/crazy_wall.bin" ;
  RAM_Init_Pic(0,filename);
  char* filename2 = "/mnt/host/belgium.bin" ;
  RAM_Init_Pic(5*4*160*240,filename2);
  char* filename3 = "/mnt/host/lakeside.bin" ;
  RAM_Init_Pic(10*4*160*240,filename3);




  int it = 0;
  while(it<4){

	  int delay = 0;


	  while(delay < 10000000){
	  		//  printf("looping");
	  		delay++;
	  }
	  WR_ADDR(it*5*4*160*240);

	  int i = 0;
	  while(ISBUSY()>0){
		  i++;
	  }
	  it++;
	  printf("cycle during busy %d \n",i);
	  //LCD_Pic(it);
	  //LCD_Easy(it);
  }

  printf("done ");
  return 0;
}

 // StartDMA(address);
/*
  while(1){
	  //printf("floopooop");
	//  IOWR_32DIRECT(LT24_0_BASE, 3*4, 0x0000);

	//  IOWR_32DIRECT(LT24_0_BASE, 0*4, 0x5678);
	  //LCD_WR_REG(0x5678);
	  printf("send \n");
	  int delay = 0;
	 // printf("looping");
	  while(delay < 100000000){
		//  printf("looping");
		  delay++;
	  }

	 // printf("test");
	  //int test = IORD_32DIRECT(LT24_0_BASE,3*4)+1;
	 // printf("received \n");

	   delay = 0;
	  while(delay < 100){
	  		//  printf("looping");
	  		  delay++;
	  	  }
	 // printf("%d", test);
  }*/


//*/
