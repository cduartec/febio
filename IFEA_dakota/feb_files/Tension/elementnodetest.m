%% Nodes 
% Solid Mixture 
l_seg = round(width/0.4);
w_seg = round(lenght/0.4);
t_seg = round(thickness/0.4);

elemsize = 0.4;

basic_nodes = (0 : elemsize : w_seg/2.5);
if basic_nodes(end) ~= lenght
    basic_nodes(end)= lenght; 
end
num_basic_nodes = length(basic_nodes); 

basic_plane = (0 : elemsize : l_seg/2.5);
if basic_plane(end) ~= width
    basic_plane(end)= width; 
end
num_plane = length(basic_plane); 

Nodes_Coordx = [];   
Nodes_Coordy = []; 
Nodes_Coordz = []; 

basic_layers = (0 : elemsize : t_seg/2.5);
if basic_layers(end) ~= thickness 
    basic_layers(end)=thickness; 
end
num_thickness = length(basic_layers); 

for i = 1 : num_thickness 
    for j = 1 : num_plane       
        for k = 1 : num_basic_nodes     
            Nodes_Coordx(k + (j - 1)*num_basic_nodes + (i - 1)*num_plane*num_basic_nodes) = basic_nodes(k);
            Nodes_Coordy(k + (j - 1)*num_basic_nodes + (i - 1)*num_plane*num_basic_nodes) = basic_plane(j);
            Nodes_Coordz(k + (j - 1)*num_basic_nodes + (i - 1)*num_plane*num_basic_nodes) = basic_layers(i)-thickness;
        
        end
    end
end

Nodes_Coord = [Nodes_Coordx;   
                Nodes_Coordy; 
                Nodes_Coordz];  
num_Nodes_solid = length(Nodes_Coordx); 
% top grip 
l_seg_g = 1;
w_seg_g = 1;
t_seg_g = 1;

basic_nodes_g = (0:w_seg:w_seg);
if basic_nodes_g(end) ~= lenght
    basic_nodes_g(end)= lenght; 
end
num_basic_nodes_g = length(basic_nodes_g); 

basic_plane_g = (0 : l_seg : l_seg);
if basic_plane_g(end) ~= width
    basic_plane_g(end)= width; 
end
num_plane_g = length(basic_plane_g); 

Nodes_Coordx_g = [];   
Nodes_Coordy_g = []; 
Nodes_Coordz_g = []; 

basic_layers_g = (0 : t_seg : t_seg);
if basic_layers_g(end) ~= 1 
    basic_layers_g(end)=1; 
end
num_thickness_g = length(basic_layers_g); 

for i = 1 : num_thickness_g 
    for j = 1 : num_plane_g       
        for k = 1 : num_basic_nodes_g     
            Nodes_Coordx_g(k + (j - 1)*num_basic_nodes_g + (i - 1)*num_plane_g*num_basic_nodes_g) = basic_nodes_g(k);
            Nodes_Coordy_g(k + (j - 1)*num_basic_nodes_g + (i - 1)*num_plane_g*num_basic_nodes_g) = basic_plane_g(j);
            Nodes_Coordz_g(k + (j - 1)*num_basic_nodes_g + (i - 1)*num_plane_g*num_basic_nodes_g) = basic_layers_g(i);
        
        end
    end
end

Nodes_Coord_g = [Nodes_Coordx_g;   
                Nodes_Coordy_g; 
                Nodes_Coordz_g];  
num_Nodes_solid_g = length(Nodes_Coordx_g); 
%% element number
Sp_tot_elem_n = 0; 
Sp_elem = [];
% Elements 

% Solid Mixture 
n_d = num_basic_nodes; 
n_t = num_plane; 
n_l = n_d * n_t; 

for i = 1 : 1 : n_d - 1    
        Elems_Coord_1(i, :) = i; 
        Elems_Coord_2(i, :) = i + 1; 
        Elems_Coord_3(i, :) = i + n_d + 1;   
        Elems_Coord_4(i, :) = i + n_d; 
        Elems_Coord_5(i, :) = Elems_Coord_1(i) + n_l; 
        Elems_Coord_6(i, :) = Elems_Coord_2(i) + n_l; 
        Elems_Coord_7(i, :) = Elems_Coord_3(i) + n_l; 
        Elems_Coord_8(i, :) = Elems_Coord_4(i) + n_l; 
end
Elems_Coord_basic = [Elems_Coord_1, Elems_Coord_2, Elems_Coord_3, Elems_Coord_4, ...
               Elems_Coord_5, Elems_Coord_6, Elems_Coord_7, Elems_Coord_8]; 
           
