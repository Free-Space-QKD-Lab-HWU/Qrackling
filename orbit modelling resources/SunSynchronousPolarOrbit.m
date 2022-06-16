function [Inclination_deg,Period_s,Period_hr]=SunSynchronousPolarOrbit(Altitude_km)
%%returns the inclination and period of a sun synchronous circular polar
%%orbit of a given altitude

R_earth=6378.1; %radius of earth in km
R_earth_Array=R_earth*ones(size(Altitude_km));
J_2=1.08263*10^-3; %coefficient of the second zonal term of the earth (property of the oblateness of the earth) (dimensionless)
mu=398600.440; %standard gravitational parameter of the earth in km^3/s^2
rho=1.90096871*10^-7; %precession of the orbit in rads/s to achieve sun synchronicity

Period_s=2*pi*(((R_earth_Array+Altitude_km).^3)./mu).^(1/2);
Period_hr=Period_s./3600;

Inclination_deg=acosd(-(2*rho*(R_earth_Array+Altitude_km).^(7/2))./(2*J_2*(R_earth^2)*(mu)^(1/2)));