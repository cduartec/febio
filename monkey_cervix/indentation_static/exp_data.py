# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 11:35:50 2023

@author: Administrator
"""

import numpy as np
import pandas as pd


def load_data(exp_data,time_steps):
    """ A function that loads experimental data points at desired time steps"""
    exp_data_new = pd.DataFrame()
    for i in range(len(time_steps)):
        result = exp_data.iloc[(exp_data['time']-time_steps[i]).abs().argsort()[:1]]
        exp_data_new = exp_data_new.append(result,ignore_index=True)
    return exp_data_new

   
def load_data_points(exp_data,time_steps):
    """ A function that loads experimental data points at desired time steps"""
    exp_data_new = pd.DataFrame()
    for i in time_steps:
        result = exp_data.iloc[i]
        exp_data_new = exp_data_new.append(result,ignore_index=True)
    return exp_data_new
 



