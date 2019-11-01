theta=1;
dt=0.001;
tf=500;
iter=(tf/dt)+1;

k=10;
state_eeta_eps1_eps2=zeros(3,iter);

state_eeta_eps1_eps2(:,1)=[0.1;1;1]; % initial values of eeta and eps

for index=1:(iter-1)
    eeta_pres=state_eeta_eps1_eps2(1,index);
    eps1_pres=state_eeta_eps1_eps2(2,index);
    eps2_pres=state_eeta_eps1_eps2(3,index);
    
    state_eeta_eps1_eps2(1,index+1)=eeta_pres+dt*(-0.5*(1+eps2_pres)*eeta_pres^3);
    state_eeta_eps1_eps2(2,index+1)=eps1_pres+dt*(eps2_pres);
    state_eeta_eps1_eps2(3,index+1)=eps2_pres+dt*(-k*k*eps1_pres-2*k*eps2_pres);
end

subplot(1,3,1)
plot(0:dt:tf,state_eeta_eps1_eps2(1,:),'LineWidth',2)
xlabel('Time')
ylabel('Eeta')
grid on

subplot(1,3,2)
plot(0:dt:tf,state_eeta_eps1_eps2(2,:),'LineWidth',2)
xlabel('Time')
ylabel('Eps1')
grid on

subplot(1,3,3)
plot(0:dt:tf,state_eeta_eps1_eps2(3,:),'LineWidth',2)
xlabel('Time')
ylabel('Eps2')
grid on