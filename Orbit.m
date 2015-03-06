function [t,q]=Orbit(dur,tol,Plot,param)

addpath('Propegator')
addpath('Tools')

Re=6378.137; %Earth equatorial radius in kilometers
m=398600.44189; %standard gravitational parameter of Earth

ImportAtm();

if nargin<=3
%Orbital Parameters:
%-------------------------------
Inclination=79; %inclination
Semimajor=300+Re; %semimajor axis
RAAN=0; %Right ascension of the acending node
ArgPer=0; %Argument of Perigee
TrueAnom=0; %True anomaly
eccentricity=0;%eccentricity
%-------------------------------
else
Inclination=param(1); %inclination
Semimajor=param(2); %semimajor axis
RAAN=param(3); %Right ascension of the acending node
ArgPer=param(4); %Argument of Perigee
TrueAnom=param(5); %True anomaly
eccentricity=param(6);%eccentricity
end

if nargin<=2
Plot=1;%make plots by default
end

if nargin<=1
    tol=1E-5; %default tolerance
end
options = odeset('RelTol', tol); %set the integrator tolerance

if nargin<=0
    dur=[0 2*93*60];
end


%convert to radians
Inclination=Inclination*pi/180;
RAAN=RAAN*pi/180;
ArgPer=ArgPer*pi/180;


p=Semimajor*(1-eccentricity)^2;%semilatus rectum
r=p/(1+eccentricity*(cos(TrueAnom)));

%Rotation matrices for initial conditions:
%--------------------------------------------------
R1=[cos(RAAN)    sin(RAAN)   0;
   -sin(RAAN)    cos(RAAN)   0;
   0             0           1];

R2=[1   0       0;
    0   cos(Inclination)  sin(Inclination);
    0   -sin(Inclination) cos(Inclination)];

R3=[cos(ArgPer)     sin(ArgPer)     0;
    -sin(ArgPer)    cos(ArgPer)     0;
    0               0               1];

%define Rotation matrix from Perifocal to Earth Centered Coordinates
PerifocalToECI=R1'*R2'*R3';


%Define Initial Conditions
%--------------------------------------------------------------------------------
radius=PerifocalToECI*[r*cos(TrueAnom); r*sin(TrueAnom); 0];
velocity=PerifocalToECI*[-sqrt(m/p)*sin(TrueAnom); sqrt(m/p)*(eccentricity+cos(TrueAnom)); 0];

%initial rotation conditions

%define an initial basis for the Orbital frame
rhat=-radius./norm(radius);
vhat=velocity./norm(velocity);
starhat=sqrt([1; 1; 1;]-(rhat.^2)-(vhat.^2));

%Initial Rotation Matrix from ECI to Orbital frame
ECIToOrbital=[rhat vhat starhat];

%quaternion initial conditions:
q4=0.5*sqrt(1+ECIToOrbital(1,1)+ECIToOrbital(2,2)+ECIToOrbital(3,3));
q1=(1/(4*q4))*(ECIToOrbital(2,3)-ECIToOrbital(3,2));
q2=(1/(4*q4))*(ECIToOrbital(3,1)-ECIToOrbital(1,3));
q3=(1/(4*q4))*(ECIToOrbital(1,2)-ECIToOrbital(2,1));


initYaw=0.0;
initPit=0.001;
initRoll=0;


[t,q] = ode23tb(@WGS84,dur,[radius(1) velocity(1) radius(2) velocity(2) radius(3) velocity(3) initYaw initPit initRoll q1 q2 q3 q4],options);


if Plot==1
    OrbitalPlot(q(:,1)/Re,q(:,3)/Re,q(:,5)/Re,t);

    figure;
    deltar=sqrt((q(:,1).^2)+(q(:,3).^2)+(q(:,5).^2));
    plot(t,deltar-Re);
    title('Orbital Altitude')
end
end

