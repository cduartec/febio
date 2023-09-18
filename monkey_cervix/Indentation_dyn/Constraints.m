% e_new.febio_spec.Constraints.rigid_body.prescribed{1}.Text = '0'; 
% e_new.febio_spec.Constraints.rigid_body.prescribed{1}.Attributes.bc = 'x'; 
% e_new.febio_spec.Constraints.rigid_body.prescribed{1}.Attributes.lc = '2'; 
% e_new.febio_spec.Constraints.rigid_body.prescribed{2}.Text = '0';
% e_new.febio_spec.Constraints.rigid_body.prescribed{2}.Attributes.bc = 'y'; 
% e_new.febio_spec.Constraints.rigid_body.prescribed{2}.Attributes.lc = '3'; 
% e_new.febio_spec.Constraints.rigid_body.prescribed{3}.Text = num2str(-Indentationdispt);
% e_new.febio_spec.Constraints.rigid_body.prescribed{3}.Attributes.bc = 'z'; 
% e_new.febio_spec.Constraints.rigid_body.prescribed{3}.Attributes.lc = '4';
% e_new.febio_spec.Constraints.rigid_body.prescribed{4}.Text = '0';
% e_new.febio_spec.Constraints.rigid_body.prescribed{4}.Attributes.bc = 'Rx'; 
% e_new.febio_spec.Constraints.rigid_body.prescribed{4}.Attributes.lc = '5';
% e_new.febio_spec.Constraints.rigid_body.prescribed{5}.Text = '0';
% e_new.febio_spec.Constraints.rigid_body.prescribed{5}.Attributes.bc = 'Ry'; 
% e_new.febio_spec.Constraints.rigid_body.prescribed{5}.Attributes.lc = '6';
% e_new.febio_spec.Constraints.rigid_body.prescribed{6}.Text = '0';
% e_new.febio_spec.Constraints.rigid_body.prescribed{6}.Attributes.bc = 'Rz'; 
% e_new.febio_spec.Constraints.rigid_body.prescribed{6}.Attributes.lc = '7';
% 
% e_new.febio_spec.Constraints.rigid_body.Attributes.mat = '1'; 

% Rigid Body
e_new.febio_spec.Boundary.rigid_body{1}.Attributes.mat = '1'; 

e_new.febio_spec.Boundary.rigid_body{1}.fixed{1}.Attributes.bc = 'x'; 
e_new.febio_spec.Boundary.rigid_body{1}.fixed{2}.Attributes.bc = 'y'; 
e_new.febio_spec.Boundary.rigid_body{1}.fixed{3}.Attributes.bc = 'Rx'; 
e_new.febio_spec.Boundary.rigid_body{1}.fixed{4}.Attributes.bc = 'Ry'; 
e_new.febio_spec.Boundary.rigid_body{1}.fixed{5}.Attributes.bc = 'Rz'; 

