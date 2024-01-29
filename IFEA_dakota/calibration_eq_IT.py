#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 14 15:40:43 2022

@author: Camilo A. Duarte - Cordon

IFEA for equilibrium using tension and indentation experiments

"""

import re, sys, os
import fileinput
import numpy as np
from math import exp
from numpy import savetxt, loadtxt, zeros, genfromtxt
from tempfile import NamedTemporaryFile
import matplotlib.pyplot as plt
import exp_data as exp
from pathlib import Path
import pandas as pd


#-------------------------------------------------------
# Inputs
#-------------------------------------------------------
fexp             = 'r05038' # Monkey ID
fpos             = 'CXEOQ1' # Cervix position
fname            = ['Indentation_q_eq','Tension_eq'] # FEBio files
ffolder          = ['indentation','tension'] # Folder experiments
fsuff            = ['I','T']
fpre             = [4.0,1.0]
time_steps_I     = [250,690,1400] # Time steps for equilibrium Indentation
time_steps_T     = [750,3900,9150] # Time steps for equilibrium Tension
#time_steps_T     = [7504,39000,91500] # Time steps for equilibrium Tension
time_steps       = [time_steps_I, time_steps_T]
time_steps_sim_I = [0.33,0.67,1.0] # Time steps simulations of interest Indentation
time_steps_sim_T = [0.33,0.67,1.0] # Time steps simulations of interest Tension
#time_steps_sim_T = [0.33,0.67,1.0] # Time steps simulations of interest Tension
time_steps_sim   = [time_steps_sim_I, time_steps_sim_T]
fweig            = [0.5,0.5]

# Assign parameters from Dakota in extracted order
param            = ['E','v','ksi','alpha','beta']

#-------------------------------------------------------
# Begin
#-------------------------------------------------------
print('Begin')
print(fexp + fpos)
# Number of experimental data
n_fnc =[]
for s, suff in enumerate(fsuff):
  s_fnc = len(time_steps[s])
  n_fnc = n_fnc + [s_fnc]

argv = sys.argv
if len(argv) != 3:
        print("Usage:", argv[0], "params.in results.out")
        exit(1)
In = open(argv[1])
# = open('params.in')
line = In.readline()

#-------------------------------------------------------
# Check Input
#-------------------------------------------------------
print('Check Input')
k = line.find('variables')
p = 0
if k > 0:
  p = int(line[0:k])
if p != len(param):
  print (argv[0] + ': expected the first line of ' + argv[1] + ' to say \"' + str(len(param)) + ' variables\"')
  print ('Got \"' + line.rstrip() + '\" instead')
  exit(1)

#-------------------------------------------------------
# Objective paramters to be approximated (from Dakota)
#-------------------------------------------------------
x = {}
for i in range(p):
        line = In.readline().lstrip()
        x[i] = float(line[0:line.find(" ")])
#-------------------------------------------------------
# Assign Reference data (from Experiment)
#-------------------------------------------------------
line = In.readline()
n = int(line[0:line.find('functions')])
if n != sum(n_fnc): # Check the number of experimental data
  print (argv[0] + ': expected \"' + str(sum(n_fnc)) + ' functions\"')
  print ('Got \"' + line.rstrip() + '\" instead')
  exit(1)

# Objective function
objct = zeros((sum(n_fnc)))

for s,suff in enumerate(fsuff):
#-------------------------------------------------------
# Load Experiment Results
#-------------------------------------------------------
    folder = './raw_data/' + fexp + '/' + fexp + fpos + '/'+ ffolder[s] + '/' + fexp + fpos + suff + '.is_tcyclic_RawData/'
    exp_data = []
    print('Reading data')
    if suff =='I':
        # Extract data at time steps of interest
        exp_data = exp.data_point_ind(fexp,fpos,time_steps[s],folder)
    else:
        # Extract data at time steps of interest
        exp_data = exp.data_point_ten(fexp,fpos,time_steps[s],folder)

    # Experimental data
    p_exp = exp_data.fz
    u_exp = exp_data.uz
    print(p_exp)

#-------------------------------------------------------
# Load Simulation Results
#-------------------------------------------------------
# Change parameters
    with open('./{}'.format(fname[s] + '.feb')) as fin, NamedTemporaryFile(dir='.', delete=False) as fout:
        for line in fin:
            for i,p in enumerate(param):
                if '<' + p + '>' in line:
                    line = re.sub(r'\d+\.\d+', str(x[i]), line)
            fout.write(line.encode('utf8'))
        os.rename(fout.name, './{}'.format(fexp + fpos + fsuff[s] + '.feb'))

    # Run simulations
    print('Running simulations')
    running_command = 'mpiexec /burg/myers/projects/febio/febio35/bin/febio3 {}'.format(fexp + fpos + fsuff[s] +'.feb')
    #os.chdir('./feb_files/')
    os.system(running_command)
    # Obtain simulations results from febio
    sim_data = exp.extract_sim_data('./','force.txt','disp.txt')
    sim_data = exp.load_data(sim_data, time_steps_sim[s])
    # Simulation data
    p_sim = fpre[s]*sim_data.fz
    u_sim = sim_data.uz
    # Delete results
    os.system('rm ./disp.txt')
    os.system('rm ./force.txt')
    #os.chdir('./../')

#-------------------------------------------------------
# Objective Function
#-------------------------------------------------------
    s_objt = fweig[s]*(p_sim-p_exp)/p_exp
    objct[sum(n_fnc[0:s]):sum(n_fnc[0:s+1])] = s_objt

#-------------------------------------------------------
# Pass to Dakota
#-------------------------------------------------------
asv = {}
Out = open(argv[2], 'w')
#Out = open('results.out', 'w')
for i in range(n):
  line = In.readline().lstrip()
  print(line)
  asv[i] = k = int(line[0:line.find(" ")])
  if k & 1:
    print (objct[i],file=Out) # Pass objective function

In.close()
Out.close()
