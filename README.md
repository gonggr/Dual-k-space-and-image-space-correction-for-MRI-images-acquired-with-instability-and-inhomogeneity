# Dual-k-space-and-image-space-correction-for-MRI-images-acquired-with-instability-and-inhomogeneity

% purpose   : correct artifacts due to magnetic field instability and inhomogeneity

% input     : two complex MRI images acquired with inverted read gradient

% output    : corrected image, intermediate corrected images, phase correction and estimated magnetic field inhomogeneity

% reference : Rodriguez GG et al. MRI, 87 (2022) 157–168, https://doi.org/10.1016/j.mri.2022.01.008    

% Date      : 2022/03 

% Afiliation: LaRTE, IFEG-UNC

% Contact   : gonzalo.g.rodriguez@unc.edu.ar

% MATLAB version: R2021a (it should easily run on Matlab 2019 and 2020)

The method allows 3 different modalities:

0) Instability correction.
1) Inhomogeneity correction.
2) Full correction (instability and inhomogeneity).


- The modality "0" requieres as input a complex MRI image.
- The modality "1" requieres as input 2 MRI images acquired with inverted read gradients (the data for this case can be complex or real).
- The modality "2" requieres as input 2 complex MRI images acquired with inverted read gradients.

%-------------------------------------------------------------------------------

DataTest_Brain

For modality 0 use img_instability.mat 

For modality 1 use img_inhomogeneity_1.mat and img_inhomogeneity_2.mat

For modality 2 use img_full_distorted_complex_1.mat and img_full_distorted_complex_1.mat

img_ideal.mat is the ideal image

%-------------------------------------------------------------------------------------


run_full_correction_main.m: contains all the functions involved in the correction method.


correction_prepare_parameters(fsn): in this function you need to specify the correction modality and other parameters that can be configurated for the correction.


correction_prepare_get_data: in this function you need to specify the folder and name of the image/images that will be used for the correction.
The program read .m files. 

For questions or problems with the implementation contact gonzalo.g.rodriguez@unc.edu.ar
