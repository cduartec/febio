%% Nodes 
% Solid Mixture 
l_seg = round(longwidth/0.2);
w_seg = round(width/0.2);
t_seg = round(thickness/0.2);

% basic_nodes_refined = 7; 
% 
% basic_plane_refined = 7; 
% 
% basic_layers_refined = 7; 

elemsize = 0.2;

Sp_rad = 1.25; 

% coarsed_sizes = 3; 

Sp_rad_increment = 0.3; 

% basic_nodes = [0 : elemsize : basic_nodes_refined, basic_nodes_refined + coarsed_sizes : coarsed_sizes : width];
% if basic_nodes(end) ~= width
%     basic_nodes(end)=width; 
% end
% 
% 
% num_basic_nodes = length(basic_nodes); 
basic_nodes = (0 : elemsize : w_seg/5);
if basic_nodes(end) ~= width
    basic_nodes(end)= width; 
end
num_basic_nodes = length(basic_nodes); 
% basic_plane = [0 : elemsize : basic_plane_refined, basic_plane_refined + coarsed_sizes : coarsed_sizes : longwidth];
% if basic_plane(end) ~= longwidth 
%     basic_plane(end)=longwidth; 
% end
% num_plane = length(basic_plane); 
basic_plane = (0 : elemsize : l_seg/5);
if basic_plane(end) ~= longwidth
    basic_plane(end)= longwidth; 
end
num_plane = length(basic_plane); 

Nodes_Coordx = [];   
Nodes_Coordy = []; 
Nodes_Coordz = []; 

% basic_layers = [0 : coarsed_sizes : thickness - basic_plane_refined, thickness - basic_plane_refined + elemsize : elemsize : thickness];
% if basic_layers(end) ~= thickness 
%     basic_layers(end)=thickness; 
% end
% num_thickness = length(basic_layers); 
basic_layers = (0 : elemsize : t_seg/5);
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
%% Sphere Create 
Sphere_Mid_x=sqrt(3)/3; 
     
Sp_1_x_num=round(Sp_rad*pi/4/Sp_rad_increment)+1;
Sp_1_y_num=round(Sp_rad*pi/4/Sp_rad_increment)+1;
 
Sp_1_nodes_ori=[];
Sp_1_nodes = []; 
Sp_2_nodes = [];
Sp_3_nodes = []; 
Sp_nodes_layer1 = []; 
Sp_tot_nodes_n = 0; 

Sp_thickness = 0.1; 

Sp_1_x_ori=linspace(0,sqrt(2)/2,Sp_1_x_num);
Sp_1_y_ori=linspace(0,sqrt(2)/2,Sp_1_y_num); 
 
Sp_1_x_spl=sqrt((1-(linspace(0,Sphere_Mid_x,Sp_1_x_num).^2))/2); 
Sp_1_y_spl=sqrt((1-(linspace(0,Sphere_Mid_x,Sp_1_y_num).^2))/2); 

for i=1:Sp_1_x_num
    for j=1:Sp_1_y_num
        Sp_1_nodes_ori((i-1)*Sp_1_y_num+j,1)=[Sp_1_x_ori(i)*Sp_1_y_spl(j)/Sp_1_y_ori(end)];
        Sp_1_nodes_ori((i-1)*Sp_1_y_num+j,2)=[Sp_1_y_ori(j)*Sp_1_x_spl(i)/Sp_1_x_ori(end)];
    end
end

for i=1:length(Sp_1_nodes_ori)
    Sp_1_nodes_ori(i,3)=sqrt(1-Sp_1_nodes_ori(i,1)^2-Sp_1_nodes_ori(i,2)^2);
end

Sp_1_nodes=Sp_1_nodes_ori;
Sp_1_nodes(:,3)=-Sp_1_nodes_ori(:,3);


% for i=1:length(Sp_1_nodes)
%     plot(Sp_1_nodes(i,1),Sp_1_nodes(i,2), 'o', 'MarkerFaceColor',[i/length(Sp_1_nodes) i/length(Sp_1_nodes) i/length(Sp_1_nodes)])
%     text(Sp_1_nodes(i,1),Sp_1_nodes(i,2),num2str(i))
%     hold on
% 
% end
% 
% for i=1:length(Sp_1_nodes)
%     plot3(Sp_1_nodes(i,1),Sp_1_nodes(i,2),Sp_1_nodes(i,3), 'o', 'MarkerFaceColor',[0 0 i/length(Sp_1_nodes)])
%     text(Sp_1_nodes(i,1),Sp_1_nodes(i,2),Sp_1_nodes(i,3),num2str(i)); 
%     hold on
% 
% end

