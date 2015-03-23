function [X Y Z]=csvSunVectors(date,dur,param)

    

if nargin<=1
    dur=[0 3*90*60];
end

if nargin<=0
    date='April 1 2016';
end


if nargin<=2
    [sun d q]=sunvectors(date,dur);
else
    [sun d q]=sunvectors(date,dur,1E-5,0,param);
end



X{1,1}='Date';
X{1,2}='Angle (deg)';

Y{1,1}='Date';
Y{1,2}='Angle (deg)';

Z{1,1}='Date';
Z{1,2}='Angle (deg)';

for i=2:length(d)+1
    
    X{i,1}=datestr(d(i-1),'YYYY-mm-dd HH:MM:SS');
    Y{i,1}=datestr(d(i-1),'YYYY-mm-dd HH:MM:SS');
    Z{i,1}=datestr(d(i-1),'YYYY-mm-dd HH:MM:SS');
    
    Z{i,2}=acos(sun(i-1,3)')*180/pi;
    Y{i,2}=acos(sun(i-1,2)')*180/pi;
    X{i,2}=acos(sun(i-1,1))*180/pi;
end


%cell2csv('Xangles.csv',X);
%cell2csv('Yangles.csv',Y);
%cell2csv('Zangles.csv',Z);
end