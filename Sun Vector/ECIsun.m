function [sx sy sz]=ECIsun(d)

%produces the sun vector in the earth centered coordinates. (This will be the vector as seen from the center of the Earth)

%s - the sun vector as [x y z] in ECI (unit vector)
%d - the date. This can be inputed as a string or as a matlab date number.
%       note the time MUST be in UTC

%EXAMPLE:
%
% s=ECIsun('April 1 2015 10:30')

    if nargin==0
        d=date;
    end
    
    if ischar(d)
        d=datenum(d);
    end
    
    apsis=datenum('January 4 2015 06:36'); % time of the 2015 Perihelion
    solst=datenum('December 22 2015 04:48'); %time of the 2015 winter solstice
    
    sec=86400; %seconds in a day
    
    
    sx=[1; 0; 0]; %sun basis x vector in the SCI. (points to the sun)
    sy=[0; -1; 0]; 
    sz=[0; 0; 1];
    
    tilt=-23.4*pi/180; %the tilt of the earth from the ecliptic
    
    t=(d-solst)*sec; %number of seconds since the last apsis
    T=365.25636*sec/(2*pi); %Earth's Orbital Period
    
    
    sz=[1 0 0; 0 cos(tilt) sin(tilt); 0 -sin(tilt) cos(tilt)]*[cos(t/T) -sin(t/T) 0; sin(t/T) cos(t/T) 0; 0 0 1]*sz;
    sx=[1 0 0; 0 cos(tilt) sin(tilt); 0 -sin(tilt) cos(tilt)]*[cos(t/T) -sin(t/T) 0; sin(t/T) cos(t/T) 0; 0 0 1]*sy;
    sy=[1 0 0; 0 cos(tilt) sin(tilt); 0 -sin(tilt) cos(tilt)]*[cos(t/T) -sin(t/T) 0; sin(t/T) cos(t/T) 0; 0 0 1]*sx;

end



