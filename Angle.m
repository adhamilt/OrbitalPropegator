Yaw=abs(atan(2*(q(:,10).*q(:,13)-q(:,11).*q(:,12))./(1-2*(q(:,10).^2)-2*(q(:,12).^2))));%one
Pitch=abs(atan(2*(q(:,11).*q(:,13)-q(:,10).*q(:,12))./(1-2*(q(:,11).^2)-2*(q(:,12).^2))));%two
Roll=abs(asin(2*(q(:,10).*q(:,11)+q(:,12).*q(:,13))));%three


Roll=180*Roll/pi;
Pitch=180*Pitch/pi;
Yaw=180*Yaw/pi;


subplot(3,1,1)
plot(t,Roll)
title('Roll')
subplot(3,1,2)
plot(t,Pitch)
title('Pitch')
subplot(3,1,3)
plot(t,Yaw)
title('Yaw')