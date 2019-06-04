
#include <stdio.h>
#include "xil_printf.h"
#include "IPaxifpmul.h"
#include "xgpio.h"
#include "xbasic_types.h"

union
{
    Xuint8 u8[4];
    Xuint32 u32;
    Xfloat32 f32;
}unT;

int main()
{

    float res = 0.0;
    int Whole = 0;
    int Thousands = 0;
    unT.f32 = 4.25;
    IPAXIFPMUL_mWriteReg(XPAR_IPAXIFPMUL_0_S00_AXI_BASEADDR, 0, unT.u32);
	unT.f32 = 1.75;
    IPAXIFPMUL_mWriteReg(XPAR_IPAXIFPMUL_0_S00_AXI_BASEADDR, 4, unT.u32);
	unT.u32=IPAXIFPMUL_mReadReg (XPAR_IPAXIFPMUL_0_S00_AXI_BASEADDR, 8);
	res = unT.f32;
	Whole = res;
	Thousands = (res - Whole)*10000;
	xil_printf("results = %d.%03d\n\r",Whole,Thousands);
    return 0;
}