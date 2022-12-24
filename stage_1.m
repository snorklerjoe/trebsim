% Stage #1
%   Initial motion of tucked arm until separation at theta=theta_2

% Dynamics:
% Torque on the arm about P0:
tau_cw = @(theta) (l_3-l_2)*m_cw*g*cos(theta);  % From weight
tau_l1 = @(theta) (l_1/2)*m_1*g*cos(theta);     % From length #1
tau_l2 = @(theta) -(l_2/2)*m_2*g*cos(theta);    % From length #2
tau_l3 = @(theta) p_3(theta, phi_0)*m_3*(p_3(theta, phi_0)*l_3*cos(phi_0-theta)/2)*g*cos(theta); % (length #3)
if l_s <= l_1                                   % From the sling & projectile
  % The sling does not cross P0-
  tau_s = @(theta) g*cos(theta)*( (l_s/2)*m_sr* + (l_1-l_s)*(m_sp+m_p));
else
  % The sling does cross P0-
  p_sling = (l_1/l_s);  % portion of the sling in the positive torque side of P0
  tau_s = @(theta) g*cos(theta)*( m_sr*((l_1)*p_sling - (l_s-l_1)*(1-p_sling))/2 - (m_sp + m_p)*(l_s-l_1));
end

tau_net = @(theta) tau_cw(theta) + tau_l1(theta) + tau_l2(theta) + tau_l3(theta) + tau_s(theta);

% Moments of Inertia:
I_tot = I_1 + I_2 + I_3 + I_cw(phi_0);
% TODO: I_s

% Kinematics:
alpha = @(t, theta) [theta(2), tau_net(theta(1)) / I_tot];
[t, sol] = ode45(alpha, 0:dt:t_max, [theta_0;0]);
theta = sol(:,1);
omega = sol(:,2);

% trim matricies to theta=theta_2 boundary:
stage1_boundary = find(theta >= theta_2, 1);
t     = t(1:stage1_boundary);
theta = theta(1:stage1_boundary);
omega = omega(1:stage1_boundary);

