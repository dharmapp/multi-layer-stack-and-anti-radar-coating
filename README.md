# transfer-matrix_multi-layer-stack
MATLAB codes of simulation based on transfer matrix to calculate Fresnel coefficients of transmission and reflections in multi layer stack.

Description of the program:
1.  The stack_RT.m is the main function that is used to simulate the Fresnel coefficients for transmission and reflections in multi-layer stack.
    This program takes polarization, wavelength, angle of incidence, layer thicknesses, and refractive indices for the input, and give Fresnel coefficients r,t,R, and T as outputs.
    This program needs crac.m; interfaces_ordinates.m ; matrix_C.m ; matrix_T.m functions altogether to run properly.
2.  the crac.m is a function to calculate roots of complex numbers;
3.  the interfaces_ordinates.m is a function to build the 1D coordinates of each layer interfaces.
4.  matrix_C.m is a function to calculate matrix of propagation inside a medium.
5.  matrix_T.m is a function to calculate matrix of transition at the interfaces between 2 adjacent medium

Update:
1. Example_1_Bragg_mirror.m : Example script to calculate Bragg mirror reflection using the stack_RT.m program.
   Additional note: The example of structure given in this script is an A-B-A-B multi-layer stack, with SiN and SiO2 as the for each layers surrounded by air cladding.
                    To run this particular example, the functions SiNSellmeier.m and SiO2Sellmeier.m are needed to calculate the refractive indices for SiN and SiO2 respectively at any arbitrary wavelength.
                    The SiNSellmeier.m and SiO2Sellmeier.m are valid for at least 0.5-2 micron wavelength regime.
                    Any other refractive indices can be used for this script.
