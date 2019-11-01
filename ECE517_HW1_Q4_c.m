% adaptive controls ECE517
% HW1 Q4 c
theta=1;
dt=0.001;
tf=5000;
iter=(tf/dt)+1;
d=300;

state=zeros(1,iter);
theta_hat=zeros(1,iter);

state(1)=1;
u_val=zeros(1,iter);

eps=0.3;

for index=1:(iter-1)
    if abs(state(index))>eps
        theta_hat(index+1)=theta_hat(index)+dt*state(index)*state(index);
    else
        theta_hat(index+1)=theta_hat(index);
    end

    u=-(theta_hat(index)+1)*state(index);
    state(index+1)=state(index)+dt*(theta*state(index)+u+d);
    u_val(index)=u;
end
state(end)
subplot(1,2,1)
plot((1:iter)*dt,state,'LineWidth',2)
xlabel('Time')
ylabel('X')
grid on
title('Q4(c)-Eps=0.3')

subplot(1,2,2)
plot((1:iter)*dt,theta_hat,'LineWidth',2)
xlabel('Time')
ylabel('Theta Hat')
grid on
title('Q4(c)-Eps=0.3')
%plot((1:iter)*dt,theta_hat)
%plot((1:iter)*dt,u_val)al)