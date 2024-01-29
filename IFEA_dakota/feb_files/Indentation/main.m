%% Spherical indentation FEBio

% Author: Camilo A. Duarte-Cordon
% Year: 2023
% Comments: This script generates FEBio files of spherical indentation
% testing experiments. This file is based on Shu's work.


%% Start

clc
clear
close all
% Read table with geometry of the samples, omit rows with missing numbers
data = readtable('samples_indentation.xlsx',MissingRule="omitrow");

%% Parameters  
for i = 1:height(data)
    tic
        width = round(table2array(data(i,2)),2)/2; 
        lenght = round(table2array(data(i,3)),2)/2; 
        thickness = round(table2array(data(i,4)),2); 
        indentation_disp = round(thickness*0.45,2); 
        b = round(table2array(data(i,5)),2); 
        sam_name = char(table2array(data(i,1))); 
        fprintf(sam_name);
        ModelCreating(width, lenght, thickness, indentation_disp, b, sam_name); 
    toc
end