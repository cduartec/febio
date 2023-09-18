%% indentation
clc
clear
close all
data = readtable('samples_indentation.xlsx');


%% Parameters  
for i = 78:78%62
    tic
        width = round(table2array(data(i,2)),2)/2; 
        lenght = round(table2array(data(i,3)),2)/2; 
        thickness = round(table2array(data(i,4)),2); 
        indentation_disp = thickness*0.45; 
        b = round(table2array(data(i,5)),2); 
        sam_name = char(table2array(data(i,1))); 
        fprintf(sam_name);
        ModelCreating(width, lenght, thickness, indentation_disp, b, sam_name); 
    toc
end