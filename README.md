# PIV_for_mechanobiology
## PIV Algorithm Overview

This algorithm **utilises openPIV** Python package for **analysing** the collective movements of particles in biological systems.

### PIV Main Script

[`PIV_main.ipynb`](#) contains code for generating:
- (a) velocity field video;
- (b) velocity distribution histogram.

### ImageJ Macro Code

The folder `imageJ_macro_code` contains macro code that performs the following functions:
- (a) auto brightness & contrast;
- (b) brightness adjustment;
- (c) adjust contrast and despeckle;
- (d) cropping images;
- (e) FFT bandpass filter;
- (f) combine image sequence into **stack**.

### Checking Signal to Noise Ratio

[`S2N_checking.py`](#) contains code for checking the signal to noise ratio of the images after post-processing.


### Running the Code

To run the code, download the repository and run it on any IDE that supports `.ipynb` files.



