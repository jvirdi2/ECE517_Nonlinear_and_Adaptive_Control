theta=1;
dt=0.0001;
tf=10;
iter=(tf/dt)+1;

k=10;
state_eeta_eps=zeros(2,iter);

state_eeta_eps(:,1)=[-23;-0.5]; % initial values of eeta and eps
for index=1:(iter-1)
    eeta_pres=state_eeta_eps(1,index);
    eps_pres=state_eeta_eps(2,index);
    
    state_eeta_eps(1,index+1)=eeta_pres+dt*(-eeta_pres+(eeta_pres*eeta_pres)*eps_pres);
    state_eeta_eps(2,index+1)=eps_pres+dt*(-k*eps_pres);
end
subplot(1,2,1)
plot(0:dt:tf,state_eeta_eps(1,:),'LineWidth',2)
xlabel('Time')
ylabel('Eeta')
grid on

subplot(1,2,2)
plot(0:dt:tf,state_eeta_eps(2,:),'LineWidth',2)
xlabel('Time')
ylabel('Epsilon')
grid on