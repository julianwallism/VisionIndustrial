% This code belongs to our classmate Cristian Comellas and his groupmates
close all;

% Options figure configuration
fig_options = uifigure('Name', "Options", "WindowStyle", "alwaysontop", 'HandleVisibility', 'on');
g = uigridlayout(fig_options, [2 2]);
g.ColumnWidth = {'1x','4x'};

% Subplots deletion configuration
global subplots_to_delete;
subplots_to_delete = cell(2, 1);
subplots_to_delete{1} = 0;
subplots_to_delete{2} = 0;

% Global sliders
global slider_angle;
global slider_rho;
global slider_theta_min;
global slider_theta_max;
global slider_npeaks;
global slider_threshold;
global slider_threshold_edge;

% Rotation angle slider configuration
slider_angle = uislider(g, "Limits", [0 360], "Value", 0, ...
    'ValueChangedFcn',@(sld,event) applyTransformToImages());
slider_angle.Layout.Row = 1;
slider_angle.Layout.Column = 2;

% Rotation angle label configuration
label_angle = uilabel(g, "Text","Angulo de rotación");
label_angle.Layout.Row = 1;
label_angle.Layout.Column = 1;

% Rho slider configuration
slider_rho = uislider(g, "Limits", [0.5 10], "Value", 1, ...
    'ValueChangedFcn',@(sld,event) applyTransformToImages());
slider_rho.Layout.Row = 2;
slider_rho.Layout.Column = 2;

% Rho label configuration
label_rho = uilabel(g, "Text","Resolución de Rho");
label_rho.Layout.Row = 2;
label_rho.Layout.Column = 1;

% Min Theta slider configuration
slider_theta_min = uislider(g, "Limits", [-90 89], "Value", -90, ...
    'ValueChangedFcn',@(sld,event) applyTransformToImages());
slider_theta_min.Layout.Row = 3;
slider_theta_min.Layout.Column = 2;

% Min Theta label
label_theta_min = uilabel(g, "Text","Valor 1 Theta");
label_theta_min.Layout.Row = 3;
label_theta_min.Layout.Column = 1;

% Max Theta slider configuration
slider_theta_max = uislider(g, "Limits", [-90 89], "Value", 89, ...
    'ValueChangedFcn',@(sld,event) applyTransformToImages());
slider_theta_max.Layout.Row = 4;
slider_theta_max.Layout.Column = 2;

% Max Theta label
label_theta_max = uilabel(g, "Text","Valor 2 Theta");
label_theta_max.Layout.Row = 4;
label_theta_max.Layout.Column = 1;

% Number of peaks slider configuration
slider_npeaks = uislider(g, "Limits", [1 100], "Value", 5, ...
    'ValueChangedFcn',@(sld,event) applyTransformToImages());
slider_npeaks.Layout.Row = 5;
slider_npeaks.Layout.Column = 2;

% Number of peaks label
label_npeaks = uilabel(g, "Text","Número de peaks");
label_npeaks.Layout.Row = 5;
label_npeaks.Layout.Column = 1;

% Threshold slider configuration
slider_threshold = uislider(g, "Limits", [0.1 1.0], "Value", 0.3, ...
    'ValueChangedFcn',@(sld,event) applyTransformToImages());
slider_threshold.Layout.Row = 6;
slider_threshold.Layout.Column = 2;

% Threshold label
label_threshold = uilabel(g, "Text","Peaks Threshold");
label_threshold.Layout.Row = 6;
label_threshold.Layout.Column = 1;

% Threshold edge slider configuration
slider_threshold_edge = uislider(g, "Limits", [0.1 1.0], "Value", 0.3, ...
    'ValueChangedFcn',@(sld,event) applyTransformToImages());
slider_threshold_edge.Layout.Row = 7;
slider_threshold_edge.Layout.Column = 2;

% Threshold label
label_threshold_edge = uilabel(g, "Text","Edge Threshold");
label_threshold_edge.Layout.Row = 7;
label_threshold_edge.Layout.Column = 1;

% Load data
image_circuit = imread('circuit.tif');
image_gantry = im2gray(imread('road.jpg'));

% Image configuration
global images;
images = cell(2, 1);
images{1} = image_circuit;
images{2} = image_gantry;

% Call Hough Transform function
applyTransformToImages();

function subplot_to_delete = calculateHoughTransformation(image, fig_num)
    global slider_angle;
    global slider_rho;
    global slider_theta_min;
    global slider_theta_max;
    global slider_npeaks;
    global slider_threshold;
    global slider_threshold_edge;

    % Rotate the image
    imageRotated = imrotate(image, slider_angle.Value, 'crop');
    
    % Extract the edges
    bw_edge_image = edge(imageRotated,'canny', slider_threshold_edge.Value);
    
    % take max and min value from sliders
    if slider_theta_min.Value > slider_theta_max.Value
        mininum = floor(slider_theta_max.Value);
        maximum = floor(slider_theta_min.Value);
    else
        maximum = floor(slider_theta_max.Value);
        mininum = floor(slider_theta_min.Value);
    end

    % Apply hough transform
    [hough_value,theta,rho] = hough(bw_edge_image, ...
        'RhoResolution', slider_rho.Value, ...
        'Theta', mininum:maximum);
    
    % Get peaks
    peaks = houghpeaks(hough_value,floor(slider_npeaks.Value),'threshold',ceil(slider_threshold.Value*max(hough_value(:))), 'Theta', theta);
    
    % Get detected lines
    lines = houghlines(bw_edge_image,theta,rho,peaks,'FillGap',5,'MinLength',7);
    
    % Get images
    fig_images = figure(fig_num);
    fig_images.Name = "Hough Transform Images";
    
    % Display rotated image
    subplot(2,3,1),imshow(imageRotated), title("Imagen rotada");
    
    % Display image edges
    subplot(2,3,2),imshow(bw_edge_image), title("Bordes de la imagen");
    
    % Plot curves graph
    subplot_to_delete = subplot(2,3,5);imshow(imadjust(rescale(hough_value)),[],...
           'XData',theta,...
           'YData',rho,...
           'InitialMagnification','fit'), title("Gráfico de curvas");
    xlabel('\theta (degrees)')
    ylabel('\rho')
    axis on
    axis normal 
    hold on
    colormap(gca,hot)
    
    % Plot peaks
    x = theta(peaks(:,2));
    y = rho(peaks(:,1));
    plot(x,y,'s','color','blue');
    
    % Plot found images
    subplot(2,3,3), imshow(imageRotated), title("Líneas encontradas"), hold on
    max_len = 0;
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
       % Determine the endpoints of the longest line segment
       len = norm(lines(k).point1 - lines(k).point2);
       if ( len > max_len)
          max_len = len;
          xy_long = xy;
       end
    end

    % Highlight the longest line segment
    plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
end

function applyTransformToImages()
    global images
    global subplots_to_delete
    length = numel(images);
    for i = 1:length
        % If there's subplots to de deleted, delete them
        if(subplots_to_delete{i} ~= 0)
            delete(subplots_to_delete{i});
        end

        % Calculate Hough Transformation
        subplots_to_delete{i} = calculateHoughTransformation(images{i}, i);
    end
end
