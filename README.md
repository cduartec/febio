FEBio- Camilo
===================

This repository corresponds to the [FEBio](https://febio.org/) application of [Camilo A. Duarte-Cordon](https://scholar.google.com/citations?user=d1GtGzgAAAAJ&hl=en). The repository contains the following folders:
git
* Examples: [examples](./examples)
* Monkey cervix, indentation model - steady state: [indentation_static](./monkey_cervix/indentation_static)
* Monkey cervix, indentation poroviscoelastic model - dynamic: [indentation_dyn](./monkey_cervix/indentation_dyn)

Please send an e-mail to [caduarteco@gmail.com](mailto:caduarteco@gmail.com)  if you have any questions.

To use this app in HPC follow the next instructions:

### How to set up [FEBio](https://febio.org/) in the cluster [Ginsburg](https://confluence.columbia.edu/confluence/display/rcs/Ginsburg+HPC+Cluster+User+Documentation)? ###

* Log-in into the Ginsburg, e.g.:

  >> ssh <UNI>@burg.rcs.columbia.edu

* Create an alias to the febio executable:

  >> vi ./.bash_profile

  Add the following line:

  >> alias febio='/burg/myers/projects/febio/febio35/bin/febio3'

  Source:

  >> source ~/.bash_profile

* Run files:

  >>  febio -i input.feb
  >>  /burg/myers/projects/febio/febio35/bin/febio3 -i input.feb

* Run interactive job:

  >> srun --pty -t 0-01:00 -A myers /bin/bash
