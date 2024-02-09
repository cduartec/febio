# -*- coding: utf-8 -*-
"""
Created on Mon Jul 31 11:26:16 2023

@author: Camilo
"""

# Load libraries
import re, sys, os
import shutil
import fileinput
import numpy as np
from math import exp
from numpy import savetxt, loadtxt, zeros, genfromtxt
from tempfile import NamedTemporaryFile
import matplotlib.pyplot as plt
from pathlib import Path
import pandas as pd
from pathlib import Path



samples = ['SMAA6B','SMHA4B','SMHF5B']
files = ['calibration_eq_IT.in','calibration_eq_IT_2.py','calibration_eq_IT.sh']


# print('Creating folders')
# for i in range(len(monkeys)):
#     for j in range(len(samples)):
#         running_command = 'mkdir {}'.format(monkeys[i] + samples[j])
#         #os.chdir('./feb_files/')
#         #print(running_command)
#         os.system(running_command)
        

print('Create input files Dakota')
old_line = 'name_id'
for i in range(len(samples)):
    input_file = files[0]   
    new_line = samples[i] 
    with open(input_file, 'r') as file:
        lines = file.readlines() 
    for k, line in enumerate(lines):
        if old_line in line:
            new_line = re.sub(old_line, samples[i], line)
            lines[k] = new_line
    output_file = samples[i] + '.in'  
    with open(output_file, 'w') as file:
        file.writelines(lines)
    shutil.move(output_file, './' + samples[i] + '/calibration_eq_IT.in')    

print('Create FEBio files')
print('Indentation')
:q
for i in range(len(samples)):
    folder_in = './' + samples[i] + '/'
    my_file = Path(folder_in + samples[i] + 'I.feb')
    # read the content of the file
    with open(my_file, 'r') as file:
        content = file.read()
    
    # seach for specific sentence
    updated_content_1 = content.replace('name="Force"', 'name="Force" file="force.txt"')    
    updated_content_2 = updated_content_1.replace('data="uz"', 'data="uz" file="disp.txt"')    
    updated_content_3 = updated_content_2.replace('name="Principal Strains"', 'name="Principal Strains" file="strains.txt"')   

    output_file = folder_in  + 'Indentation.feb'  
    with open(output_file, 'w') as file:
        file.writelines(updated_content_3)         
   
print('Tension')

for i in range(len(samples)):
    folder_in = './' + samples[i] + '/'
    my_file_2 = Path(folder_in + samples[i] + 'T.feb')
    # read the content of the file
    with open(my_file_2, 'r') as file:
        content = file.read()
    
    # seach for specific sentence
    updated_content_1 = content.replace('name="Force"', 'name="Force" file="force.txt"')    
    updated_content_2 = updated_content_1.replace('data="uz"', 'data="uz" file="disp.txt"')    

    output_file = folder_in  + 'Tension.feb'  
    with open(output_file, 'w') as file:
        file.writelines(updated_content_2)           
        
print('Create python files')

for j in range(len(samples)):
    input_file = files[1]            
    with open(input_file, 'r') as file:
        lines = file.readlines() 
    for k, line in enumerate(lines):
        if '032919AFS2' in line:
            new_line = re.sub('032919AFS2', samples[j], line)
            lines[k] = new_line      
    output_file = samples[j] + '.py'  
    with open(output_file, 'w') as file:
        file.writelines(lines)
    shutil.move(output_file, './' + samples[j] + '/calibration_eq_IT.py')    
    
    
        
print('Create submission files')   
old_line = 'NPF'
for j in range(len(samples)):
    input_file = files[2]   
    new_line = samples[j]
    with open(input_file, 'r') as file:
        lines = file.readlines() 
    for k, line in enumerate(lines):
        if old_line in line:
            new_line = re.sub(old_line, samples[j], line)
            lines[k] = new_line
    output_file = samples[j] + '.sh'  
    with open(output_file, 'w') as file:
        file.writelines(lines)
    shutil.move(output_file, './' + samples[j] + '/calibration_eq_IT.sh')   
  
        
print('Create submission exp_data')   
my_file= './exp_data.py'
for j in range(len(samples)):     
    shutil.copyfile(my_file, './' + samples[j] +'/exp_data.py')
    #os.chdir('./feb_files/')
    #print(running_command)

        
        
        