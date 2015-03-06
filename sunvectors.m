function [sun]=sunvectors(date,dur,tol,Plot,param)

    seconds=86400; %seconds in a day



    if nargin<=4
        %Orbital Parameters:
        %-------------------------------
        Inclination=79; %inclination
        Semimajor=300+Re; %semimajor axis
        RAAN=0; %Right ascension of the acending node
        ArgPer=0; %Argument of Perigee
        TrueAnom=0; %True anomaly
        eccentricity=0;%eccentricity
        %-------------------------------
    else
        Inclination=param(1); %inclination
        Semimajor=param(2); %semimajor axis
        RAAN=param(3); %Right ascension of the acending node
        ArgPer=param(4); %Argument of Perigee
        TrueAnom=param(5); %True anomaly
        eccentricity=param(6);%eccentricity
    end

    if nargin<=3
    Plot=1;%make plots by default
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

end