function EclipsePlot(e,q,t)

Re=6378.137; %Earth equatorial radius in kilometers
Earth=imread('Earth.jpg');
Earth=imresize(Earth,0.2);

[imgInd,map] = rgb2ind(Earth,256);
[imgIndRows,imgIndCols] = size(imgInd);
[X,Y,Z] = sphere(imgIndRows,imgIndCols);
surface(X,Y,Z,flipud(imgInd),...
    'FaceColor','texturemap',...
    'EdgeColor','none',...
    'CDataMapping','direct')
colormap(map)

equnx=datenum('March 20 2015 22:45'); %time of the 2015 Spring Equinox
theta=2*pi/86400; %Earth rotates 2 pi radians every day
%rotate the coordinates (as the earth rotates)
for i=1:length(t)
    A=[cos(theta*(t(i)-equnx)) -sin(theta*(t(i)-equnx)) 0;
       sin(theta*(t(i)-equnx)) cos(theta*(t(i)-equnx))  0
       0                       0                        1]*[q(i,1); q(i,3); q(i,5)];

    x(i)=A(1)/Re;
    y(i)=A(2)/Re;
    z(i)=A(3)/Re;
end

hold on
Ec=e(1);
ex=x(1);
ey=y(1);
ez=z(1);

for i=2:length(x)
    if e(i)==Ec
        ex=[ex; x(i)];
        ey=[ey; y(i)];
        ez=[ez; z(i)];
    else
        ex=[ex; x(i)];
        ey=[ey; y(i)];
        ez=[ez; z(i)];
        if Ec==1;
            plot3(ex,ey,ez,'b')
        else
            plot3(ex,ey,ez,'r')
        end
        Ec=e(i);
        ex=x(i);
        ey=y(i);
        ez=z(i);
    end
end

if Ec==1;
    plot3(ex,ey,ez,'b')
else
    plot3(ex,ey,ez,'r')
end

axis equal
xlabel('X in Earth Radii')
ylabel('Y in Earth Radii')
zlabel('Z in Earth Radii')

end