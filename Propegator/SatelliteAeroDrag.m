function [ SatAeroDrag ] = SatelliteAeroDrag( Alt1, BoomLength,Velocity)

A=BoomLength*0.05+0.1*0.1; %surface area of the satellite in nominal orientation
Cd=1.18; %Coefficent of drag of the satellite
load('MSIS.mat');

rho=spline(MSIS(:,1),MSIS(:,5),Alt1); %density in g/cm^3
rho=rho*1000;

SatAeroDrag=0.5*Cd*A*rho*Velocity^2;




end
