/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xtmrctr.h"
#include "xparameters.h"
#include "FPadd.h"
#include "xstatus.h"
#include "xbasic_types.h"

union
{
    Xuint8 u8[4];
    Xuint32 u32;
    Xfloat32 f32;
}unT;

XTmrCtr TmrInst;
int tmr_count;

int main()
{
	int status;
	init_platform();
	xil_printf("app AXI4_FPadd\n\r");
	//Initialize Timer Controller
	status = XTmrCtr_Initialize(&TmrInst,XPAR_TMRCTR_0_DEVICE_ID);
	if (status != XST_SUCCESS)
		return XST_FAILURE;
	XTmrCtr_SetResetValue(&TmrInst, 0, 0);
	xil_printf("timer initialized\n\r");

	float res,a,b;
	int opA,opB,result, Whole, Thousands;
    //while(1){
	    // Metodo 1: uso de funcao union()
		xil_printf("\nFPUadd Test\n\r");

	    // calculo funcao em hardware com overhead de transmissao de dados
	    XTmrCtr_Reset(&TmrInst, 0); // reset timer
	    XTmrCtr_Start(&TmrInst, 0); // start timer
		unT.f32 = 1.570796; // pi
	    FPADD_mWriteReg(XPAR_FPADD_0_S_AXI_BASEADDR,0,unT.u32);
		unT.f32 = 1.570796; // pi
		FPADD_mWriteReg(XPAR_FPADD_0_S_AXI_BASEADDR,4,unT.u32);
		unT.u32=FPADD_mReadReg(XPAR_FPADD_0_S_AXI_BASEADDR,8);
		XTmrCtr_Stop(&TmrInst, 0); // stop timer
		tmr_count = XTmrCtr_GetValue(&TmrInst, 0); // get value of timer
		xil_printf("execution time:%d\n\r", tmr_count);
		result=unT.u32;  //FPADD_mReadReg(XPAR_FPADD_0_DEVICE_ID,8);
		res = unT.f32;
		Whole = res;
		Thousands = (res - Whole)*10000;
		xil_printf("Metodo 1 dado = %d, result = %d.%03d\n\r",result,Whole,Thousands);

		// Metodo 2: uso do type cast de ponteiros
		a = 1.570796;
		opA = *(int*)&a;
		Xil_Out32(XPAR_FPADD_0_S_AXI_BASEADDR,opA);
		b = 1.570796;
		opB = *(int*)&b;
		Xil_Out32(XPAR_FPADD_0_S_AXI_BASEADDR+4,opB);
		result=Xil_In32(XPAR_FPADD_0_S_AXI_BASEADDR+8);
		res = *(float*)&result;
		Whole = res;
		Thousands = (res - Whole)*10000;
		xil_printf("Metodo 2 result = %d.%03d\n\r",Whole,Thousands);

		// Metodo 3: operandos em formato IEEE-754 (interpretacao em inteiro ou binario)
		FPADD_mWriteReg(XPAR_FPADD_0_S_AXI_BASEADDR,0,1065353216);
		FPADD_mWriteReg(XPAR_FPADD_0_S_AXI_BASEADDR,4,1070141376);
		result = FPADD_mReadReg(XPAR_FPADD_0_S_AXI_BASEADDR,8);
		xil_printf("Metodo 3 result = %d\n\r",result);
	//}
	cleanup_platform();
	return 0;
}
