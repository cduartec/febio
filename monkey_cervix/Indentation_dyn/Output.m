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
e_new.febio_spec.Output.plotfile.var{3}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{3}.Attributes.type = 'rigid force';
e_new.febio_spec.Output.plotfile.var{4}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{4}.Attributes.type = 'reaction forces';
e_new.febio_spec.Output.plotfile.var{5}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{5}.Attributes.type = 'effective fluid pressure';
e_new.febio_spec.Output.plotfile.var{6}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{6}.Attributes.type = 'fluid pressure';
e_new.febio_spec.Output.plotfile.var{7}.Text = ''; 
e_new.febio_spec.Output.plotfile.var{7}.Attributes.type = 'fluid flux';
e_new.febio_spec.Output.plotfile.Attributes.type = 'febio'; 

%% Logfile 
total_w_seg = num_basic_nodes-1;
total_l_seg = num_plane-1;
log_indenter_node = num_Nodes_solid+1; 
log_indenter_elem = 1;
% if mod(total_l_seg,2) == 0
%     log_indenter_elem = round((total_l_seg*total_w_seg)/2+total_w_seg/2);
% else
%     log_indenter_elem = round((total_l_seg*total_w_seg)/2);
% end
% for i = 1 : length(basic_nodes) - 1 
%     if basic_nodes(i) < ind_pos && basic_nodes(i + 1) >= ind_pos     
%         log_indenter_elem = i;         
%     end
% end

e_new.febio_spec.Output.logfile.node_data.Text = num2str(log_indenter_node);              
e_new.febio_spec.Output.logfile.node_data.Attributes.data = 'ux;uy;uz'; 
e_new.febio_spec.Output.logfile.node_data.Attributes.file = 'disp.txt'; 

e_new.febio_spec.Output.logfile.rigid_body_data.Text = '1';              
e_new.febio_spec.Output.logfile.rigid_body_data.Attributes.data = 'Fx;Fy;Fz'; 
e_new.febio_spec.Output.logfile.rigid_body_data.Attributes.file = 'force.txt'; 

           





