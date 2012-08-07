/*******************************************************************************
 Vendor: Xilinx 
Associated Filename: hier_func3.c
Purpose: AutoESL Coding Style example 
Device: All 
Revision History: May 30, 2008 - initial release
                                                
*******************************************************************************
Copyright 2008 - 2012 Xilinx, Inc. All rights reserved. 

This file contains confidential and proprietary information of Xilinx, Inc. and 
is protected under U.S. and international copyright and other intellectual 
property laws.

DISCLAIMER
This disclaimer is not a license and does not grant any rights to the materials 
distributed herewith. Except as otherwise provided in a valid license issued to 
you by Xilinx, and to the maximum extent permitted by applicable law: 
(1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX 
HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, 
INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR 
FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable (whether 
in contract or tort, including negligence, or under any other theory of 
liability) for any loss or damage of any kind or nature related to, arising under 
or in connection with these materials, including for any direct, or any indirect, 
special, incidental, or consequential loss or damage (including loss of data, 
profits, goodwill, or any type of loss or damage suffered as a result of any 
action brought by a third party) even if such damage or loss was reasonably 
foreseeable or Xilinx had been advised of the possibility of the same.

CRITICAL APPLICATIONS
Xilinx products are not designed or intended to be fail-safe, or for use in any 
application requiring fail-safe performance, such as life-support or safety 
devices or systems, Class III medical devices, nuclear facilities, applications 
related to the deployment of airbags, or any other applications that could lead 
to death, personal injury, or severe property or environmental damage 
(individually and collectively, "Critical Applications"). Customer assumes the 
sole risk and liability of any use of Xilinx products in Critical Applications, 
subject only to applicable laws and regulations governing limitations on product 
liability. 

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT 
ALL TIMES.

*******************************************************************************/
#include <stdio.h>

#define NUM_TRANS 40

typedef int din_t;
typedef int dint_t;
typedef int dout_t;

int sumsub_func(din_t *in1, din_t *in2, dint_t *outSum, dint_t *outSub)
{
    *outSum = *in1 + *in2;
    *outSub = *in1 - *in2;
}

int shift_func(dint_t *in1, dint_t *in2, dout_t *outA, dout_t *outB)
{
    *outA = *in1 >> 1;
    *outB = *in2 >> 2;
}

void hier_func3(din_t A, din_t B, dout_t *C, dout_t *D)
{
    dint_t apb, amb;

    sumsub_func(&A,&B,&apb,&amb);
    shift_func(&apb,&amb,C,D);
}

int main() {
	// Data storage
	int a[NUM_TRANS], b[NUM_TRANS];
	int c_expected[NUM_TRANS], d_expected[NUM_TRANS];
	int c[NUM_TRANS], d[NUM_TRANS];
	
	//Function data (to/from function)
	int a_actual, b_actual;
	int c_actual, d_actual;
	
	// Misc
	int	retval=0, i, i_trans, tmp;
	FILE *fp;

	// Load input data from files
	fp=fopen("tb_data/inA.dat","r");
	for (i=0; i<NUM_TRANS; i++){
		fscanf(fp, "%d", &tmp);
		a[i] = tmp;
	} 
	fclose(fp);

	fp=fopen("tb_data/inB.dat","r");
	for (i=0; i<NUM_TRANS; i++){
		fscanf(fp, "%d", &tmp);
		b[i] = tmp;
	} 
	fclose(fp);

	// Execute the function multiple times (multiple transactions)
	for(i_trans=0; i_trans<NUM_TRANS-1; i_trans++){
		
		//Apply next data values
		a_actual = a[i_trans];
		b_actual = b[i_trans];
		
    hier_func3(a_actual, b_actual, &c_actual, &d_actual);
    
    //Store outputs
			c[i_trans] = c_actual;
			d[i_trans] = d_actual;
	}
	
	// Load expected output data from files
	fp=fopen("tb_data/outC.golden.dat","r");
	for (i=0; i<NUM_TRANS; i++){
		fscanf(fp, "%d", &tmp);
		c_expected[i] = tmp;
	} 
	fclose(fp);

	fp=fopen("tb_data/outD.golden.dat","r");
	for (i=0; i<NUM_TRANS; i++){
		fscanf(fp, "%d", &tmp);
		d_expected[i] = tmp;
	} 
	fclose(fp);
	
	// Check outputs against expected
	for (i = 0; i < NUM_TRANS-1; ++i) {
		if(c[i] != c_expected[i]){
			retval = 1;
		}
		if(d[i] != d_expected[i]){
			retval = 1;
		}
	}

	// Print Results		
	if(retval == 0){
		printf("    *** *** *** *** \n"); 
		printf("    Results are good \n"); 
		printf("    *** *** *** *** \n"); 
	} else {
		printf("    *** *** *** *** \n"); 
		printf("    Mismatch: retval=%d \n", retval); 
		printf("    *** *** *** *** \n"); 
	}

	// Return 0 if outputs are correct
	return retval;
}
