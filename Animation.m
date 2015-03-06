figure    

vecN=[];
vecR=[];
vecS=[];

n=floor(length(q)/100);
j=0;
for i=1:n:length(q)
    j=j+1;
    
    x=q(i,10);
    y=q(i,11);
    z=q(i,12);
    w=q(i,13);
    
    Nq(i) = w^2 + x^2 + y^2 + z^2;

    if Nq(i) > 0.0
        s = 2/Nq(i);
    else
        s = 0;
    end

    X = x*s; Y = y*s; Z = z*s;
    wX = w*X; wY = w*Y; wZ = w*Z;
    xX = x*X; xY = x*Y; xZ = x*Z;
    yY = y*Y; yZ = y*Z; zZ = z*Z;
    
    BodytoOrbital=[ 1.0-(yY+zZ)  xY-wZ        xZ+wY;
                   xY+wZ        1.0-(xX+zZ)  yZ-wX;  
                   xZ-wY        yZ+wX        1.0-(xX+yY); ];

vecN=[vecN; -(BodytoOrbital*[1;0;0])'];
vecR=[vecR; (BodytoOrbital*[0;1;0])'];
vecS=[vecS; (BodytoOrbital*[0;0;1])'];

quiver3(0,0,0,vecN(j,1),vecN(j,2),vecN(j,3),'r');
hold on
quiver3(0,0,0,vecR(j,1),vecR(j,2),vecR(j,3),'g');
quiver3(0,0,0,vecS(j,1),vecS(j,2),vecS(j,3),'b');
axis([-1 1 -1 1 -1 1]);
hold off
M(j)=getframe;
end