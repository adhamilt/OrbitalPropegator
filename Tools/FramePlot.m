rhat=-[q(:,1)./sqrt(((q(:,1).^2)+(q(:,3).^2)+(q(:,5).^2))) q(:,3)./sqrt(((q(:,1).^2)+(q(:,3).^2)+(q(:,5).^2))) q(:,5)./sqrt(((q(:,1).^2)+(q(:,3).^2)+(q(:,5).^2)))];
vhat=[q(:,2)./sqrt(((q(:,2).^2)+(q(:,4).^2)+(q(:,6).^2))) q(:,4)./sqrt(((q(:,2).^2)+(q(:,3).^2)+(q(:,6).^2))) q(:,6)./sqrt(((q(:,2).^2)+(q(:,4).^2)+(q(:,6).^2)))];
starhat=sqrt(ones(size(rhat))-(rhat.^2)-(vhat.^2));

figure;

n=floor(length(q)/100);

quiver3(q(1:n:end,1),q(1:n:end,3),q(1:n:end,5),rhat(1:n:end,1),rhat(1:n:end,2),rhat(1:n:end,3),'r');
hold on
quiver3(q(1:n:end,1),q(1:n:end,3),q(1:n:end,5),vhat(1:n:end,1),vhat(1:n:end,2),vhat(1:n:end,3),'g');
quiver3(q(1:n:end,1),q(1:n:end,3),q(1:n:end,5),starhat(1:n:end,1),starhat(1:n:end,2),starhat(1:n:end,3),'b');
axis square;
title('Orbital Frame')


bodyNadir=[];
bodyRam=[];
bodyStar=[];

for i=1:length(q)
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

bodyNadir=[bodyNadir; (BodytoOrbital*[rhat(i,1);rhat(i,2);rhat(i,3)])'];
bodyRam=[bodyRam; (BodytoOrbital*[vhat(i,1);vhat(i,2);vhat(i,3)])'];
bodyStar=[bodyStar; (BodytoOrbital*[starhat(i,1);starhat(i,2);starhat(i,3)])'];
end

figure

quiver3(q(1:n:end,1),q(1:n:end,3),q(1:n:end,5),bodyNadir(1:n:end,1),bodyNadir(1:n:end,2),bodyNadir(1:n:end,3),'r');
hold on
quiver3(q(1:n:end,1),q(1:n:end,3),q(1:n:end,5),bodyRam(1:n:end,1),bodyRam(1:n:end,2),bodyRam(1:n:end,3),'g');
quiver3(q(1:n:end,1),q(1:n:end,3),q(1:n:end,5),bodyStar(1:n:end,1),bodyStar(1:n:end,2),bodyStar(1:n:end,3),'b');
axis square;
title('Body Frame')
