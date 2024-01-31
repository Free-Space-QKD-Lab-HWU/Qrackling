function [Latout,Longout]=MoveAlongSurface(Latin,Longin,Arc,heading)
%%MOVEALONGSURFACE move by an arc angle (arcdistance over sphere radius) at a
% given heading on the surface of a sphere using geographical coords

%% input validation
if numel(Arc)>1||numel(Latin)>1||numel(Longin)>1
    error('this function must be used for a single arc angle and input lat,lon pair at a time')
end

%check for arc=180. this produces heading-independent results
if abs(Arc)==pi
    Latout=-Latin*ones(size(heading));
    Longout=(Longin-180)*ones(size(heading));
else

    %convert arcdistance to degrees
    Arc_deg=Arc*180/pi;
    %initial computation
    Latout=Latin+Arc_deg*cosd(heading);
    %do all computations
    Longout=Longin+tand(heading).*(180/pi).*(atanh(sind(Latin+Arc_deg*cosd(heading)))-atanh(sind(Latin)));
    %then redo those with heading=+-90 to remove inf results
    if any(abs(heading)==90)
        Longout(abs(heading)==90)=Longin+sign(heading(abs(heading)==90)).*Arc_deg/cosd(Latin);
    end
    %if latitude if +-90, longitude is poorly defined
    Longout(abs(Latout)==90)=0;
end



%check for out of range values
%latitude range
%bound into +-360
Latout(Latout>=360)=Latout(Latout>=360)-360;
Latout(Latout<=-360)=Latout(Latout<=-360)+360;
%bound into +-90
Longout(abs(Latout)>90)=Longout(abs(Latout)>90)-180;
Latout(abs(Latout)>90)=180-Latout(abs(Latout)>90);

%longitude range
%bound to +-180
Longout(Longout>180)=Longout(Longout>180)-360;
Longout(Longout<-180)=Longout(Longout<-180)+360;
