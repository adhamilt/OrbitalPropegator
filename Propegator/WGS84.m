function dq=WGS84(t,q)

ax=0;
ay=0;
az=0;
m=398600.44189; %standard gravitational parameter of Earth
J2=1082.63*10^(-6);
Re=6378.137;
rho=1;
mass=3;
Cd=2.2;
area=0.3^2;

Inertia=[3.1485 3.1485 0.5]*10^-2; %moment of inertia about the body X/Y/Z axis respectively
%Moment of inertia in kg*m^2

global MaxRho;
global Alt;

dq=zeros(6,1);
X=q(1);
Y=q(3);
Z=q(5);

%Orbital Radius
r=(q(1)^2)+(q(3)^2)+(q(5)^2);

%Quaternion derived Euler Rotation (132)
Roll=atan(2*(q(10)*q(13)-q(11)*q(12))/(1-2*(q(10)^2)-2*(q(12)^2)));%one
Pitch=atan(2*(q(11)*q(13)-q(10)*q(12))/(1-2*(q(11)^2)-2*(q(12)^2)));%two
Yaw=asin(2*(q(10)*q(11)+q(12)*q(13)));%three

%Body frame to Orbital Frame rotation Matrix: (132 rotation matrix)
BodyToOrbit=[ cos(Pitch)*cos(Yaw)                                    sin(Yaw)               -sin(Pitch)*cos(Yaw);
             -cos(Roll)*cos(Pitch)*sin(Yaw)+sin(Roll)*sin(Pitch)     cos(Roll)*cos(Yaw)     cos(Roll)*sin(Pitch)*sin(Yaw)+sin(Roll)*cos(Pitch);
             sin(Roll)*cos(Pitch)*sin(Yaw)+cos(Roll)*cos(Yaw)        -sin(Roll)*cos(Yaw)    -sin(Roll)*sin(Pitch)*sin(Yaw)+cos(Roll)*cos(Yaw)];
         
%Orbital frame to Body frame rotation matrix
OrbitToBody=BodyToOrbit'; %The inverse of a Rotation matrix is its transpose

Radius=OrbitToBody*[q(1);q(2);q(3)]; %Orbital Radius in Body centered Coordinates


%Calculate accelerations on the body (For the orbital frame)
%-------------------------------------------------------------------------------------------


%Calculate Acceleration Due to Drag
rho=spline(Alt,MaxRho,(r-Re)); %spline to find the density at the particular altitude

drag=0.5*Cd*rho*area*[q(2) q(4) q(6)]*[q(2); q(4); q(6)]/m;

dragDirection=-[q(2) q(4) q(6)]/((sqrt(q(2)^2)+(q(4)^2)+(q(6)^2))); %Drag unit vector

%project the drag onto the x/y/z unit vectors
dragx=drag*dragDirection(1);
dragy=drag*dragDirection(2);
dragz=drag*dragDirection(3);



%Calculate Acceleration due to the J2 Perturbations (Earth Oblateness)
J2x=-(3/2)*J2*(m/(r^2))*((Re/r)^2)*((1-5*(Z/r)^2)*(X/r));
J2y=-(3/2)*J2*(m/(r^2))*((Re/r)^2)*((1-5*(Z/r)^2)*(Y/r));
J2z=-(3/2)*J2*(m/(r^2))*((Re/r)^2)*((3-5*(Z/r)^2)*(Z/r));



%Calculate torques on the Body Centered Frame:
%-----------------------------------------------------------------------------

%Gravity Gradient Torques

Mg1=(3*mass/(r^5))*Radius(2)*Radius(3)*(Inertia(3)-Inertia(2)); %Torque about the body centered X axis
Mg2=(3*mass/(r^5))*Radius(1)*Radius(3)*(Inertia(1)-Inertia(3)); %Torque about the body centered Y axis
Mg3=(3*mass/(r^5))*Radius(1)*Radius(2)*(Inertia(2)-Inertia(1)); %Torque about the body centered Z axis



%Construction of the ODE to be solved:
%--------------------------------------------------------------------------------

%Earth Centered Orbit
dq(1)=q(2);%d2x/dt2
dq(3)=q(4);%d2y/dt2
dq(5)=q(6);%d2z/dt2
dq(2)=(-m*X*(r)^(-3/2))+J2x+dragx; %X Velocity
dq(4)=(-m*Y*(r)^(-3/2))+J2y+dragy; %Y Velocity
dq(6)=(-m*Z*(r)^(-3/2))+J2z+dragz; %Z Velocity


%Satellite motion within its own body centered frame
dq(7)=(1/Inertia(1))*((Inertia(2)-Inertia(3))*q(8)*q(9))+Mg1; %angular velocity about X
dq(8)=(1/Inertia(2))*((Inertia(3)-Inertia(1))*q(9)*q(7))+Mg2; %angular velocity about Y
dq(9)=(1/Inertia(3))*((Inertia(1)-Inertia(2))*q(7)*q(8))+Mg3; %angular velocity about Z


%Quaternion set Transforming the Satellite body centered axis into the
%Orbital centered Frame

dq(10)=0.5*(q(9)*q(11)-q(8)*q(12)+q(7)*q(13));
dq(11)=0.5*(q(7)*q(12)+q(8)*q(13)-q(9)*q(10));
dq(12)=0.5*(q(8)*q(13)-q(7)*q(11)+q(9)*q(11));
dq(13)=0.5*(-q(7)*q(10)-q(8)*q(12)-q(9)*q(12));


end