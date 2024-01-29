function ModelCreating(width, lenght, thickness, tension_disp, b, sam_name)  

%% Parameters  
E = 0.5;
nu = 0.2;
alpha = 1.2;
ksi = 0.1;

E_1 = 0.7;
nu_1 = 0.2;
alpha_1 = 1.2;
ksi_1 = 0.2;

mu = 0;
beta = 2.0;
theta = 0.0; 
phi = 90.0;

%%  Runing 
% run NodeElement.m 
run elementnodetest.m
run ModuleControl.m 
run Materials.m
run ElementDataBoundary.m 
run Contact.m    
run LoadData.m 
run Output.m    

e_write.febio_spec.Module = e_new.febio_spec.Module; 
e_write.febio_spec.Control = e_new.febio_spec.Control; 
e_write.febio_spec.Globals = e_new.febio_spec.Globals; 
e_write.febio_spec.Material = e_new.febio_spec.Material; 
e_write.febio_spec.Mesh = e_new.febio_spec.Mesh; 
e_write.febio_spec.MeshDomains = e_new.febio_spec.MeshDomains; 
e_write.febio_spec.Boundary = e_new.febio_spec.Boundary; 
e_write.febio_spec.Rigid = e_new.febio_spec.Rigid; 
e_write.febio_spec.Contact = e_new.febio_spec.Contact; 
e_write.febio_spec.LoadData = e_new.febio_spec.LoadData; 
e_write.febio_spec.Output = e_new.febio_spec.Output; 
e_write.febio_spec.Attributes = e_new.febio_spec.Attributes;  

%% Write Results  
struct2xml(e_write, [sam_name, 'T.feb']) ; 



