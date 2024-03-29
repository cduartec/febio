%% Rigid Body

e_new.febio_spec.Material.material{1}.density.Text = '1'; 
e_new.febio_spec.Material.material{1}.center_of_mass.Text = '0,0,0'; 
e_new.febio_spec.Material.material{1}.Attributes.id = '1'; 
e_new.febio_spec.Material.material{1}.Attributes.name = 'Indenter'; 
e_new.febio_spec.Material.material{1}.Attributes.type = 'rigid body'; 

%% Solid Matrix 
% Basic Mixutre  

e_new.febio_spec.Material.material{2}.solid{1}.density.Text = '1'; 
e_new.febio_spec.Material.material{2}.solid{1}.E.Text = num2str(E); 
e_new.febio_spec.Material.material{2}.solid{1}.v.Text = num2str(nu); 
e_new.febio_spec.Material.material{2}.solid{1}.Attributes.type = 'neo-Hookean'; 

% Fiber 
e_new.febio_spec.Material.material{2}.solid{2}.density.Text = '0'; 

e_new.febio_spec.Material.material{2}.solid{2}.fibers.alpha.Text = num2str(alpha,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.fibers.beta.Text = num2str(beta,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.fibers.ksi.Text = num2str(ksi,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.fibers.Attributes.type = 'fiber-exp-pow'; 

e_new.febio_spec.Material.material{2}.solid{2}.mat_axis.theta.Text = num2str(theta,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.mat_axis.phi.Text = num2str(phi,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.mat_axis.Attributes.type = 'angles';

e_new.febio_spec.Material.material{2}.solid{2}.distribution.b.Text = num2str(b); 
e_new.febio_spec.Material.material{2}.solid{2}.distribution.Attributes.type = 'von-Mises-3d'; 

e_new.febio_spec.Material.material{2}.solid{2}.scheme.resolution.Text = '196'; 
e_new.febio_spec.Material.material{2}.solid{2}.scheme.Attributes.type = 'fibers-3d-fei'; 

e_new.febio_spec.Material.material{2}.solid{2}.Attributes.type = 'continuous fiber distribution'; 


% Attributes  
e_new.febio_spec.Material.material{2}.Attributes.id = '2'; 
e_new.febio_spec.Material.material{2}.Attributes.name = 'Sample'; 
e_new.febio_spec.Material.material{2}.Attributes.type = 'solid mixture'; 


%% Neo Hookean 

% e_new.febio_spec.Material.material{2}.density.Text = '1'; 
% e_new.febio_spec.Material.material{2}.E.Text = num2str(E); 
% e_new.febio_spec.Material.material{2}.v.Text = num2str(v); 
% e_new.febio_spec.Material.material{2}.solid{1}.Attributes.type = 'neo-Hookean'; 

% e_new.febio_spec.Material.material{2}.Attributes.id = '2'; 
% e_new.febio_spec.Material.material{2}.Attributes.name = 'Soft Tissue'; 
% e_new.febio_spec.Material.material{2}.Attributes.type = 'neo-Hookean'; 

%% Defining Material Elements 
 
e_new.febio_spec.Mesh.Elements{1}.Attributes.mat = '2';
e_new.febio_spec.Mesh.Elements{2}.Attributes.mat = '1';









