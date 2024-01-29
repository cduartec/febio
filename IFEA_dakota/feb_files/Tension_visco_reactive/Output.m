%% Plotfile 

e_new.febio_spec.Output.plotfile.var{1}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{1}.Attributes.type = 'displacement'; 
e_new.febio_spec.Output.plotfile.var{2}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{2}.Attributes.type = 'stress'; 
e_new.febio_spec.Output.plotfile.var{3}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{3}.Attributes.type = 'relative volume'; 
e_new.febio_spec.Output.plotfile.var{4}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{4}.Attributes.type = 'left Hencky'; 
e_new.febio_spec.Output.plotfile.var{5}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{5}.Attributes.type = 'left stretch'; 
e_new.febio_spec.Output.plotfile.var{6}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{6}.Attributes.type = 'RVE generations'; 
e_new.febio_spec.Output.plotfile.Attributes.type = 'febio'; 

%% Logfile 

log_tension_node = num_Nodes_solid+1;     

e_new.febio_spec.Output.logfile.node_data.Text = num2str(log_tension_node);              
e_new.febio_spec.Output.logfile.node_data.Attributes.data = 'ux;uy;uz'; 
e_new.febio_spec.Output.logfile.node_data.Attributes.file = 'disp.txt'; 

e_new.febio_spec.Output.logfile.rigid_body_data.Text = '1';              
e_new.febio_spec.Output.logfile.rigid_body_data.Attributes.data = 'Fx;Fy;Fz'; 
e_new.febio_spec.Output.logfile.rigid_body_data.Attributes.file = 'force.txt'; 