for i = 1 : length(Sp_1_nodes_ori)
    Sp_2_nodes(i,3)=-Sp_1_nodes_ori(i,1);
    Sp_2_nodes(i,1)=Sp_1_nodes_ori(i,2);
end

for i=1:length(Sp_1_nodes_ori)
    Sp_2_nodes(i,2)=sqrt(1-Sp_2_nodes(i,1)^2-Sp_2_nodes(i,3)^2);
end

% 
% for i=1:length(Sp_2_nodes)
%     plot(Sp_2_nodes(i,3),Sp_2_nodes(i,1), 'o', 'MarkerFaceColor',[i/length(Sp_1_nodes_ori) i/length(Sp_1_nodes_ori) i/length(Sp_1_nodes_ori)])
%     text(Sp_2_nodes(i,3),Sp_2_nodes(i,1),num2str(i))
%     hold on
% 
% end
% 
% for i=1:length(Sp_2_nodes)
%     plot3(Sp_2_nodes(i,1),Sp_2_nodes(i,2),Sp_2_nodes(i,3), 'o', 'MarkerFaceColor',[0 i/length(Sp_1_nodes_ori) 0])
%     text(Sp_2_nodes(i,1),Sp_2_nodes(i,2),Sp_2_nodes(i,3),num2str(i))
%     hold on
% 
% end

for i = 1 : length(Sp_1_nodes_ori)
    Sp_3_nodes(i,2)=Sp_1_nodes_ori(i,1);
    Sp_3_nodes(i,3)=-Sp_1_nodes_ori(i,2);
end

for i=1:length(Sp_1_nodes_ori)
    Sp_3_nodes(i,1)=sqrt(1-Sp_3_nodes(i,2)^2-Sp_3_nodes(i,3)^2);
end

% 
% for i=1:length(Sp_3_nodes)
%     plot(Sp_3_nodes(i,3),Sp_3_nodes(i,1), 'o', 'MarkerFaceColor',[i/length(Sp_1_nodes_ori) i/length(Sp_1_nodes_ori) i/length(Sp_1_nodes_ori)])
%     text(Sp_3_nodes(i,3),Sp_3_nodes(i,1),num2str(i))
%     hold on
% 
% end
% 
% for i=1:length(Sp_3_nodes)
%     plot3(Sp_3_nodes(i,1),Sp_3_nodes(i,2),Sp_3_nodes(i,3), 'o', 'MarkerFaceColor',[i/length(Sp_1_nodes_ori) 0 0])
%     text(Sp_3_nodes(i,1),Sp_3_nodes(i,2),Sp_3_nodes(i,3),num2str(i))
%     hold on
% 
% end

% num_Sp_1_2share = length(Sp_1_nodes)-Sp_1_x_num; 

for i = 1:length(Sp_1_nodes)
    Sp_tot_nodes_n = Sp_tot_nodes_n + 1;  
    Sp_nodes_layer1(Sp_tot_nodes_n).coord = Sp_1_nodes(i,:); 
    Sp_nodes_layer1(Sp_tot_nodes_n).Nodenum=Sp_tot_nodes_n; 
%     if mod(i,Sp_1_x_num)==0
%         num_Sp_1_2share = num_Sp_1_2share+1;
%         Sp_nodes(i).Nodelocal2=num_Sp_1_2share;
%     end
end 

Sp_tot_nodes_1 = Sp_tot_nodes_n; 

for i = 1:length(Sp_2_nodes)
    if i<=length(Sp_2_nodes)-Sp_1_x_num
        Sp_tot_nodes_n = Sp_tot_nodes_n + 1;  
        Sp_nodes_layer1(Sp_tot_nodes_n).coord = Sp_2_nodes(i,:); 
        Sp_nodes_layer1(Sp_tot_nodes_n).Nodenum=Sp_tot_nodes_n; 
    end
end

Sp_tot_nodes_2 = Sp_tot_nodes_n; 

for i =1:length(Sp_3_nodes)
    if i<=length(Sp_3_nodes)-Sp_1_x_num && mod(i,Sp_1_x_num)~=0 
        Sp_tot_nodes_n = Sp_tot_nodes_n + 1; 
        Sp_nodes_layer1(Sp_tot_nodes_n).coord = Sp_3_nodes(i,:); 
        Sp_nodes_layer1(Sp_tot_nodes_n).Nodenum=Sp_tot_nodes_n; 
    end
end

