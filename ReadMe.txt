Supplementary code to accompany Jones et al., (2022) “Inflated pyroclasts in proximal fallout deposits reveal abrupt transitions in eruption behaviour”.

This code has been taken and adapted from Recktenwald (2006), please cite this original work when using this code.

Full citation: Recktenwald, Gerald, 2006, Transient, one-dimensional heat conduction in a convectively cooled sphere, Portland State University, Department of Mechanical and Materials Engineering. http://web.cecs.pdx.edu/~gerry/epub/pdf/transientConductionSphere.pdf  
Permanent link: http://www.webcitation.org/60nDyv3Yy.

More details can be found at https://web.cecs.pdx.edu/~gerry/epub/

-------------------------------
1. System requirements
This code has been used and tested on MATLAB version R2021a (Version 4). The version is compatible across all platforms (Mac, Windows, Linux). 

-------------------------------
2. Installation guide
Ensure that all .m files listed below are in the same folder. Run the Pyroclast_Cool.m file in MATLAB. There is no installation time for the .m files, you just need to have MATLAB installed. 

-------------------------------
3. Demo & Instructions for use
Open the Pyroclast_Cool.m file and adjust the parameters on code lines 8 to 12 and on line 25 to the desired values. Then run the Pyroclast_Cool.m code and a plot of the pyroclast temperature will be produced. As shown in the caption the two lines represent the surface and centre temperature of the pyroclast as a function of cooling time. Running this code should take sub 10 seconds on a “normal” machine.

To reproduce the data presented in Figure 8 of Jones et al., (2022), adjust the parameters on code lines 8 to 12 and on line 25 to the values listed in the methods.

-------------------------------
From Recktenwald (2006):

    m-file                     Purpose
    ------                     -------
	bracket          Obtain initial guess at roots of arbitrary f(x) by bracketing
	Pyroclast_Cool   Demonstrate use of Tsphere to solve a dimensional heat
	                 transfer problem.  See transientConductionSphere.pdf
	Tsphere          Compute theta(rstar,Fo) given Bi
	zfun             Evaluate f(zeta) =  1 - zeta*cot(zeta) - Bi
	zRoots           Use fzero and bracket to find roots of f(zeta)

