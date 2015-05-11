function s=ECIsun(d)

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
    solst=datenum('December 22 2015 04:48'); %time of the 2015 Winter Solstice
    equnx=datenum('March 20 2015 22:45'); %time of the 2015 Spring Equinox
    
    sec=86400; %seconds in a day
    
    
    sx=[-1; 0; 0]; %sun basis x vector in the SCI. (points to the sun)
    
    tilt=-23.4*pi/180; %the tilt of the earth from the ecliptic
    
    t=(d-equnx)*sec; %number of seconds since the last equinox
    T=365.25636*sec/(2*pi); %Earth's Orbital Period
    o=t/T;
    
    s=[1 0 0; 0 cos(tilt) -sin(tilt); 0 sin(tilt) cos(tilt)]*[cos(o) -sin(o) 0; sin(o) cos(o) 0; 0 0 1]*sx;
    
    
end



