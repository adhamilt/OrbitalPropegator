function dr=fun(t,r)

RE=6371;
global boom;

M=3; %satellite Mass
m=398600.4418; %Standard Gravitational Parameter

F=SatelliteAeroDrag(r-RE,boom);

%dr=F*r/((-r*M*((m/r)^3/2)/(2*m))+(m/r));
dr=-2*sqrt(r)*F/(M*sqrt(m));

end