function Ecl=iseclipse(dat,q)

sec=86400; %seconds in a day
apsis=datenum('January 4 2015 06:36'); % time of the 2015 Perihelion
a=149.60E6;
ecc=0.01671123;
P=365.256363004*sec; %period of the Earth in days (one sideral year)
Re=6378.137; %Earth equatorial radius in kilometers

e=[1 0 0; 0 1 0; 0 0 1];
Ecl=zeros(length(dat),1);



for i=1:length(dat)
    [sx sy sz]=ECIsun(dat(i));
    s=[sx sy sz];
    
    for j=1:3
        for k=1:3
            R(j,k)=dot(e(:,j),s(:,k));
        end
    end
    
    qq=[q(i,1) q(i,3) q(i,5)];    
    qs=R*qq';
    
    t=(dat(i)-apsis)*sec; %number of seconds since the last apsis
    T=P/(2*pi); %Earth's Orbital Period
    
    D=a*(1-ecc^2)/(1+ecc*cos(t/T));
    z=Re*(D+qs(1))/D;
    
    if(sqrt(qs(1)^2+qs(3)^2)<z && qs(2)<0)
        Ecl(i)=1;
    end
    
end


%EclipsePlot(Ecl,q(:,1)/Re,q(:,3)/Re,q(:,5)/Re,dat*sec);
end
