function J=Momentsofinertia(L)

% moments of interia of ExAlta 1
% M - mass of the satellite
% mb - mass of the boom
% mm - mass of the magnetometer

% w - width
% h - hiegth
% l - length of the satellite
% L - length of the boom
% Detumbling configuration
M = 3; % kg
d = 0.10; % m       BodyZ
h = 0.10; % m       BodyY
w = 0.3405; % m     BodyX

% Launch configuration
% I3 = 0.031485 kg*m^2
% I2 = 0.031485 kg*m^2
% I1 = 0.005 kg*m^2

% mass
M = 3; %kg
mb = 0.018*L; % 0.018 kg/m*m
mm = 0.100; % kg
ms1 = M - mb - mm; % kg

lboom=L/2; %center of mass of the boom (m)



J(1,:)=(M/12)*(h^2 + d^2)+(mb/12)*lboom.^2+mm*L^2;
J(2,:)=(M/12)*(h^2 + w^2)+(mb/12)*lboom.^2+mm*L^2;
J(3,:)=(M/12)*(w^2 + d^2);

end

