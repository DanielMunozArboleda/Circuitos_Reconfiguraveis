/*
 * main.c
 *
 *  Created on: 28 de mai de 2019
 *      Author: DanielMauricio
 */

#include <stdio.h>
#include "xil_printf.h"
#include "axi4_RNA443.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xbasic_types.h"
#include "xtmrctr.h"

union
{
    Xuint8 u8[4];  Xuint32 u32;
    Xfloat32 f32;
}unT;

XTmrCtr TmrInst;

int main()
{

    float out_neuron1 = 0.0;
    float out_neuron2 = 0.0;
    float out_neuron3 = 0.0;
    int Whole = 0;
    int Thousands = 0;
    int status = 0;
    int tmr_count = 0;

    //Initialize Timer Controller
    status = XTmrCtr_Initialize(&TmrInst,XPAR_AXI_TIMER_0_BASEADDR);
    if (status != XST_SUCCESS)
    	return XST_FAILURE;
    // set reset value for TimerController
    XTmrCtr_SetResetValue(&TmrInst, 0, 0);

    // reset timer
    XTmrCtr_Reset(&TmrInst, 0);
    // start timer
    XTmrCtr_Start(&TmrInst, 0);
    unT.f32 = 0.1;
    AXI4_RNA443_mWriteReg(XPAR_AXI4_RNA443_0_S00_AXI_BASEADDR, 0, unT.u32);
    AXI4_RNA443_mWriteReg(XPAR_AXI4_RNA443_0_S00_AXI_BASEADDR, 4, unT.u32);
    AXI4_RNA443_mWriteReg(XPAR_AXI4_RNA443_0_S00_AXI_BASEADDR, 8, unT.u32);
    AXI4_RNA443_mWriteReg(XPAR_AXI4_RNA443_0_S00_AXI_BASEADDR, 12, unT.u32);

    unT.u32=AXI4_RNA443_mReadReg(XPAR_AXI4_RNA443_0_S00_AXI_BASEADDR, 16);
    out_neuron1 = unT.f32;

    unT.u32=AXI4_RNA443_mReadReg(XPAR_AXI4_RNA443_0_S00_AXI_BASEADDR, 20);
    out_neuron2 = unT.f32;

    unT.u32=AXI4_RNA443_mReadReg(XPAR_AXI4_RNA443_0_S00_AXI_BASEADDR, 24);
    out_neuron3 = unT.f32;

    // stop timer
    XTmrCtr_Stop(&TmrInst, 0);
    // get value of timer
    tmr_count = XTmrCtr_GetValue(&TmrInst, 0);

    Whole = out_neuron1;
	Thousands = (out_neuron1 - Whole)*10000;
	xil_printf("neuron1 = %d.%03d\n\r",Whole,Thousands);
	Whole = out_neuron2;
	Thousands = (out_neuron2 - Whole)*10000;
	xil_printf("neuron2 = %d.%03d\n\r",Whole,Thousands);
	Whole = out_neuron3;
	Thousands = (out_neuron3 - Whole)*10000;
	xil_printf("neuron3 = %d.%03d\n\r",Whole,Thousands);

	xil_printf("execution time with axi overhead: %d\n\r", tmr_count);
    return 0;
}
