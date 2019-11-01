% adaptive controls ECE517
% HW1 Q4 a
theta=1000;
dt=0.0001;
tf=1;
iter=(tf/dt)+1;
d=0;

state=zeros(1,iter);
theta_hat=zeros(1,iter);

state(1)=5;
u_val=zeros(1,iter);


for index=1:(iter-1)

    theta_hat(index+1)=theta_hat(index)+dt*state(index)*state(index);
    u=-(theta_hat(index)+1)*state(index);
    state(index+1)=state(index)+dt*(theta*state(index)+u+d);
    u_val(index)=u;
end
state(end)
subplot(1,2,1)
plot((1:iter)*dt,state)
xlabel('Time')
ylabel('X')
grid on
title('Q4(a)')

subplot(1,2,2)
plot((1:iter)*dt,theta_hat)
xlabel('Time')
ylabel('Theta Hat')
grid on
title('Q4(a)')
%plot((1:iter)*dt,theta_hat)
%plot((1:iter)*dt,u_val)