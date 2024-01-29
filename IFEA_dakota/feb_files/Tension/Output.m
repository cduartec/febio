%% Plotfile 

% e_new.febio_spec.Output.plotfile.var{1}.Text = ''; 
% e_new.febio_spec.Output.plotfile.var{1}.Attributes.type = 'contact gap'; 
% e_new.febio_spec.Output.plotfile.var{2}.Text = ''; 
% e_new.febio_spec.Output.plotfile.var{2}.Attributes.type = 'contact pressure'; 
% e_new.febio_spec.Output.plotfile.var{3}.Text = ''; 
% e_new.febio_spec.Output.plotfile.var{3}.Attributes.type = 'contact traction'; 
e_new.febio_spec.Output.plotfile.var{1}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{1}.Attributes.type = 'displacement'; 
e_new.febio_spec.Output.plotfile.var{2}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{2}.Attributes.type = 'stress'; 

e_new.febio_spec.Output.plotfile.Attributes.type = 'febio'; 

%% Logfile 

log_tension_node = num_Nodes_solid+1;     
% log_tension_elem = round(l_seg*w_seg*t_seg/2);        
% for i = 1 : length(basic_nodes) - 1 
%     if basic_nodes(i) < ind_pos && basic_nodes(i + 1) >= ind_pos     
%         log_indenter_elem = i;         
%     end
% end

e_new.febio_spec.Output.logfile.node_data.Text = num2str(log_tension_node);              
e_new.febio_spec.Output.logfile.node_data.Attributes.data = 'ux;uy;uz'; 
e_new.febio_spec.Output.logfile.node_data.Attributes.file = 'disp.txt'; 

e_new.febio_spec.Output.logfile.rigid_body_data.Text = '1';              
e_new.febio_spec.Output.logfile.rigid_body_data.Attributes.data = 'Fx;Fy;Fz'; 
e_new.febio_spec.Output.logfile.rigid_body_data.Attributes.file = 'force.txt'; 




