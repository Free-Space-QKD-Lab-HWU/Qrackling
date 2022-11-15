function [X, Y]=StripDataFromGraph(Image)
%% show an image in a figure, then walk the user through extracting it in numerical format


%if image is a path to an image, open it
if ischar(Image)||isstring(Image)
    Image = imread(Image);
end
%% show image
imshow(Image);
ImageDimensions=size(Image);

%% input Y axis values
fprintf('Click on Y axis ticks. Press return when done\n');
[~,YAxisPixels,~]=ginput();

%% input Y axis numerical values
Input=inputdlg('Enter Y axis tick values, space separated');
YAxisNumbers=str2num(Input{1}); %#ok<*ST2NM> 
while numel(YAxisNumbers)~=numel(YAxisPixels)
    Input=inputdlg('Enter Y axis tick values, space separated. Must be same number as ticks');
    YAxisNumbers=str2num(Input{1});
end
%compute Y axis number for each Y pixel
[Y_Gradient,Y_Intercept]=LinearRegression(YAxisPixels,YAxisNumbers);
YAxisValues=Y_Gradient*(1:ImageDimensions(1))+Y_Intercept;
%this array can be used as a lookup table from pixel to number in the y
%axis




%% input X axis values
fprintf('Click on X axis ticks. Press return when done\n');
[XAxisPixels,~,~]=ginput();

%% input Y axis numerical values
Input=inputdlg('Enter X axis tick values, space separated');
XAxisNumbers=str2num(Input{1}); %#ok<*ST2NM> 
while numel(XAxisNumbers)~=numel(XAxisPixels)
    Input=inputdlg('Enter X axis tick values, space separated. Must be same number as ticks');
    XAxisNumbers=str2num(Input{1});
end
%compute X axis number for each X pixel
[X_Gradient,X_Intercept]=LinearRegression(XAxisPixels,XAxisNumbers);
XAxisValues=X_Gradient*(1:ImageDimensions(2))+X_Intercept;
%this array can be used as a lookup table from pixel to number in the x
%axis



%% input graph line
fprintf('click on points on graph to trace graph.\nRight click to finish\n')
DoneFlag=false;

%prepare numeric storage
X=[];
XPlotPixels=[];
Y=[];
YPlotPixels=[];

while ~DoneFlag
    %get mouse input
    [x,y,button]=ginput(1);
    
    switch button
        case 1
    %lookup numeric values and store
    X=[X,interp1(1:ImageDimensions(2),XAxisValues,x)]; %#ok<*AGROW> 
    Y=[Y,interp1(1:ImageDimensions(1),YAxisValues,y)];

    %plot point
    XPlotPixels=[XPlotPixels,x];
    YPlotPixels=[YPlotPixels,y];
    imshow(Image);
    hold on
    plot(XPlotPixels,YPlotPixels,'g*--');
    drawnow
    hold off
        case 3
            DoneFlag=true;
    end
end


