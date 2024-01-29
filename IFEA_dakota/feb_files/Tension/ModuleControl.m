%% Module Write 

e_new.febio_spec.Module.Text = ''; 
e_new.febio_spec.Module.Attributes.type = 'solid'; 

%% Globals 
e_new.febio_spec.Globals.Constants.T.Text = '0'; 
e_new.febio_spec.Globals.Constants.R.Text = '0'; 
e_new.febio_spec.Globals.Constants.Fc.Text = '0'; 



%% Control Write 

e_new.febio_spec.Control.analysis.Text = 'STATIC'; 
e_new.febio_spec.Control.time_steps.Text = '20'; 
e_new.febio_spec.Control.step_size.Text = '0.05'; 
e_new.febio_spec.Control.solver.max_refs.Text = '25'; 
e_new.febio_spec.Control.solver.max_ups.Text = '10'; 
e_new.febio_spec.Control.solver.diverge_reform.Text = '1';
e_new.febio_spec.Control.solver.reform_each_time_step.Text = '1';
e_new.febio_spec.Control.solver.dtol.Text = '0.001'; 
e_new.febio_spec.Control.solver.etol.Text = '0.01'; 
e_new.febio_spec.Control.solver.rtol.Text = '0'; 
e_new.febio_spec.Control.solver.lstol.Text = '0.9'; 
e_new.febio_spec.Control.solver.min_residual.Text = '1e-20'; 
e_new.febio_spec.Control.solver.qnmethod.Text = 'BFGS'; 
e_new.febio_spec.Control.solver.symmetric_stiffness.Text = '0'; 
e_new.febio_spec.Control.time_stepper.dtmin.Text = '0.0001'; 
e_new.febio_spec.Control.time_stepper.dtmax.Text = ''; 
e_new.febio_spec.Control.time_stepper.dtmax.Attributes.lc = '2'; 
e_new.febio_spec.Control.time_stepper.max_retries.Text = '20'; 
e_new.febio_spec.Control.time_stepper.opt_iter.Text = '10'; 

%% Attributes
e_new.febio_spec.Attributes.version = '3.0'; 

