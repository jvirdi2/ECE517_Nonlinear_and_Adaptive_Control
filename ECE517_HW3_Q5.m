% ECE 517-Q5, part a
Am=(-1)*eye(2);
P=0.5*eye(2);

% Need to simulate given system to find X(t)

a11=-0.25;
a12=3;
a21=-5;
b1=1;
b2=2.2;
A=[a11 a12 ; a21 0];
B=[b1;b2];
tf=600;
dt=0.001;

x=zeros(2,tf/dt+1); % initial condition assumed as [0;0]
for index=1:(tf/dt)
    t=(index-1)*dt;
    u=10*sin(2*t)+7*cos(3.6*t); % Here specify the control input
    x(:,index+1)=x(:,index)+dt*(A*x(:,index)+B*u);
end

% Now assuming just x and u are give, we try to find 
% A and b using our estimator

Ahat=magic(2); % assumed initial values of A and B
Bhat=[1;2];
xhat_initial=[5;10]; % some random inital value of xhat
xhat=[xhat_initial,zeros(2,tf/dt)];

% Used in seeing how components of Ahat will change with time
a11hat=[Ahat(1,1),zeros(1,tf/dt)];
a12hat=[Ahat(1,2),zeros(1,tf/dt)];
a21hat=[Ahat(2,1),zeros(1,tf/dt)];
a22hat=[Ahat(2,2),zeros(1,tf/dt)];
b1hat=[Bhat(1),zeros(1,tf/dt)];
b2hat=[Bhat(2),zeros(1,tf/dt)];

for index=1:(tf/dt)
    t=(index-1)*dt;
    u=10*sin(2*t)+7*cos(3.6*t); % Here specify the control input
    e=xhat(:,index)-x(:,index);
    xhat(:,index+1)=xhat(:,index)+dt*(Am*(e)+Ahat*x(:,index)+Bhat*u);
    Ahat=Ahat+dt*(-P*e*x(:,index+1)');
    Bhat=Bhat+dt*(-P*e*u');
    
    a11hat(:,index+1)=Ahat(1,1);
    a12hat(:,index+1)=Ahat(1,2);
    a21hat(:,index+1)=Ahat(2,1);
    a22hat(:,index+1)=Ahat(2,2);
    b1hat(:,index+1)=Bhat(1);
    b2hat(:,index+1)=Bhat(2);
end
subplot(1,2,1)
plot(0:dt:tf,x(1,:),'k','LineWidth',2)
hold on 
grid on
plot(0:dt:tf,xhat(1,:),'r--','LineWidth',2)
xlabel('Time')
ylabel('X1')
legend('Actual state','Estimated state')

subplot(1,2,2)
plot(0:dt:tf,x(2,:),'k','LineWidth',2)
hold on 
grid on
plot(0:dt:tf,xhat(2,:),'r--','LineWidth',2)
xlabel('Time')
ylabel('X2')
legend('Actual state','Estimated state')

Ahat
Bhat

    