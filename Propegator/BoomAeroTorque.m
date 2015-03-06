function [ BoomAeroT ] = BoomAeroTorque( Alt1, BoomLength,Velocity,Pitch)

A=BoomLength*0.05+0.1*0.1; %surface area of the satellite in nominal orientation
Ct=-1.762E-4; %Coefficent of torque of the satellite
load('MSIS.mat');

rho=spline(MSIS(:,1),MSIS(:,5),Alt1); %density in g/cm^3
rho=rho*1000;

BoomAeroT=0.5*Ct*A*rho*cos(Pitch)*Velocity^2;

end
