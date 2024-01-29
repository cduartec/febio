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




#monkeys = ['r05038','r11091','r11087','rh2825']
monkeys = ['r05038','r11091','r11087','rh2825','r17003','r08059','r05050','r09059','r01047','rh2509','r10093','r0039']
samples = ['CXEOQ1','CXEOQ2','CXEOQ3','CXEOQ4','CXIOQ1','CXIOQ2','CXIOQ3','CXIOQ4']
files = ['calibration_eq_IT.in','calibration_eq_IT.py','calibration_eq_IT.sh']


print('Creating folders')
for i in range(len(monkeys)):
    for j in range(len(samples)):
        running_command = 'mkdir {}'.format(monkeys[i] + samples[j])
        #os.chdir('./feb_files/')
        #print(running_command)
        os.system(running_command)


print('Create input files Dakota')
old_line = 'r05038CXEOQ1'
for i in range(len(monkeys)):
    for j in range(len(samples)):
        input_file = files[0]
        new_line = monkeys[i] + samples[j]
        with open(input_file, 'r') as file:
            lines = file.readlines()
        for k, line in enumerate(lines):
            if old_line in line:
                new_line = re.sub(old_line, monkeys[i] + samples[j], line)
                lines[k] = new_line
        output_file = monkeys[i] + samples[j] + '.in'
        with open(output_file, 'w') as file:
            file.writelines(lines)
        shutil.move(output_file, './' + monkeys[i] + samples[j] + '/calibration_eq_IT.in')

print('Create FEBio files')
print('Indentation')
folder_in = './feb_files/Indentation/'
for i in range(len(monkeys)):
    for j in range(len(samples)):
        my_file = Path(folder_in + monkeys[i] + samples[j] + 'I.feb')
        if my_file.is_file():
            shutil.copyfile(my_file, './' + monkeys[i] + samples[j] + '/Indentation_q_eq.feb')

print('Tension')
folder_in = './feb_files/Tension/'
for i in range(len(monkeys)):
    for j in range(len(samples)):
        my_file = Path(folder_in + monkeys[i] + samples[j] + 'T.feb')
        if my_file.is_file():
            shutil.copyfile(my_file, './' + monkeys[i] + samples[j] + '/Tension_eq.feb')

print('Create python files')


for i in range(len(monkeys)):
    for j in range(len(samples)):
        input_file = files[1]
        with open(input_file, 'r') as file:
            lines = file.readlines()
        for k, line in enumerate(lines):
            if 'r05038' in line:
                new_line = re.sub('r05038', monkeys[i], line)
                lines[k] = new_line
        for k, line in enumerate(lines):
            if 'CXEOQ1' in line:
                new_line = re.sub('CXEOQ1', samples[j], line)
                print(new_line)
                lines[k] = new_line
        output_file = monkeys[i] + samples[j] + '.py'
        with open(output_file, 'w') as file:
            file.writelines(lines)
        shutil.move(output_file, './' + monkeys[i] + samples[j] + '/calibration_eq_IT.py')

print('Create submission files')
old_line = 'NPEOQ1'
for i in range(len(monkeys)):
    for j in range(len(samples)):
        input_file = files[2]
        new_line = monkeys[i] + samples[j]
        with open(input_file, 'r') as file:
            lines = file.readlines()
        for k, line in enumerate(lines):
            if old_line in line:
                new_line = re.sub(old_line, monkeys[i] + samples[j], line)
                lines[k] = new_line
        output_file = monkeys[i] + samples[j] + '.sh'
        with open(output_file, 'w') as file:
            file.writelines(lines)
        shutil.move(output_file, './' + monkeys[i] + samples[j] + '/calibration_eq_IT.sh')

print('Create submission exp_data')
my_file= './exp_data.py'
for i in range(len(monkeys)):
    for j in range(len(samples)):
        shutil.copyfile(my_file, './' + monkeys[i] + samples[j] +'/exp_data.py')
        #os.chdir('./feb_files/')
        #print(running_command)
