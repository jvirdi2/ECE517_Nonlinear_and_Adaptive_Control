% Q2-with modification

a=5; 
% tf=10000 dt=0.0001

% Case 1 where b is slightly small and plant stable without input
% stable for a=-5 b=2 am=1 and bm=3 bo=0.05 gamma=0.01 bhat(0)=1
% stable for a=-5 b=2 am=1 and bm=3 bo=0.05 gamma=0.01 bhat(0)=3 
% stable for a=-5 b=2 am=1 and bm=3 bo=0.05 gamma=1 bhat(0)=25

% Case 2 where b is slightly small and plant unstable without input
% unstable for a=5 b=2 am=1 and bm=3 bo=1 gamma=0.05 bhat(0)=1.5
% stable for a=5 b=2 am=1 and bm=3 bo=1 gamma=0.05 bhat(0)=15 
% stable for a=5 b=2 am=1 and bm=3 bo=1 gamma=0.05 bhat(0)=25

% Case 3 where b is big (away from 0) and plant stable without input
% stable for a=-5 b=20 am=1 and bm=3 bo=0.05 gamma=1 bhat(0)=1
% stable for a=-5 b=20 am=1 and bm=3 bo=0.05 gamma=1 bhat(0)=15
% stable for a=-5 b=20 am=1 and bm=3 bo=0.05 gamma=1 bhat(0)=25

% Case 4 where b is big (away from 0) and plant unstable without input
% stable for a=5 b=20 am=1 and bm=3 bo=0.05 gamma=1 bhat(0)=1
% stable for a=5 b=20 am=1 and bm=3 bo=0.05 gamma=1 bhat(0)=15
% stable for a=5 b=20 am=1 and bm=3 bo=0.05 gamma=1 bhat(0)=25

b=2; % for part a, b is positive
am=1; % am>0
bm=3;
gamma=0.00001;
tf=500;
dt=0.0001;

y=zeros(1,tf/dt+1); % actual output
ym=zeros(1,tf/dt+1);

ahat=zeros(1,tf/dt+1); 
bhat=[10,zeros(1,tf/dt)];% bhat(0)>0 given

khat=zeros(1,tf/dt+1); 
lhat=zeros(1,tf/dt+1); 

for index=1:(tf/dt)
    t=(index)*dt;
    
    ref_signal=sin(t); % input reference signal
    khat(index)=(ahat(index)+am)/(bhat(index));
    lhat(index)=(bm)/(bhat(index));
    
    u=-khat(index)*y(index)+lhat(index)*ref_signal; 
    
    e=ym(index)-y(index);
    
    y(index+1)=y(index)+dt*(a*y(index)+b*u);
    ym(index+1)=ym(index)+dt*(-am*ym(index)+bm*ref_signal);
    
    ahat(index+1)=ahat(index)+dt*(-gamma*e*y(index));
    % Assume b>=bo given and bo=1
    % bhat(0)>=bo
    bo=0.5;
    if (bhat(index)>bo) || (bhat(index)==bo && ((e*u)<0))
        bhat(index+1)=bhat(index)+dt*(-gamma*e*u);
    else
        bhat(index+1)=bhat(index);
    end
end