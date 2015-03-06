function dq=WGS84(t,q)

%TODO Make these Global:
m=398600.44189; %standard gravitational parameter of Earth
J2c=1082.63*10^(-6);
Re=6378.137;
rho=1;
area=0.3^2;
mass=3;


boom=0; %boom length in m
Inertia=Momentsofinertia(boom); %moment of inertia about the body X/Y/Z axis respectively
%Moment of inertia in kg*m^2


dq=zeros(13,1);
X=q(1);
Y=q(3);
Z=q(5);



%Orbital Radius
r=sqrt((q(1)^2)+(q(3)^2)+(q(5)^2));


%define quaternions
Q1=q(10);
Q2=q(11);
Q3=q(12);
Q4=q(13);


%Body frame to Orbital Frame rotation Matrix: (quaternion Rotation Matix)
BodyToOrbit=[ 1-2*((Q2^2)+(Q3^2))     2*(Q1*Q2+Q3*Q4)        2*(Q1*Q3-Q2*Q4)     ;
              2*(Q2*Q1-Q3*Q4)         1-2*((Q1^2)+(Q3^2))    2*(Q2*Q3+Q1*Q4)     ;
              2*(Q3*Q1+Q2*Q4)         2*(Q3*Q2-Q1*Q4)        1-2*((Q1^2)+(Q2^2)) ]';
         
%Orbital frame to Body frame rotation matrix
OrbitToBody=BodyToOrbit'; %The inverse of a Rotation matrix is its transpose
Radius=[X; Y; Z]; %Orbital Radius in ECI
velocity=[q(2); q(4); q(6)];



%define an initial basis for the Orbital frame
rhat=-Radius./norm(Radius);
starhat=cross(velocity,Radius)./norm(cross(velocity,Radius));
vhat=cross(starhat,rhat);

%Initial Rotation Matrix from ECI to Orbital frame
OrbitalToECI=[vhat starhat rhat];
ECIToOrbital=OrbitalToECI';




%Calculate accelerations on the body (For the orbital frame)
%-------------------------------------------------------------------------------------------


velMeters=norm(velocity)*1000; %velocity of the satellite in meters per second
drag=OrbitalToECI*[-SatelliteAeroDrag(r-Re,boom,velMeters); 0; 0]/(mass*1000); %Satellite drag
%drag=[0; 0; 0];

%Calculate Acceleration due to the J2 Perturbations (Earth Oblateness)
J2(1)=-(3/2)*J2c*(m/(r^2))*((Re/r)^2)*((1-5*(Z/r)^2)*(X/r));
J2(2)=-(3/2)*J2c*(m/(r^2))*((Re/r)^2)*((1-5*(Z/r)^2)*(Y/r));
J2(3)=-(3/2)*J2c*(m/(r^2))*((Re/r)^2)*((3-5*(Z/r)^2)*(Z/r));
%J2=[0 0 0];




%Calculate torques on the Body Centered Frame:
%-----------------------------------------------------------------------------

Rad=OrbitToBody*Radius;

%Gravity Gradient Torques
Mg(1)=(3*mass/(r^5))*Rad(2)*Rad(3)*(Inertia(3)-Inertia(2)); %Torque about the body centered X axis
Mg(2)=(3*mass/(r^5))*Rad(1)*Rad(3)*(Inertia(1)-Inertia(3)); %Torque about the body centered Y axis
Mg(3)=(3*mass/(r^5))*Rad(1)*Rad(2)*(Inertia(2)-Inertia(1)); %Torque about the body centered Z axis
%Mg=[0 0 0];



%Aerodynamic Torque
%Pitch=(atan(2*(q(11).*q(13)-q(10).*q(12))./(1-2*(q(11).^2)-2*(q(12).^2))));%pitch in radians
%Ma=[0; BoomAeroTorque(r-Re,boom,velMeters,Pitch); 0]; %Aerodynamic torque in the body reference frame
%Ma=OrbitToBody*Ma;
Ma=[0; 0; 0];




%Construction of the ODE to be solved:
%--------------------------------------------------------------------------------

%Earth Centered Orbit
dq(1)=q(2);%d2x/dt2
dq(3)=q(4);%d2y/dt2
dq(5)=q(6);%d2z/dt2
dq(2)=(-m*X*(r)^(-3))+J2(1)+drag(1); %X Velocity
dq(4)=(-m*Y*(r)^(-3))+J2(2)+drag(2); %Y Velocity
dq(6)=(-m*Z*(r)^(-3))+J2(3)+drag(3); %Z Velocity


%Satellite motion within its own body centered frame
dq(7)=(1/Inertia(1))*((Inertia(2)-Inertia(3))*q(8)*q(9)+Mg(1)+Ma(1)); %angular velocity about X (Roll)
dq(8)=(1/Inertia(2))*((Inertia(3)-Inertia(1))*q(9)*q(7)+Mg(2)+Ma(2)); %angular velocity about Y (Pitch)
dq(9)=(1/Inertia(3))*((Inertia(1)-Inertia(2))*q(7)*q(8)+Mg(3)+Ma(3)); %angular velocity about Z (Yaw)


%Quaternion set Transforming the Satellite body centered axis into the
%Orbital centered Frame
dq(10)=0.5*(q(9)*q(11)-q(8)*q(12)+q(7)*q(13));
dq(11)=0.5*(q(7)*q(12)+q(8)*q(13)-q(9)*q(10));
dq(12)=0.5*(q(8)*q(13)-q(7)*q(11)+q(9)*q(11));
dq(13)=0.5*(-q(7)*q(10)-q(8)*q(12)-q(9)*q(12));


end