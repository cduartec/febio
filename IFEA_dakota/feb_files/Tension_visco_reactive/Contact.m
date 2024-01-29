%% Master Surface   

s_out_surface = s_out_surf;     

for i = 1 : length(s_out_surface(:, 1))
    contact_surf1Text = '';     
    for j = 1 : length(s_out_surface(1, :))
        contact_surf1Text = [contact_surf1Text, '  ', num2str(s_out_surface(i, j)), ',']; 
    end
    contact_surf1Text(end) = '';      
    
    e_new.febio_spec.Mesh.Surface{1}.quad4{i}.Text = contact_surf1Text; 
    e_new.febio_spec.Mesh.Surface{1}.quad4{i}.Attributes.id = num2str(i); 
end


e_new.febio_spec.Mesh.Surface{1}.Attributes.name = 'Primary'; 



%% Slave Surface   

solid_top_surface = Elems_Coord_layer(:, 1 : 4) + (num_thickness - 1) * n_l; 

for i = 1 : length(solid_top_surface(:, 1))
    contact_surf2Text = '';     
    for j = 1 : length(solid_top_surface(1, :))
        contact_surf2Text = [contact_surf2Text, '  ', num2str(solid_top_surface(i, j)), ',']; 
    end
    contact_surf2Text(end) = '';      
    
    e_new.febio_spec.Mesh.Surface{2}.quad4{i}.Text = contact_surf2Text; 
    e_new.febio_spec.Mesh.Surface{2}.quad4{i}.Attributes.id = num2str(i); 
end

e_new.febio_spec.Mesh.Surface{2}.Attributes.name = 'Secondary'; 

%% Surface Pair 

%% Surface Pair 

e_new.febio_spec.Mesh.SurfacePair{1}.primary.Text = 'Primary'; 
e_new.febio_spec.Mesh.SurfacePair{1}.secondary.Text = 'Secondary'; 
e_new.febio_spec.Mesh.SurfacePair{1}.Attributes.name = 'Tied_Elastic_Contact'; 

%% Parameters  

e_new.febio_spec.Contact.contact.laugon.Text = '1';
e_new.febio_spec.Contact.contact.tolerance.Text = '0.2'; 
e_new.febio_spec.Contact.contact.gaptol.Text = '0'; 
e_new.febio_spec.Contact.contact.penalty.Text = '100'; 
e_new.febio_spec.Contact.contact.auto_penalty.Text = '1';
e_new.febio_spec.Contact.contact.two_pass.Text = '1'; 
e_new.febio_spec.Contact.contact.search_tol.Text = '0.01'; 
e_new.febio_spec.Contact.contact.symmetric_stiffness.Text = '0';   
e_new.febio_spec.Contact.contact.search_radius.Text = '0.1';
e_new.febio_spec.Contact.contact.minaug.Text = '0';
e_new.febio_spec.Contact.contact.maxaug.Text = '10';

%%
% %% Master Surface   
% 
% s_out_surface = s_out_surf + num_Nodes_solid;     
% 
% for i = 1 : length(s_out_surface(:, 1))
%     contact_surf1Text = '';     
%     for j = 1 : length(s_out_surface(1, :))
%         contact_surf1Text = [contact_surf1Text, '  ', num2str(s_out_surface(i, j)), ',']; 
%     end
%     contact_surf1Text(end) = '';      
%     
%     e_new.febio_spec.Contact.contact.surface{1}.quad4{i}.Text = contact_surf1Text; 
%     e_new.febio_spec.Contact.contact.surface{1}.quad4{i}.Attributes.id = num2str(i); 
% end
% 
% 
% e_new.febio_spec.Contact.contact.surface{1}.Attributes.type = 'master'; 
% 
% 
% 
% %% Slave Surface   
% 
% solid_top_surface = Elems_Coord_layer(:, 1 : 4) + (num_thickness - 1) * n_l; 
% 
% for i = 1 : length(solid_top_surface(:, 1))
%     contact_surf2Text = '';     
%     for j = 1 : length(solid_top_surface(1, :))
%         contact_surf2Text = [contact_surf2Text, '  ', num2str(solid_top_surface(i, j)), ',']; 
%     end
%     contact_surf2Text(end) = '';      
%     
%     e_new.febio_spec.Contact.contact.surface{2}.quad4{i}.Text = contact_surf2Text; 
%     e_new.febio_spec.Contact.contact.surface{2}.quad4{i}.Attributes.id = num2str(i); 
% end
% 
% e_new.febio_spec.Contact.contact.surface{2}.Attributes.type = 'slave'; 


% %% Attributes 
% 
% e_new.febio_spec.Contact.contact.Attributes.name = 'TCInterface01';
% e_new.febio_spec.Contact.contact.Attributes.type = 'sliding-tension-compression';


%% Attributes 
e_new.febio_spec.Contact.contact.Attributes.type = 'tied-elastic';
e_new.febio_spec.Contact.contact.Attributes.name = 'TEContact';
e_new.febio_spec.Contact.contact.Attributes.surface_pair = 'Tied_Elastic_Contact'; 