for j = 1 : 1 : n_t - 1 
    Elems_Coord_layer((j - 1) * (n_d - 1) + 1 : j * (n_d - 1), :) = Elems_Coord_basic + (j - 1) * n_d; 
end

Elems_Coord = [];     

for k = 1 : 1 : num_thickness - 1  
    Elems_Coord = [Elems_Coord ; Elems_Coord_layer + (k - 1) * n_l]; 
end

num_Elems_solid = length(Elems_Coord(:, 1)); 
% Top grip 
Elems_Coord_g_1 = num_Nodes_solid+1; 
Elems_Coord_g_2 = num_Nodes_solid+2; 
Elems_Coord_g_3 = num_Nodes_solid+4;   
Elems_Coord_g_4 = num_Nodes_solid+3; 
Elems_Coord_g_5 = Elems_Coord_g_1 + 4; 
Elems_Coord_g_6 = Elems_Coord_g_2 + 4; 
Elems_Coord_g_7 = Elems_Coord_g_3 + 4; 
Elems_Coord_g_8 = Elems_Coord_g_4 + 4; 

Elems_Coord_g = [Elems_Coord_g_1, Elems_Coord_g_2, Elems_Coord_g_3, Elems_Coord_g_4, ...
               Elems_Coord_g_5, Elems_Coord_g_6, Elems_Coord_g_7, Elems_Coord_g_8]; 

s_out_surf(1) = Elems_Coord_g_1;
s_out_surf(2) = Elems_Coord_g_4;
s_out_surf(3) = Elems_Coord_g_3;
s_out_surf(4) = Elems_Coord_g_2;
           
grip_elems = Elems_Coord_g + num_Nodes_solid;
num_Elems_solid_g = length(grip_elems(:, 1)); 
%% Results Wrttiing 
for i = 1 : length(Nodes_Coordx)
    e_test.febio_spec.Mesh.Nodes.node{i}.Text = [num2str(Nodes_Coord(1, i)), ',', num2str(Nodes_Coord(2, i)), ',', num2str(Nodes_Coord(3, i))]; 
    e_test.febio_spec.Mesh.Nodes.node{i}.Attributes.id = num2str(i); 
end

for i = 1 : length(Nodes_Coordx_g)
    e_test.febio_spec.Mesh.Nodes.node{num_Nodes_solid+i}.Text = [num2str(Nodes_Coord_g(1, i)), ',', num2str(Nodes_Coord_g(2, i)), ',', num2str(Nodes_Coord_g(3, i))]; 
    e_test.febio_spec.Mesh.Nodes.node{num_Nodes_solid+i}.Attributes.id = num2str(num_Nodes_solid+i); 
end

for i = 1 : length(Elems_Coord(:, 1))
    elemText = ''; 
    for j = 1 : length(Elems_Coord(1, :))
        elemText = [elemText, '     ', num2str(Elems_Coord(i, j)), ',']; 
    end
    elemText(end) = ''; 
    e_test.febio_spec.Mesh.Elements{1}.elem{i}.Text = elemText; 
    e_test.febio_spec.Mesh.Elements{1}.elem{i}.Attributes.id = num2str(i); 
    
end   

e_test.febio_spec.Mesh.Elements{1}.Attributes.name = 'solid_mixture'; 
e_test.febio_spec.Mesh.Elements{1}.Attributes.type = 'hex8'; 

for i = 1 : length(Elems_Coord_g(:, 1))
    elemText_g = ''; 
    for j = 1 : length(Elems_Coord_g(1, :))
        elemText_g = [elemText_g, '     ', num2str(Elems_Coord_g(i, j)), ',']; 
    end
    elemText_g(end) = ''; 
    e_test.febio_spec.Mesh.Elements{2}.elem{i}.Text = elemText_g; 
    e_test.febio_spec.Mesh.Elements{2}.elem{i}.Attributes.id = num2str(num_Elems_solid+i); 
    
end   

e_test.febio_spec.Mesh.Elements{2}.Attributes.name = 'top_grip'; 
e_test.febio_spec.Mesh.Elements{2}.Attributes.type = 'hex8'; 

e_new = e_test; 
 

%% Mesh domains

e_new.febio_spec.MeshDomains.SolidDomain{1}.Attributes.name = 'top_grip'; 
e_new.febio_spec.MeshDomains.SolidDomain{1}.Attributes.mat = 'Top_grip'; 
e_new.febio_spec.MeshDomains.SolidDomain{2}.Attributes.name = 'solid_mixture'; 
e_new.febio_spec.MeshDomains.SolidDomain{2}.Attributes.mat = 'Sample'; 
 
