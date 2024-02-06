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
    Force.columns=['n','fz']
    U = pd.DataFrame(u)
    U.columns=['n','uz']
    T = pd.DataFrame(t)
    T.columns=['time']

    sim_data = pd.DataFrame([T.time, Force.fz, U.uz]).transpose()
    return sim_data