Sp_tot_nodes_n1layer = Sp_tot_nodes_n; 
% 
% for i = 1:length(Sp_nodes_layer1)
%     plot3(Sp_nodes_layer1(i).coord(1),Sp_nodes_layer1(i).coord(2),Sp_nodes_layer1(i).coord(3),'o'); 
%     text(Sp_nodes_layer1(i).coord(1),Sp_nodes_layer1(i).coord(2),Sp_nodes_layer1(i).coord(3),num2str(i));
%     hold on
% end
% xlabel('x');
% ylabel('y');
% zlabel('z');   

for i = 1 : length(Sp_nodes_layer1)
    Sp_tot_nodes_n = Sp_tot_nodes_n + 1; 
    Sp_nodes_phi(i) = acos(Sp_nodes_layer1(i).coord(3)); 
    if Sp_nodes_layer1(i).coord(1)==0 && Sp_nodes_layer1(i).coord(2)==0
        Sp_nodes_theta(i) = 0; 
    else
        Sp_nodes_theta(i) = atan(Sp_nodes_layer1(i).coord(2)/Sp_nodes_layer1(i).coord(1));  
    end
    Sp_nodes_layer2(i).coord = (1 - Sp_thickness) * [sin(Sp_nodes_phi(i))*cos(Sp_nodes_theta(i)), sin(Sp_nodes_phi(i))*sin(Sp_nodes_theta(i)), cos(Sp_nodes_phi(i))]; 
    Sp_nodes_layer2(i).Nodenum = Sp_tot_nodes_n;
end

%     
% for i = 1:length(Sp_nodes_layer2)
%     plot3(Sp_nodes_layer2(i).coord(1),Sp_nodes_layer2(i).coord(2),Sp_nodes_layer2(i).coord(3),'o'); 
%     text(Sp_nodes_layer2(i).coord(1),Sp_nodes_layer2(i).coord(2),Sp_nodes_layer2(i).coord(3),num2str(Sp_nodes_layer2(i).Nodenum));
%     hold on
% end
% xlabel('x');
% ylabel('y');
% zlabel('z');   


Sp_nodes_ori = Sp_nodes_layer1; 

for i = 1 : length(Sp_nodes_layer2)
    tem_Sp_tot_nodesn = length(Sp_nodes_layer1) + i; 
    Sp_nodes_ori(tem_Sp_tot_nodesn) = Sp_nodes_layer2(i); 
end

for i=1:length(Sp_nodes_ori)
    Sp_nodes(i).coord = Sp_rad * Sp_nodes_ori(i).coord + [0,0,Sp_rad]; 
    Sp_nodes(i).Nodenum = Sp_nodes_ori(i).Nodenum; 
end
    
% for i = 1:length(Sp_nodes)
%     plot3(Sp_nodes_ori(i).coord(1),Sp_nodes_ori(i).coord(2),Sp_nodes_ori(i).coord(3),'o'); 
%     text(Sp_nodes_ori(i).coord(1),Sp_nodes_ori(i).coord(2),Sp_nodes_ori(i).coord(3),num2str(Sp_nodes_ori(i).Nodenum));
%     hold on
% end
% xlabel('x');
% ylabel('y');
% zlabel('z');   
% 

% 
% 
% 
% 
% for i = 1:length(Sp_nodes)
%     plot3(Sp_nodes(i).coord(1),Sp_nodes(i).coord(2),Sp_nodes(i).coord(3),'o'); 
%     text(Sp_nodes(i).coord(1),Sp_nodes(i).coord(2),Sp_nodes(i).coord(3),num2str(Sp_nodes(i).Nodenum));
%     hold on
% end
% xlabel('x');
% ylabel('y');
% zlabel('z');   


Sp_tot_elem_n = 0; 

