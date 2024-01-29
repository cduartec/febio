%% 1. Rigid Body

e_new.febio_spec.Material.material{1}.density.Text = '1'; 
e_new.febio_spec.Material.material{1}.center_of_mass.Text = '0,0,0'; 
e_new.febio_spec.Material.material{1}.Attributes.id = '1'; 
e_new.febio_spec.Material.material{1}.Attributes.name = 'Top_grip'; 
e_new.febio_spec.Material.material{1}.Attributes.type = 'rigid body'; 

%% 2. Solid Matrix 

% Basic Mixture

% Attributes  
e_new.febio_spec.Material.material{2}.Attributes.id = '2'; 
e_new.febio_spec.Material.material{2}.Attributes.name = 'Sample'; 
e_new.febio_spec.Material.material{2}.Attributes.type = 'solid mixture'; 

% Matrix
e_new.febio_spec.Material.material{2}.solid{1}.density.Text = '1'; 
e_new.febio_spec.Material.material{2}.solid{1}.E.Text = num2str(E); 
e_new.febio_spec.Material.material{2}.solid{1}.v.Text = num2str(nu); 
e_new.febio_spec.Material.material{2}.solid{1}.Attributes.type = 'neo-Hookean'; 

% Reactive viscoelastic model

% Attributes  
e_new.febio_spec.Material.material{2}.solid{2}.Attributes.id = '2'; 
e_new.febio_spec.Material.material{2}.solid{2}.Attributes.name = 'Sample'; 
e_new.febio_spec.Material.material{2}.solid{2}.Attributes.type = 'reactive viscoelastic'; 
e_new.febio_spec.Material.material{2}.solid{2}.density.Text = '1.0'; 
e_new.febio_spec.Material.material{2}.solid{2}.kinetics.Text = '1'; 
e_new.febio_spec.Material.material{2}.solid{2}.trigger.Text = '0'; 
e_new.febio_spec.Material.material{2}.solid{2}.wmin.Text = '0'; 
%e_new.febio_spec.Material.material{2}.solid{2}.emin.Text = '0.0005'; 


%% 2.1 Strong bonds



% Fiber 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.Attributes.type = 'continuous fiber distribution'; 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.density.Text = '1'; 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.fibers.alpha.Text = num2str(alpha,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.fibers.beta.Text = num2str(beta,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.fibers.ksi.Text = num2str(ksi,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.fibers.Attributes.type = 'fiber-exp-pow'; 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.mat_axis.theta.Text = num2str(theta,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.mat_axis.phi.Text = num2str(phi,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.mat_axis.Attributes.type = 'angles';
e_new.febio_spec.Material.material{2}.solid{2}.elastic.distribution.b.Text = num2str(b); 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.distribution.Attributes.type = 'von-Mises-3d'; 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.scheme.resolution.Text = '196'; 
e_new.febio_spec.Material.material{2}.solid{2}.elastic.scheme.Attributes.type = 'fibers-3d-fei'; 

%% 2.2 Weak bonds


% Fiber 
e_new.febio_spec.Material.material{2}.solid{2}.bond.Attributes.type = 'continuous fiber distribution'; 
e_new.febio_spec.Material.material{2}.solid{2}.bond.density.Text = '1'; 
e_new.febio_spec.Material.material{2}.solid{2}.bond.fibers.alpha.Text = num2str(alpha_1,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.bond.fibers.beta.Text = num2str(beta,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.bond.fibers.ksi.Text = num2str(ksi_1,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.bond.fibers.Attributes.type = 'fiber-exp-pow'; 
e_new.febio_spec.Material.material{2}.solid{2}.bond.mat_axis.theta.Text = num2str(theta,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.bond.mat_axis.phi.Text = num2str(phi,'%4.1f'); 
e_new.febio_spec.Material.material{2}.solid{2}.bond.mat_axis.Attributes.type = 'angles';
e_new.febio_spec.Material.material{2}.solid{2}.bond.distribution.b.Text = num2str(b); 
e_new.febio_spec.Material.material{2}.solid{2}.bond.distribution.Attributes.type = 'von-Mises-3d'; 
e_new.febio_spec.Material.material{2}.solid{2}.bond.scheme.resolution.Text = '196'; 
e_new.febio_spec.Material.material{2}.solid{2}.bond.scheme.Attributes.type = 'fibers-3d-fei'; 


% Relaxation
e_new.febio_spec.Material.material{2}.solid{2}.relaxation.Attributes.type = 'relaxation-exp-distortion'; 
e_new.febio_spec.Material.material{2}.solid{2}.relaxation.tau0.Text = '100.0'; 
e_new.febio_spec.Material.material{2}.solid{2}.relaxation.tau1.Text = '100.0'; 
e_new.febio_spec.Material.material{2}.solid{2}.relaxation.alpha.Text = '0.5'; 

%% Defining Material Elements 
 
e_new.febio_spec.Mesh.Elements{1}.Attributes.mat = '2';
e_new.febio_spec.Mesh.Elements{2}.Attributes.mat = '1';










