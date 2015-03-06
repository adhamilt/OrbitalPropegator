function s=ECIsun(d)

    if nargin==0
        d=date;
    end
    
    if ischar(d)
        d=datenum(d);
    end
    
    apsis=datenum('January 4 2015 06:36'); % time of the 2015 Perihelion
    solst=datenum('December 22 2015 04:48'); %time of the 2015 winter solstice
    
    sec=86400; %seconds in a day
    
    
    s=[1; 0; 0]; %sun basis vector in the SCI.
    tilt=23.4*pi/180; %the tilt of the earth from the ecliptic
    
    t=(d-solst)*sec; %number of seconds since the last apsis
    T=365.25636*sec/(2*pi); %Earth's Orbital Period
    
    
    s=[cos(tilt) 0 sin(tilt); 0 1 0; -sin(tilt) 0 cos(tilt)]*[cos(t/T) -sin(t/T) 0; sin(t/T) cos(t/T) 0; 0 0 1]*s;


end



