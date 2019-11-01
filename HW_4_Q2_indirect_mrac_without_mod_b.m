% Q2-without modification-part b

a=5; 
% tf=200 dt=0.00001
% Case 1 where b is slightly small and plant stable without input
% unstable for a=-5 b=2 am=1 and bm=3 gamma=1 bhat(0)=-1

% Case 2 where b is slightly small and plant unstable without input
% unstable for a=5 b=2 am=1 and bm=3 gamma=1 bhat(0)=-1


% Case 3 where b is big (away from 0) and plant stable without input
% unstable for a=-5 b=20 am=1 and bm=3 gamma=1 bhat(0)=-1

% Case 4 where b is big (away from 0) and plant unstable without input
% unstable for a=5 b=20 am=1 and bm=3 gamma=1 bhat(0)=-1


b=20; % for part a, b is positive
am=1; % am>0
bm=3;
gamma=1;
tf=200;
dt=0.00001;

y=zeros(1,tf/dt+1); % actual output
ym=zeros(1,tf/dt+1);

ahat=zeros(1,tf/dt+1); 
bhat=[-1,zeros(1,tf/dt)];% bhat(0)>0 given

khat=zeros(1,tf/dt+1); 
lhat=zeros(1,tf/dt+1); 

for index=1:(tf/dt)
    t=(index-1)*dt;
    
    ref_signal=sin(t); % input reference signal
    khat(index)=(ahat(index)+am)/(bhat(index));
    lhat(index)=(bm)/(bhat(index));
    
    u=-khat(index)*y(:,index)+lhat(index)*ref_signal; 
    
    e=ym(index)-y(index);
    
    y(index+1)=y(index)+dt*(a*y(index)+b*u);
    ym(index+1)=ym(index)+dt*(-am*ym(index)+bm*ref_signal);
    
    ahat(index+1)=ahat(index)+dt*(-gamma*e*y(index));
    bhat(index+1)=bhat(index)+dt*(-gamma*e*u);
end