for i = 1 : length(Sp_nodes_ori)
    if i<=Sp_tot_nodes_1-Sp_1_y_num;
        if mod(i, Sp_1_y_num)~=0; 
            Sp_tot_elem_n = Sp_tot_elem_n + 1;     
            Sp_elem(Sp_tot_elem_n).n1 = i; 
            Sp_elem(Sp_tot_elem_n).n4 = i+1;
            Sp_elem(Sp_tot_elem_n).n3 = i+Sp_1_y_num+1;
            Sp_elem(Sp_tot_elem_n).n2 = i+Sp_1_y_num; 
        else 
            Sp_tot_elem_n = Sp_tot_elem_n + 1;     
            Sp_elem(Sp_tot_elem_n).n1 = i; 
            Sp_elem(Sp_tot_elem_n).n4 = i/Sp_1_y_num+Sp_tot_nodes_2-Sp_1_y_num;
            Sp_elem(Sp_tot_elem_n).n3 = i/Sp_1_y_num+Sp_tot_nodes_2-Sp_1_y_num+1;
            Sp_elem(Sp_tot_elem_n).n2 = i+Sp_1_y_num; 
        end
    elseif i<Sp_tot_nodes_1-1; 
        Sp_tot_elem_n = Sp_tot_elem_n + 1; 
        Sp_elem(Sp_tot_elem_n).n1 = i; 
        Sp_elem(Sp_tot_elem_n).n4 = i+1; 
        Sp_elem(Sp_tot_elem_n).n3 = (mod(i,Sp_1_y_num)+1)*(Sp_1_y_num-1)+Sp_tot_nodes_2; 
        Sp_elem(Sp_tot_elem_n).n2 = mod(i,Sp_1_y_num)*(Sp_1_y_num-1)+Sp_tot_nodes_2; 
    elseif i==Sp_tot_nodes_1-1; 
        Sp_tot_elem_n = Sp_tot_elem_n + 1; 
        Sp_elem(Sp_tot_elem_n).n1 = i; 
        Sp_elem(Sp_tot_elem_n).n4 = i+1; 
        Sp_elem(Sp_tot_elem_n).n3 = Sp_tot_nodes_2; 
        Sp_elem(Sp_tot_elem_n).n2 = mod(i,Sp_1_y_num)*(Sp_1_y_num-1)+Sp_tot_nodes_2;     
    elseif i>Sp_tot_nodes_1 && i<=Sp_tot_nodes_2-Sp_1_y_num 
        if mod(i, Sp_1_y_num)~=0; 
            Sp_tot_elem_n = Sp_tot_elem_n + 1;     
            Sp_elem(Sp_tot_elem_n).n1 = i; 
            Sp_elem(Sp_tot_elem_n).n4 = i+1;
            Sp_elem(Sp_tot_elem_n).n3 = i+Sp_1_y_num+1;
            Sp_elem(Sp_tot_elem_n).n2 = i+Sp_1_y_num; 
        else 
            Sp_tot_elem_n = Sp_tot_elem_n + 1;     
            Sp_elem(Sp_tot_elem_n).n1 = i; 
            Sp_elem(Sp_tot_elem_n).n4 = i/Sp_1_y_num+Sp_tot_nodes_n1layer-2*Sp_1_y_num+1;
            Sp_elem(Sp_tot_elem_n).n3 = i/Sp_1_y_num+Sp_tot_nodes_n1layer-2*Sp_1_y_num+1+1;
            Sp_elem(Sp_tot_elem_n).n2 = i+Sp_1_y_num;             
        end
    elseif i>Sp_tot_nodes_2 && i<Sp_tot_nodes_n1layer-Sp_1_y_num+2 && mod((i-Sp_tot_nodes_2),Sp_1_y_num-1)
        Sp_tot_elem_n = Sp_tot_elem_n + 1; 
        Sp_elem(Sp_tot_elem_n).n1 = i; 
        Sp_elem(Sp_tot_elem_n).n4 = i+1; 
        Sp_elem(Sp_tot_elem_n).n3 = i+Sp_1_y_num; 
        Sp_elem(Sp_tot_elem_n).n2 = i+Sp_1_y_num-1; 
    end

    
end     

for i = 1 : length(Sp_elem)
        Sp_elem(i).n5 = Sp_elem(i).n1 + Sp_tot_nodes_n1layer; 
        Sp_elem(i).n6 = Sp_elem(i).n2 + Sp_tot_nodes_n1layer; 
        Sp_elem(i).n7 = Sp_elem(i).n3 + Sp_tot_nodes_n1layer; 
        Sp_elem(i).n8 = Sp_elem(i).n4 + Sp_tot_nodes_n1layer; 
end
% 
% for i = 1 : length(Sp_elem)
%     plot3([Sp_nodes(Sp_elem(i).n1).coord(1), Sp_nodes(Sp_elem(i).n2).coord(1), Sp_nodes(Sp_elem(i).n3).coord(1), Sp_nodes(Sp_elem(i).n4).coord(1), Sp_nodes(Sp_elem(i).n1).coord(1)], ...
%         [Sp_nodes(Sp_elem(i).n1).coord(2), Sp_nodes(Sp_elem(i).n2).coord(2), Sp_nodes(Sp_elem(i).n3).coord(2), Sp_nodes(Sp_elem(i).n4).coord(2), Sp_nodes(Sp_elem(i).n1).coord(2)], ...
%         [Sp_nodes(Sp_elem(i).n1).coord(3), Sp_nodes(Sp_elem(i).n2).coord(3), Sp_nodes(Sp_elem(i).n3).coord(3), Sp_nodes(Sp_elem(i).n4).coord(3), Sp_nodes(Sp_elem(i).n1).coord(3)]); 
%     hold on
% end

