clc,clear

% Initialized initial state

x0 = -0.3;
z0 = 1;
xd0 = 0.8;
zd0 = 0.;
zf = 1;

g = 9.8;

init_state = [x0,xd0,z0,zd0];

% Plot desired z trajectory

plot(x0,z0,'o');hold on;
plot([x0 0],[z0 0],'o-b');

z = [z0];

for x = x0:0.001:0
    z(end+1) = retrieve_z_trajectory(init_state,x,zf);
end

% Initialize variables for simulation and plots
hold on;
plot([x0,x0:0.001:0],z)
daspect([1 1 1])

state = init_state;
x_sequence = [x0];
z_sequence = [z0];
xd_sequence = [xd0];
f_leg_normalized = [];
f_leg_normalized(end+1) = 0;

% Controller simulation

for n = 1:100
   u = cubic_clipped_controller(state,zf);
   qdd = [0, -g]' + [state(1) state(3)]'*u;
   state([2,4]) = state([2,4]) + qdd'*0.01;
   state([1,3]) = state([1,3]) + state([2,4])*0.01;
   x_sequence(end+1) = state(1);
   z_sequence(end+1) = state(3);
   xd_sequence(end+1) = state(2);
   f_leg_normalized(end+1) = 1/g*u*norm([state(1),state(3)]);
   plot([state(1) 0],[state(3) 0],'o-r');
   plot(x_sequence,z_sequence,'-');
   %pause();
end

% Plot xd vs x

figure(2)
daspect([1 1 1])
plot(x_sequence,xd_sequence);
xlabel('x')
ylabel('xd')

% Plot normalized leg force 
figure(3)
daspect([1 1 1])
plot(x_sequence,f_leg_normalized);
xlabel('x')
ylabel('f leg normalized')



