function [Headings,Elevations]=HeadingAndElevation(R)
%% compute the heading and elevation in degrees of a nx3 vector r with x,y,z components as row elements

%% input validation
if ~isnumeric(R)
    error('input to HeadingAndElevation must be numeric')
end
sz=size(R);
if ~sz(2)==3
    error('input to HeadingAndElevation must be a n by 3 array')
end

%% separate columns
Xs=R(:,1);
Ys=R(:,2);
Zs=R(:,3);

%% compute Headings and Elevations
Headings=atan2d(Xs,Ys);
Elevations=atan2d(Zs,Row2Norms([Xs,Ys]));
 
%keep heading positive between 0 and 360
Headings_too_low=Headings<0;
Headings(Headings_too_low)=Headings(Headings_too_low)+360;