% for i = 1 : length(Sp_elem)
%     plot3([Sp_nodes(Sp_elem(i).n5).coord(1), Sp_nodes(Sp_elem(i).n6).coord(1), Sp_nodes(Sp_elem(i).n7).coord(1), Sp_nodes(Sp_elem(i).n8).coord(1), Sp_nodes(Sp_elem(i).n5).coord(1)], ...
%         [Sp_nodes(Sp_elem(i).n5).coord(2), Sp_nodes(Sp_elem(i).n6).coord(2), Sp_nodes(Sp_elem(i).n7).coord(2), Sp_nodes(Sp_elem(i).n8).coord(2), Sp_nodes(Sp_elem(i).n5).coord(2)], ...
%         [Sp_nodes(Sp_elem(i).n5).coord(3), Sp_nodes(Sp_elem(i).n6).coord(3), Sp_nodes(Sp_elem(i).n7).coord(3), Sp_nodes(Sp_elem(i).n8).coord(3), Sp_nodes(Sp_elem(i).n5).coord(3)]); 
%     hold on
% end
% 

for i=1:length(Sp_nodes)
    s_node(i,:) = Sp_nodes(i).coord; 
end

for i=1:length(Sp_elem)
    s_elems(i,1)=Sp_elem(i).n1;        
    s_elems(i,2)=Sp_elem(i).n2;        
    s_elems(i,3)=Sp_elem(i).n3;        
    s_elems(i,4)=Sp_elem(i).n4;        
    s_elems(i,5)=Sp_elem(i).n5;        
    s_elems(i,6)=Sp_elem(i).n6;        
    s_elems(i,7)=Sp_elem(i).n7;        
    s_elems(i,8)=Sp_elem(i).n8;        
end

for i=1:length(Sp_elem)
    s_out_surf(i,1)=Sp_elem(i).n1;        
    s_out_surf(i,2)=Sp_elem(i).n4;        
    s_out_surf(i,3)=Sp_elem(i).n3;        
    s_out_surf(i,4)=Sp_elem(i).n2;       
end

sphere_node = round(s_node, 6);

num_Nodes_sphere = length(sphere_node(:, 1));

%% Elements 

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




% Sphere 

sphere_elems = s_elems + num_Nodes_solid; 

num_Elems_sphere = length(sphere_elems(:, 1));

%% Results Wrttiing 
for i = 1 : length(Nodes_Coordx)
    e_test.febio_spec.Geometry.Nodes.node{i}.Text = [num2str(Nodes_Coord(1, i)), ',', num2str(Nodes_Coord(2, i)), ',', num2str(Nodes_Coord(3, i))]; 
    e_test.febio_spec.Geometry.Nodes.node{i}.Attributes.id = num2str(i); 
    
end

for i = 1 : num_Nodes_sphere 
    e_test.febio_spec.Geometry.Nodes.node{num_Nodes_solid + i}.Text = [num2str(sphere_node(i, 1)), ',', num2str(sphere_node(i, 2)), ',', num2str(sphere_node(i, 3))];
    e_test.febio_spec.Geometry.Nodes.node{num_Nodes_solid + i}.Attributes.id = num2str(num_Nodes_solid + i); 
end


for i = 1 : length(Elems_Coord(:, 1))
    elemText = ''; 
    for j = 1 : length(Elems_Coord(1, :))
        elemText = [elemText, '     ', num2str(Elems_Coord(i, j)), ',']; 
    end
    elemText(end) = ''; 
    e_test.febio_spec.Geometry.Elements{1}.elem{i}.Text = elemText; 
    e_test.febio_spec.Geometry.Elements{1}.elem{i}.Attributes.id = num2str(i); 
    
end   

e_test.febio_spec.Geometry.Elements{1}.Attributes.elset = 'solid_mixture'; 
e_test.febio_spec.Geometry.Elements{1}.Attributes.type = 'hex8'; 

for i = 1 : num_Elems_sphere 
    elemText = ''; 
    for j = 1 : length(sphere_elems(1, :))
        elemText = [elemText, '     ', num2str(sphere_elems(i, j)), ',']; 
    end
    elemText(end) = ''; 
    e_test.febio_spec.Geometry.Elements{2}.elem{i}.Text = elemText; 
    e_test.febio_spec.Geometry.Elements{2}.elem{i}.Attributes.id = num2str(num_Elems_solid + i); 
end   

e_test.febio_spec.Geometry.Elements{2}.Attributes.elset = 'indenter'; 
e_test.febio_spec.Geometry.Elements{2}.Attributes.type = 'hex8'; 

e_new = e_test; 
 
 
 
 
 
 
 
 
 
 
 