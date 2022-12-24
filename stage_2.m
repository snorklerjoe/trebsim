% Stage #2
%   Motion from theta_2 and on
%   --------------------------

% Dynamics:
% ---------
r_cw      = @(theta, phi) sqrt(l_2^2 + l_3^2 - 2*l_2*l_3*cos(phi));  % Radius from P0 to m_cw
% Torques about P0 (central axis):
tau_l1    = @(theta) -(l_1/2)*m_1*g*cos(theta);     % From length #1
tau_l2    = @(theta) (l_2/2)*m_2*g*cos(theta);      % From length #2
tau_cw    = @(theta, phi) m_cw*g*r_cw(theta, phi)*sin(l_2*sin(phi)/r_cw(theta, phi)-90+theta+phi);
% TODO: tau_3, tau_s
tau_net   = @(theta, phi) tau_l1(theta) + tau_l2(theta) + tau_cw(theta, phi);

% Moments of Inertia about P0:
I_tot     = @(phi) I_1 + I_2 + I_3 + I_cw(phi);
% TODO: I_s

% Torques about P1:
tau_cw_1  = @(theta, phi) m_cw*g*l_3*sin(90+theta+phi);
% TODO: tau_3_1
tau_net_1 = @(theta, phi) tau_cw_1(theta, phi);

% Moments of Inertia about P1:
I_3_1    = (1/3)*m_3*l_3^2;
I_cw_1   = m_cw*l_3^2;
I_tot_1  = I_3_1 + I_cw_1;


% Kinematics:
% -----------
% x = [theta omega; phi d/dt(phi)]
alpha = @(t, x) [x(2);tau_net(x(1), x(3))/I_tot(x(3));x(3);tau_net_1(x(1), x(3))/I_tot_1];
s2_init_cond = [
  theta_s1(end);omega_s1(end);phi_0;0
];
[t, sol] = ode45(alpha, t_s1(end):dt:t_max, s2_init_cond);
theta = sol(:,1);
omega = sol(:,2);
phi   = sol(:,3);

% Detect Boundary condition:
stage2_boundary = find(theta>(2*pi), 1);
if length(stage2_boundary) >= 1
  t     = t(1:stage2_boundary);
  theta = theta(1:stage2_boundary);
  omega = omega(1:stage2_boundary);
  phi = phi(1:stage2_boundary);
end

