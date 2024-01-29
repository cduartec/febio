IFEA FEBio
===================
* Author: [Camilo A. Duarte-Cordon](https://scholar.google.com/citations?user=d1GtGzgAAAAJ&hl=en)
* Date: 01/29/2023

This repository has all the files needed to perform inverse finite element analysis (IFEA) using the software packages [FEBio](https://febio.org/) and [Dakota](https://dakota.sandia.gov/). The framework fits  FE results to experimental force relaxation data from spherical indentation and tension data

The repository contains the following folders:
* Raw experimental data cervix: [examples](./raw_data)
* FE model creation (indentation and uniaxial tension) [FE_models](./feb_files)
* FE indentation model - steady state: [indentation](./feb_files/Indentation)
* FE uniaxial tension model - steady state: [uniaxial tension](./feb_files/Indentation/)

Please send an e-mail to [caduarteco@gmail.com](mailto:caduarteco@gmail.com)  if you have any questions.

To use this app in HPC follow the next instructions:

### How to set up [FEBio](https://febio.org/) and [Dakota](https://dakota.sandia.gov/) in the cluster [Ginsburg](https://confluence.columbia.edu/confluence/display/rcs/Ginsburg+HPC+Cluster+User+Documentation)? ###

* Open a terminal and log-in into the Ginsburg, e.g.:

  >> ssh <UNI>@burg.rcs.columbia.edu

* Create an alias to the febio executable in your bash profile:

  >> vi ~/.bashrc
  >> alias febio='/burg/myers/projects/febio/febio35/bin/febio3'

  Add the following lines to use Dakota:

  >> INSTALL_DIR=/burg/myers/projects/dakota/dakota-6.17.0
  >> export PATH=$INSTALL_DIR/bin:$INSTALL_DIR/share/dakota/test:$INSTALL_DIR/gui:$PATH
  >> export PYTHONPATH=$PYTHONPATH:$INSTALL_DIR/share/dakota/Python/dakota

  Restart the shell to make changes active.

* Now lets test the software works. Run an interactive job:

  >> srun --pty -t 0-01:00 -A myers /bin/bash

  test Dakota:

  >> dakota -v

  test FEBio

  >>  febio -i input.feb

  * Check out dakota tutorial in the [Users Manual](https://snl-dakota.github.io/) or see some [examples](https://github.com/snl-dakota/dakota-examples).

### How to perform IFEA ###

* Create FEBio models:
  * Go to the Indentation folder and run the Matlab file main.m
  * Go to the Tensiong folder and run the Matlab file main.m
* Create dakota file [calibration_eq_IT.in](./calibration_eq_IT.in)
* Create interface python file [calibration_eq_IT.py](./calibration_eq_IT.py)
* Create submission file [calibration_eq_IT.sh](./calibration_eq_IT.sh)
* Submit job:
  >>  sbatch calibration_eq_IT.sh



  ```
