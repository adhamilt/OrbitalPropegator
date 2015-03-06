
n=5;

month=2.62974E6;
RE=6371;

global boom;

booms=[0 1 2 3 4 6];

t=linspace(0,n*month);

for i=1:6

boom=booms(i);

[T,R]=ode15s(@fun,[0 n*month],350+RE);

r(i,:)=spline(T,R,t);
end

t=t/month;
r=r-RE;

plot(t,r(1,:),t,r(2,:),t,r(3,:),t,r(4,:),t,r(5,:),t,r(6,:))
xlabel('Months of Lifetime')
ylabel('Orbital Altitiude')
legend('0 m','0.1 m','0.2 m','0.3 m', '0.4 m', '0.5 m')
axis([0 n 0 400])