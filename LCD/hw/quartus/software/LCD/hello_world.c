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
#include "system.h";


LCD_BASE = 0x0000;

void LCD_WR_REG(int cmd) {

	IOWR_32DIRECT(LCD_BASE, 0, cmd);

}

void LCD_WR_DATA(int data) {
	IOWR_32DIRECT(LCD_BASE, 1, data);
}

void LCD_RST(){
	IOWR_32DIRECT(LCD_BASE, 2, '0x0080');
}



void LCD_Init()
{

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
	LCD_WR_REG(0x0036);    // Memory Access Control will be overwritten below
	LCD_WR_DATA(0x0028);

	LCD_WR_REG(0x0029); //display on

	LCD_WR_REG(0x002c);    // 0x2C



}

int main()
{
  printf("Hello from Nios II!\n");

 // LCD_Init();

  printf("HERE");
  while(1){
	  printf("lOop");
	  IOWR_32DIRECT(LCD_BASE, 3, 0x8765);
	  printf(IORD_32DIRECT(LCD_BASE, 0));

  }

  return 0;


}
