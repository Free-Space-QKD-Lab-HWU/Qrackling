function Angle=ComputeLOSWindow(H,Elevation_Limit)
%% compute the arcdistance (coordinate change) which a ground station can communicate with at a given altitude
R=earthRadius;
v=cosd(Elevation_Limit);
b=R./(R+H);

Angle=acos(v.^2.*b+sqrt((v.^4).*(b.^2)-(v.^2).*(b.^2+1)+1));