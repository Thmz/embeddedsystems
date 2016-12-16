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
//#include "altera_avalon_pio_regs.h"
#include "io.h"
#include "system.h"

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
	LCD_WR_DATA(MH + BGR + ML + MV + MX + MY);


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
		uint16_t color;
		//if(i % 5 == 0){
			color =0x0F00;
		//}else{
		//color= 0xF000;
		//}

		for (int j = 0 ; j< 320; j++){


			uint16_t color;
					if(j % 5 == 0){
						color = 0x0FF0;
					}else{
						color = 0xFF00;
					}
			LCD_WR_DATA(color);
		}
	}


	printf("WHTIE PRINTED \n");


}

int main()
{

printf("START");
  LCD_Init();


  while(1){
	  //printf("floopooop");
	//  IOWR_32DIRECT(LT24_0_BASE, 3*4, 0x0000);

	//  IOWR_32DIRECT(LT24_0_BASE, 0*4, 0x5678);
	  //LCD_WR_REG(0x5678);
	  printf("send \n");
	  int delay = 0;
	 // printf("looping");
	  while(delay < 10000000){
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

  }

  return 0;


}
