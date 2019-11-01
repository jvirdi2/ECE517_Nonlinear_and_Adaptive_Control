% Q1-Least squares simulations for part e
% u=sin(t)

% Get y and u as function of t first by simulating the given system
beta=0.1;
k=5;
tf=200;
dt=0.00002;
y=zeros(2,tf/dt+1); % initial condition assumed as [0;0]

for index=1:(tf/dt)
    t=(index-1)*dt;
    if (t<20)
        m=20;
    else
        m=20*(2-exp(-0.01*(t-20)));
    end
    A=[[0 1];[-k/m -beta/m]];
    B=[0;1/m];
    u=10*sin(2*t); % Here specify the control input
    y(:,index+1)=y(:,index)+dt*(A*y(:,index)+B*u);
end

% Here the real simulation starts for estimating parameters
% given y and u only
given_output=[1 0]*y;
% Here, the initial value of ydot and yddot is assumed randomly as 1 and 2
% Used backward difference method to compute displacement derivative values
% at remaining time instants etc
y_actual_dot=[1,(given_output(2:end)-given_output(1:end-1))/dt];
y_actual_ddot=[2,(y_actual_dot(2:end)-y_actual_dot(1:end-1))/dt];
P=100*[5 0 0;0 6 0;0 0 7];% Initial value of P matrix
initial_parameter_estimate=[[0;0;0],zeros(3,tf/dt)];


for index=1:((tf/dt))
    t=(index-1)*dt;
    u=10*sin(2*t); % Here specify the control input
    y_actual=given_output(index);
    y_dot=y_actual_dot(index);
    phi=[u;-y_dot;-y_actual];
    normalize_fac=sqrt(1+phi'*phi);
    y_estim=(initial_parameter_estimate(:,index)'*phi);
    error=(y_estim-y_actual_ddot(index));
    % I didn't use normalised forms of phi and error in the ODE equations 
    % as it slowed down learning.
    initial_parameter_estimate(:,index+1)=initial_parameter_estimate(:,index)...
    +dt*((-1)*(P*phi*error)/(normalize_fac*normalize_fac));
    P=P-((dt*P*(phi*phi')*P)/(normalize_fac*normalize_fac));
end
 
