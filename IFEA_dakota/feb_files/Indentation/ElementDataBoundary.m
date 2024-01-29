%% Initialization 

boundary_x = [];
boundary_y = [];
boundary_z = []; 


%% Get Nodes Information   
xmin = min(Nodes_Coord(1, :));
ymin = min(Nodes_Coord(2, :));
zmin = min(Nodes_Coord(3, :));

for i = 1:length(Nodes_Coord)
    if Nodes_Coord(3, i) == -thickness
    	boundary_z = [boundary_z i];
    end
    if Nodes_Coord(1, i) == 0
        boundary_x = [boundary_x i];
    end
    if Nodes_Coord(2, i) == 0
        boundary_y = [boundary_y i];
    end
    
end

e_boundary_z_nset.node = cell(1, length(boundary_z)); 
e_boundary_z_nset.Attributes.name = 'FixedBottom_z';
for i = 1 : length(e_boundary_z_nset.node)
    e_boundary_z_nset.node{i}.Attributes.id = num2str(boundary_z(i)); 
end


e_boundary_y_nset.node = cell(1, length(boundary_y)); 
e_boundary_y_nset.Attributes.name = 'FixedSide_y';
for i = 1 : length(e_boundary_y_nset.node)
    e_boundary_y_nset.node{i}.Attributes.id = num2str(boundary_y(i)); 
end


e_boundary_x_nset.node = cell(1, length(boundary_x)); 
e_boundary_x_nset.Attributes.name = 'FixedSide_x';
for i = 1 : length(e_boundary_x_nset.node)
    e_boundary_x_nset.node{i}.Attributes.id = num2str(boundary_x(i)); 
end


%% Get Element Information   
% if strcmp(Elem_solidmixture.Attributes.type, 'hex8') 
%     elem_nodes = 8; 
% elseif strcmp(Elem_solidmixture.Attributes.type, 'tet4') 
%     elem_nodes = 4; 
% elseif strcmp(Elem_solidmixture.Attributes.type, 'tet10') 
%     elem_nodes = 10; 
% end
% 
% solid_elems = zeros(length(Elem_solidmixture.elem), elem_nodes) ; 
% 
% for i = 1 : length(Elem_solidmixture.elem) 
%     elem_cell = strsplit(Elem_solidmixture.elem{1, i}.Text); 
%     for j = 2 : length(elem_cell)
%         solid_elems(i, j - 1) = str2num(elem_cell{j}); 
%     end
% end
% 
% elementdata = zeros(length(Elem_solidmixture.elem), 3);   
% 
% for i = 1 : length(Elem_solidmixture.elem)
%     x_sum = 0; 
%     y_sum = 0;   
%     for j = 1 : elem_nodes  
%         x_sum = x_sum + nodes(solid_elems(i, j), 1) ;   
%         y_sum = y_sum + nodes(solid_elems(i, j), 2) ;  
%     end 
%     elementdata(i, :) = [-y_sum, x_sum, 0] / elem_nodes; 
% end
% 
% 
% for i = 1 : length(Elem_solidmixture.elem)
%     elemdata.element{1, i}.fiber.Attributes.type = 'vector'; 
%     elemdata.element{1, i}.Attributes = Elem_solidmixture.elem{1, i}.Attributes;     
%     elemdata.element{1, i}.fiber.Text = [num2str(elementdata(i, 1)),',', num2str(elementdata(i, 2)),',', num2str(elementdata(i, 3))];  
% end

%% Results 
% e_new.febio_spec.Boundary.fix{1} = e_boundary_x;
% e_new.febio_spec.Boundary.fix{2} = e_boundary_z;
% e_new.febio_spec.Boundary.fix{3} = e_boundary_y;
% e_new.febio_spec.Mesh.ElementData = elemdata;  
% Fixed Surfaces 
% e_new.febio_spec.Mesh.NodeSet{1} = e_boundary_x_nset;
e_new.febio_spec.Mesh.NodeSet{1} = e_boundary_z_nset;
e_new.febio_spec.Mesh.NodeSet{2} = e_boundary_x_nset;
e_new.febio_spec.Mesh.NodeSet{3} = e_boundary_y_nset;
% e_new.febio_spec.Boundary.fix{1}.Attributes.bc = 'x'; 
% e_new.febio_spec.Boundary.fix{1}.Attributes.node_set = 'Fixed_D_x'; 
e_new.febio_spec.Boundary.bc{3}.Attributes.type = 'fix'; 
e_new.febio_spec.Boundary.bc{3}.Attributes.name = 'FixedDisplacementZ';
e_new.febio_spec.Boundary.bc{3}.Attributes.node_set = 'FixedBottom_z'; 
e_new.febio_spec.Boundary.bc{3}.dofs.Text = 'z';
e_new.febio_spec.Boundary.bc{1}.Attributes.type = 'fix'; 
e_new.febio_spec.Boundary.bc{1}.Attributes.name = 'FixedDisplacementX';
e_new.febio_spec.Boundary.bc{1}.Attributes.node_set = 'FixedSide_x'; 
e_new.febio_spec.Boundary.bc{1}.dofs.Text = 'x';
e_new.febio_spec.Boundary.bc{2}.Attributes.type = 'fix'; 
e_new.febio_spec.Boundary.bc{2}.Attributes.name = 'FixedDisplacementY';
e_new.febio_spec.Boundary.bc{2}.Attributes.node_set = 'FixedSide_y'; 
e_new.febio_spec.Boundary.bc{2}.dofs.Text = 'y';


% Rigid Body
e_new.febio_spec.Rigid.rigid_constraint{1}.Attributes.name= 'RigidFixed01'; 
e_new.febio_spec.Rigid.rigid_constraint{1}.Attributes.type= 'fix'; 
e_new.febio_spec.Rigid.rigid_constraint{1}.rb.Text = '1'; 
e_new.febio_spec.Rigid.rigid_constraint{1}.dofs.Text = 'Rx,Ry,Ru,Rv,Rw'; 

e_new.febio_spec.Rigid.rigid_constraint{2}.Attributes.name= 'RigidDipsZ01'; 
e_new.febio_spec.Rigid.rigid_constraint{2}.Attributes.type= 'prescribe'; 
e_new.febio_spec.Rigid.rigid_constraint{2}.rb.Text = '1'; 
e_new.febio_spec.Rigid.rigid_constraint{2}.dof.Text = 'Rz'; 
e_new.febio_spec.Rigid.rigid_constraint{2}.value.Attributes.lc = '1'; 
e_new.febio_spec.Rigid.rigid_constraint{2}.value.Text = num2str(-indentation_disp);
e_new.febio_spec.Rigid.rigid_constraint{2}.relative.Text = '0';









