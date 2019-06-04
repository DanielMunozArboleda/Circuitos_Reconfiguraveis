//=========================================================//
//   Advanced Workshop on FPGA-based Systems-on-Chip for   //
// Scientific Instrumentation and Reconfigurable Computing //
//                                                         //
//                          Lab                            //
//                    GPIO IP Cores in PL                  //
//                                                         //
//                                                         //
//=========================================================//
//-----------------------------------------------------------
//-- File       : lab_gpio_in_out.c
//-- Author     : Cristian
//-- Company    : ICTP-MLAB
//-- Created    : 2018-11-08
//-- Last update: 2018-11-09
//-----------------------------------------------------------
//-- Description: Simple 'C' code to read from the switches 
//-- and write to the LEDs through two GPIO IP Cores. It also
//-- write to LED9 controlled by the PS.
//-----------------------------------------------------------
//-- Copyright (c) 2018 
//-----------------------------------------------------------
//-- Revisions  :
//-- Date        Version   Author           Description
//-- 2018-11-08   1.0    Crisitan-Liz        Created
//-----------------------------------------------------------

#include "xparameters.h"
#include "xgpio.h"
#include "xgpiops.h"

static XGpioPs psGpioInstancePtr;
static int iPinNumber = 7; /*Led LD9 is connected to MIO pin 7*/

//====================================================

int main (void) 
{

      XGpio sw, led;
	  int i, pshb_check, sw_check;
	  static XGpio GPIOInstance_Ptr;
	  XGpioPs_Config*GpioConfigPtr;
	  int xStatus;
	  int iPinNumberEMIO = 54;
	  u32 uPinDirectionEMIO = 0x0;
	  u32 uPinDirection = 0x1;
	
	  xil_printf("-- Start of the Program --\r\n");

	  // AXI GPIO switches Intialization
	  ???(&sw, XPAR_BOARD_SW_8B_DEVICE_ID);

	  // AXI GPIO leds Intialization
	  ???(&???, XPAR_BOARD_LEDS_8B_DEVICE_ID);

	  // ------     PS GPIO Intialization
	  GpioConfigPtr = XGpioPs_LookupConfig(XPAR_PS7_GPIO_0_DEVICE_ID);
	  if(GpioConfigPtr == NULL)
	    return XST_FAILURE;
	  
	  xStatus = XGpioPs_CfgInitialize(&psGpioInstancePtr,
	      GpioConfigPtr,
	      GpioConfigPtr->BaseAddr);
	  
	  if(XST_SUCCESS != xStatus)
	    print(" PS GPIO INIT FAILED \n\r");
	  
	  // ------    PS GPIO pin setting to Output
	  XGpioPs_SetDirectionPin(&psGpioInstancePtr, iPinNumber,uPinDirection);
	  XGpioPs_SetOutputEnablePin(&psGpioInstancePtr, iPinNumber,1);
	  
	  // ------    EMIO PIN Setting to Input port
	  XGpioPs_SetDirectionPin(&psGpioInstancePtr,
	      iPinNumberEMIO,uPinDirectionEMIO);
	  XGpioPs_SetOutputEnablePin(&psGpioInstancePtr, iPinNumberEMIO,0);

	  xil_printf("-- Press BTNR to see LED9 lit --\r\n");
	  xil_printf("-- Change slide switches to see corresponding output on LEDs --\r\n");
	  xil_printf("-- Set slide switches to 0xFF to exit the program --\r\n");

	  while (1)
	  {
		  //--- reading SW
		  sw_check = XGpio_DiscreteRead(&???, 1);
		  //--- Writing to LEDs
		  XGpio_DiscreteWrite(&???, 1, ????);
          
          //--- PS LEDs
	      pshb_check = XGpioPs_ReadPin(&psGpioInstancePtr,iPinNumberEMIO);
          XGpioPs_WritePin(&psGpioInstancePtr,iPinNumber,pshb_check);
          
          //--- check if SW are all '1'
          if(???? == 0xFF)
        	  break;
		  for (i=0; i<9999999; i++); // delay loop
	   }
	  
	  xil_printf("-- End of Program --\r\n");
	  
	  return 0;
}
 
