function [sun dat]=sunvectors(date,dur,tol,Plot,param)

    sec=86400; %seconds in a day
    
    addpath('Sun Vector')

    Re=6378.137; %Earth equatorial radius in kilometers
    m=398600.44189; %standard gravitational parameter of Earth

    
    if nargin<=4
        %Orbital Parameters:
        %-------------------------------
        param(1)=79; %inclination
        param(2)=300+Re; %semimajor axis
        param(3)=0; %Right ascension of the acending node
        param(4)=0; %Argument of Perigee
        param(5)=0; %True anomaly
        param(6)=0;%eccentricity
        %-------------------------------
    end

    if nargin<=3
    Plot=0;%do not make plots by default
    end

    if nargin<=2
        tol=1E-5; %default tolerance
    end

    if nargin<=1
        dur=[0 2*93*60];
    end

    if nargin<=0
        date='April-1-2016';
    end


    if strncmp(class(date),'char',4)
        date=datenum(date);
    end
    
    
    [t,q]=Orbit(dur,tol,Plot,param);
    
    dat=(t/sec)+date;
    sun=[];
    
    
    for i=1:length(dat)
        s=ECIsun(dat(i));
        
        Q=q(i,10:13);

        radius=[q(i,1) q(i,3) q(i,5)]';
        velocity=[q(i,2) q(i,4) q(i,6)]';
        
        %define an initial basis for the Orbital frame
        rhat=-radius./norm(radius);
        starhat=cross(velocity,radius)./norm(cross(velocity,radius));
        vhat=cross(starhat,rhat);
        
        %Initial Rotation Matrix from ECI to Orbital frame
        OrbitalToECI=[rhat vhat starhat];
        ECIToOrbital=OrbitalToECI';

        
        BodyToOrbital=[1-2*((Q(2)^2)+(Q(3)^2)) 2*(Q(1)*Q(2)+Q(3)*Q(4)) 2*(Q(1)*Q(3)-Q(2)*Q(4)); 
                       2*(Q(1)*Q(2)-Q(3)*Q(4)) 1-2*((Q(1)^2)+(Q(3)^2)) 2*(Q(2)*Q(3)+Q(1)*Q(4));
                       2*(Q(1)*Q(3)+Q(2)*Q(4)) 2*(Q(2)*Q(3)-Q(1)*Q(4)) 1-2*((Q(1)^2)+(Q(2)^2))];
      
        
        OrbitalToBody=BodyToOrbital';
        
        
        sun=[sun; (OrbitalToBody*ECIToOrbital*s)'];
    end
    
    
    
    
end