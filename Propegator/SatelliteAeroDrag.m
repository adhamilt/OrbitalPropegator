function [ SatAeroDrag ] = SatelliteAeroDrag( Alt1, BoomLength)
%This function "BoomAeroT" calculates the aerodynamic torque the boom
%exerts on the satellite as a function of Altitude and Boom Length.

%Assumptions: 
%1. The boom is always pointing towards earth center and the
%flange sections are parallel to the flow direction. 

%2. The atmosphere does not move relative to the satellite.

%3. The satellite and the boom are rigid bodies. 

%4. The flow velocity is equal to the spacecraft velocity and
%is in the direction opposite of the spacecrafts velocity vector. 

%5.Density is the same at all inclinations and at all times of the day. 
%6. Atmosphere is non-continuum


%  The atmopsheric model used was MSIS-90 using the date of January 15,
%  2014, a 0 degree inclination at midday.

Alt=[90:1:350]; %Altitude vector in km with 1 km increments

%Density of the atmosphere using the MSIS-90 model, the length of this
%vector and the altitude vector are the same as the values coincide

Dens=[3.86300000000000e-09;3.32500000000000e-09;2.85500000000000e-09;2.44200000000000e-09;2.07800000000000e-09;1.75700000000000e-09;1.47500000000000e-09;1.22900000000000e-09;1.01700000000000e-09;8.34600000000000e-10;6.80200000000000e-10;5.50800000000000e-10;4.44000000000000e-10;3.57000000000000e-10;2.86800000000000e-10;2.30600000000000e-10;1.85800000000000e-10;1.50200000000000e-10;1.21900000000000e-10;9.95300000000000e-11;8.17600000000000e-11;6.76500000000000e-11;5.63900000000000e-11;4.73300000000000e-11;4.00000000000000e-11;3.40300000000000e-11;2.91500000000000e-11;2.51300000000000e-11;2.18100000000000e-11;1.90400000000000e-11;1.67400000000000e-11;1.48200000000000e-11;1.32000000000000e-11;1.18400000000000e-11;1.06800000000000e-11;9.67600000000000e-12;8.80200000000000e-12;8.03800000000000e-12;7.36600000000000e-12;6.77100000000000e-12;6.24300000000000e-12;5.77200000000000e-12;5.35000000000000e-12;4.97100000000000e-12;4.62900000000000e-12;4.32000000000000e-12;4.03800000000000e-12;3.78300000000000e-12;3.54900000000000e-12;3.33500000000000e-12;3.13900000000000e-12;2.95900000000000e-12;2.79300000000000e-12;2.63900000000000e-12;2.49700000000000e-12;2.36600000000000e-12;2.24400000000000e-12;2.13000000000000e-12;2.02500000000000e-12;1.92600000000000e-12;1.83400000000000e-12;1.74700000000000e-12;1.66700000000000e-12;1.59100000000000e-12;1.52000000000000e-12;1.45300000000000e-12;1.39000000000000e-12;1.33100000000000e-12;1.27500000000000e-12;1.22200000000000e-12;1.17200000000000e-12;1.12400000000000e-12;1.08000000000000e-12;1.03700000000000e-12;9.97100000000000e-13;9.59000000000000e-13;9.22800000000000e-13;8.88400000000000e-13;8.55600000000000e-13;8.24400000000000e-13;7.94700000000000e-13;7.66400000000000e-13;7.39400000000000e-13;7.13600000000000e-13;6.89000000000000e-13;6.65500000000000e-13;6.43000000000000e-13;6.21500000000000e-13;6.00900000000000e-13;5.81200000000000e-13;5.62300000000000e-13;5.44100000000000e-13;5.26800000000000e-13;5.10100000000000e-13;4.94100000000000e-13;4.78700000000000e-13;4.63900000000000e-13;4.49700000000000e-13;4.36100000000000e-13;4.23000000000000e-13;4.10300000000000e-13;3.98200000000000e-13;3.86500000000000e-13;3.75200000000000e-13;3.64300000000000e-13;3.53800000000000e-13;3.43700000000000e-13;3.33900000000000e-13;3.24500000000000e-13;3.15400000000000e-13;3.06700000000000e-13;2.98200000000000e-13;2.90000000000000e-13;2.82100000000000e-13;2.74400000000000e-13;2.67000000000000e-13;2.59900000000000e-13;2.53000000000000e-13;2.46300000000000e-13;2.39800000000000e-13;2.33500000000000e-13;2.27400000000000e-13;2.21500000000000e-13;2.15800000000000e-13;2.10300000000000e-13;2.04900000000000e-13;1.99700000000000e-13;1.94700000000000e-13;1.89800000000000e-13;1.85100000000000e-13;1.80500000000000e-13;1.76000000000000e-13;1.71700000000000e-13;1.67500000000000e-13;1.63400000000000e-13;1.59400000000000e-13;1.55600000000000e-13;1.51800000000000e-13;1.48200000000000e-13;1.44700000000000e-13;1.41200000000000e-13;1.37900000000000e-13;1.34700000000000e-13;1.31500000000000e-13;1.28400000000000e-13;1.25500000000000e-13;1.22500000000000e-13;1.19700000000000e-13;1.17000000000000e-13;1.14300000000000e-13;1.11700000000000e-13;1.09200000000000e-13;1.06700000000000e-13;1.04300000000000e-13;1.02000000000000e-13;9.96700000000000e-14;9.74500000000000e-14;9.52900000000000e-14;9.31800000000000e-14;9.11300000000000e-14;8.91300000000000e-14;8.71800000000000e-14;8.52800000000000e-14;8.34200000000000e-14;8.16200000000000e-14;7.98600000000000e-14;7.81400000000000e-14;7.64600000000000e-14;7.48300000000000e-14;7.32300000000000e-14;7.16800000000000e-14;7.01600000000000e-14;6.86800000000000e-14;6.72400000000000e-14;6.58300000000000e-14;6.44500000000000e-14;6.31100000000000e-14;6.18000000000000e-14;6.05200000000000e-14;5.92700000000000e-14;5.80500000000000e-14;5.68600000000000e-14;5.56900000000000e-14;5.45600000000000e-14;5.34500000000000e-14;5.23600000000000e-14;5.13000000000000e-14;5.02700000000000e-14;4.92600000000000e-14;4.82700000000000e-14;4.73000000000000e-14;4.63600000000000e-14;4.54300000000000e-14;4.45300000000000e-14;4.36500000000000e-14;4.27900000000000e-14;4.19500000000000e-14;4.11200000000000e-14;4.03200000000000e-14;3.95300000000000e-14;3.87600000000000e-14;3.80100000000000e-14;3.72700000000000e-14;3.65500000000000e-14;3.58400000000000e-14;3.51600000000000e-14;3.44800000000000e-14;3.38200000000000e-14;3.31700000000000e-14;3.25400000000000e-14;3.19000000000000e-14;3.13000000000000e-14;3.07100000000000e-14;3.01300000000000e-14;2.95600000000000e-14;2.90100000000000e-14;2.84600000000000e-14;2.79300000000000e-14;2.74100000000000e-14;2.69000000000000e-14;2.64000000000000e-14;2.59100000000000e-14;2.54300000000000e-14;2.49700000000000e-14;2.45100000000000e-14;2.40600000000000e-14;2.36200000000000e-14;2.31900000000000e-14;2.27600000000000e-14;2.23500000000000e-14;2.19400000000000e-14;2.15500000000000e-14;2.11600000000000e-14;2.07700000000000e-14;2.04000000000000e-14;2.00300000000000e-14;1.96800000000000e-14;1.93200000000000e-14;1.89800000000000e-14;1.86400000000000e-14;1.83100000000000e-14;1.79800000000000e-14;1.76700000000000e-14;1.73500000000000e-14;1.70500000000000e-14;1.67500000000000e-14;1.64500000000000e-14;1.61600000000000e-14;1.58800000000000e-14;1.56000000000000e-14;1.53300000000000e-14;1.50700000000000e-14;1.48000000000000e-14;1.45500000000000e-14;1.43000000000000e-14;1.40500000000000e-14;1.38100000000000e-14;1.35700000000000e-14;1.33400000000000e-14;1.31100000000000e-14;1.28800000000000e-14];

Dens1=interp1(Alt,Dens,Alt1,'Spline')*1000; %Spline estimation of the density given an altitude. (kg/m^3)

GravPar=3.986E5; %% Gravitational parameter, units are in km^3/s^2

Rad_Earth= 6378; % Earths radius in km

Velocity=sqrt(GravPar/(Rad_Earth+Alt1))*1000; %Velocity in m/s 

Cd_tube=1.2; %aerodynamic drag coefficient of the tube section

Cd_sat=2.2; %aerodynamic drag coefficient of the spacecraft

Area_sat=0.01; %m^2, area of the satellite normal to the flow direction

Width_tube=0.042;%in m, width of the tube section of the boom, assuming it has a circular cross section

dragpar=(Cd_tube*Width_tube*BoomLength+Area_sat*Cd_sat); %drag parameter of the tube & flange put together, units are in meters squared (m^2)

SatAeroDrag= (1/2)*Velocity^2*Dens1*dragpar; %Aerodynamic drag in N

end