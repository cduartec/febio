# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 11:35:50 2023

@author: Administrator
"""

import numpy as np
import pandas as pd
from pathlib import Path


def load_data(exp_data,time_steps):
    """ A function that loads experimental data points at desired time"""
    exp_data_new = pd.DataFrame()
    for i in range(len(time_steps)):
        result = exp_data.iloc[(exp_data['time']-time_steps[i]).abs().argsort()[:1]]
        exp_data_new = pd.concat([exp_data_new,result],ignore_index=True)
    return exp_data_new


def load_data_points(exp_data,time_steps):
    """ A function that loads experimental data points at desired time steps"""
    exp_data_new = pd.DataFrame()
    for i in time_steps:
        result = exp_data.iloc[[i]]
        exp_data_new = pd.concat([exp_data_new,result],ignore_index=True)
    return exp_data_new

def data_point_ind(fexp,fpos,time,folder):
    """ A function that loads experimental data points at desired time from indentation"""
    ffolder          = 'indentation' # Folder experiments
    fsuff            = 'I'
    # Load experimental results
    my_file = Path(folder + 'Specimen_RawData_1.csv')
    exp_data = []
    exp_data_new = []
    if my_file.is_file():
        exp_data = pd.read_csv(folder + 'Specimen_RawData_1.csv', delimiter = ",",
                               skiprows=[0,1,2,3], usecols=[0,1,2],names=['time','uz','fz'])
        exp_data['time']=exp_data['time'].str.replace(',','')
        exp_data = exp_data.apply(pd.to_numeric, errors='coerce')

        # Drop rows that has NaN values on selected columns
        exp_data = exp_data.dropna(subset=['time'])
        # Reset index after drop
        exp_data = exp_data.dropna().reset_index(drop=True)
        # Substract first row to all values
        first_row = exp_data.iloc[[0]].values[0]
        exp_data = exp_data.apply(lambda row: row - first_row, axis=1)
        # Extract data at time of interest
        exp_data_new = load_data(exp_data, time)
    else:
        print("file doesn't exist")
    return exp_data_new

def data_point_ten(fexp,fpos,time,folder):
    """ A function that loads experimental data points at desired time from indentation"""
    ffolder          = 'tension' # Folder experiments
    fsuff            = 'T'
    # Load experimental results
    my_file = Path(folder + 'Specimen_RawData_1.csv')
    exp_data = []
    exp_data_new = []
    if my_file.is_file():
        exp_data = pd.read_csv(folder + 'Specimen_RawData_1.csv', delimiter = ",",
                               skiprows=[0,1,2,3,4,5,6,7], usecols=[0,1,2],names=['time','uz','fz'])
        exp_data['time']=exp_data['time'].str.replace(',','')
        exp_data = exp_data.apply(pd.to_numeric, errors='coerce')
        exp_data = exp_data[~(exp_data['time'] < 3104.4)]

        # Drop rows that has NaN values on selected columns
        exp_data = exp_data.dropna(subset=['time'])
        # Reset index after drop
        exp_data = exp_data.dropna().reset_index(drop=True)
        # Substract first row to all values
        first_row = exp_data.iloc[[0]].values[0]
        exp_data = exp_data.apply(lambda row: row - first_row, axis=1)
        # Extract data at time of interest
        exp_data_new = load_data(exp_data, time)
    else:
        print("file doesn't exist")
    return exp_data_new

def extract_sim_data(folder,fname_force,fname_disp):
    # Obtain simulations results from febio
    F = []
    u = []
    t = []
    with open(folder + fname_force, 'r') as file:
        line_count = 0
        for line in file:
            line_count += 1
            if '*Time' in line:
                time = line.split('=')[1].strip()
                time = float(time)
                t.append(time)
            if line_count % 4 == 0:
                force = [float(x) for x in line.split(' ')]
                F.append(force)

    with open(folder + fname_disp, 'r') as file:
        line_count = 0
        for line in file:
            line_count += 1
            if line_count % 4 == 0:
                disp = [float(x) for x in line.split(' ')]
                u.append(disp)

    Force = pd.DataFrame(F)
    Force.columns=['n','fx','fy','fz']
    U = pd.DataFrame(u)
    U.columns=['n','ux','uy','uz']
    T = pd.DataFrame(t)
    T.columns=['time']

    sim_data = pd.DataFrame([T.time, Force.fz, U.uz]).transpose()
    return sim_data
