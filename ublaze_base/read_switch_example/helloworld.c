#include "xparameters.h"
#include "xil_types.h"
#include "xgpio.h"
#include "xstatus.h"
#include <stdio.h>
#include "xil_printf.h"

XGpio GpioOutput;
XGpio GpioInput;

int main (void) {

  int status;
  u32 DataRead;
  u32 OldData;
  init_platform();
  // Initialize the GPIO driver so that it's ready to use,
  status = XGpio_Initialize(&GpioOutput,XPAR_GPIO_0_DEVICE_ID);
  if (status != XST_SUCCESS)
    return XST_FAILURE;
  // Set the direction for all signals to be outputs
  XGpio_SetDataDirection(&GpioOutput, 1, 0x0);

  // Initialize the GPIO driver so that it's ready to use,
  status = XGpio_Initialize(&GpioInput,XPAR_GPIO_0_DEVICE_ID);
  if (status != XST_SUCCESS)
    return XST_FAILURE;
  // Set the direction for all signals to be inputs
  XGpio_SetDataDirection(&GpioInput, 2, 0x1);


  OldData = 0xFFFFFFFF;
  while(1){
	// Read the state of the DIP switches
    DataRead = XGpio_DiscreteRead(&GpioInput, 2);
    // Send the data to the UART if the settings change
    if(DataRead != OldData){
      xil_printf("valor DIP switches: %d\r\n", DataRead);

      // Set the GPIO outputs to the DIP switch values
      XGpio_DiscreteWrite(&GpioOutput, 1, DataRead);
      // Record the DIP switch settings
      OldData = DataRead;
    }
  }
  return 0;
}
