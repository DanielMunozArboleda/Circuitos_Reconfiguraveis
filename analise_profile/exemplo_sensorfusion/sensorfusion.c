#include<stdio.h>
#include<math.h>
#include"div.h"
//#include"div.c"
#include"mult.h"
#include"add.h"
#include"sub.h"

float ganho(float sigma_k, float sigma_z){
	float G=0.0;
	//float aux=0.0;
	G = div(sigma_k,add(sigma_k,sigma_z));
	return G;
}

float sigma_k_1(float sigma_k, float ganho){
	float sigma_hat=0.0;
	//float aux=0.0;
	sigma_hat = sub(sigma_k,mult(ganho,sigma_k));
	return sigma_hat;
}

float x_fusao(float xUL, float ganho, float xIR){
	float xf = 0.0;
	xf = add(xUL,mult(ganho,sub(xIR,xUL)));
	return xf;
}

int main(void){
	int i,j=0;
	int N=1000;
	float xUL=70.0;
	float new_x_UL=0.0;
	float xIR=72.0;
	float new_x_IR=0.0;
	float sigma_k_hat=0.01;
	float sigma_z=0.1;
	float G_k_1 = 0.0;
	float x_hat = 0.0;
	
	for(i=0;i<N;i++){
		for(j=0;j<N;j++){
			new_x_UL = xUL+0.5*rand()/32767.0;
			new_x_IR = xIR+1.0*rand()/32767.0;
			G_k_1 = ganho(sigma_k_hat,sigma_z);
			sigma_k_hat = sigma_k_1(sigma_k_hat,sigma_z);
			x_hat = x_fusao(new_x_UL,G_k_1,new_x_IR);
		}
	}
	return 0;
}











