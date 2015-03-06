
Re=6378.137; %Earth equatorial radius in kilometers
mu=398600.44189; %standard gravitational parameter of Earth

r=300;%orbital altitude (in kilometers)
w0=0:1E-2:3; %initial angular velocity
I=3.415*10^-2; %moment of inertia (roll/pitch)
mass=3;
l=2;

g=(mu/(((Re+r))^2))*1000;

theta0=asin((0.5*I*(w0.^2))/mass*g*l);

T=zeros(1,length(theta0));

for j=1:length(theta0)
for n=0:50
T(j)=T(j)+((factorial(2*n)/(((2^n)*factorial(n))^2))^2)*(sin(theta0(j)/2)^(2*n));
end
end

T=T*2*pi*sqrt(I/(mass*g*l))

plot(theta0*180/pi,T)
title('Pendulum Period with Respect to Initial Angle')
xlabel('Initial angle (Degrees)')
ylabel('Period (seconds)')