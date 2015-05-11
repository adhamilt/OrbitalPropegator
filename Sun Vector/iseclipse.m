function Ecl=iseclipse2(dat,q)

sec=86400; %seconds in a day
apsis=datenum('January 4 2015 06:36'); % time of the 2015 Perihelion
a=149597871; %astronomical unit in km
ecc=0.01671123;
P=365.256363004*sec; %period of the Earth in days (one sideral year)
Re=6378.137; %Earth equatorial radius in kilometers


Ecl=zeros(length(dat),1);

for i=1:length(dat)
   S=ECIsun(dat(i))';
   Q=[q(i,1) q(i,3) q(i,5)];
   C=(dot(Q,S)/(norm(S)^2));
   A=Q-C*S;
   
    t=(dat(i)-apsis)*sec; %number of seconds since the last apsis
    T=P/(2*pi); %Earth's Orbital Period
    
    D=a*(1-ecc^2)/(1+ecc*cos(t/T));
    z=Re*(D+C)/D;
    
    
    
    if norm(A)<z && C>0
        Ecl(i)=1;
    end
end

EclipsePlot(Ecl,q,dat*sec);

end