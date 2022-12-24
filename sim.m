% Whipper Trebuchet Simulation
% By Joseph R. Freeston
% ----------------------------
%
% This attempts to approximately model a Whipper-style trebuchet, making the
% following *key assumptions*:
%     * The weight and its arm is assumed to be inline with the throwing arm
%         while in the tucked position.
%     * The weight arm is assumed to remain tucked until the throwing arm
%         reaches the vertical position.
%

% Setup and initialization:
clear;
warning('off', 'OctSymPy:sym:rationalapprox');
clc;
disp "Whipper Trebuchet Simulation"
disp " (C) 2022 Joseph R. Freeston"
disp "----------------------------"

source parameters.m;
source constants.m;
source rotational_mechanics.m;

% Stage 1-
%   Initial motion of tucked arm until separation at theta=theta_2
disp "Solving stage_1";
stage_1;
printf("Solved motion from t=%d to t=%d.\n", t(1), t(end));

% Store simulation data so far
t_s1     = t;
theta_s1 = theta;
omega_s1 = omega;
phi_s1   = phi_0*ones(length(t_s1),1);

if stress_plots
  stress = abs(tau_l1(theta))+abs(tau_l2(theta))+abs(tau_cw(theta))+abs(tau_s(theta));
  plot(t, stress);
  title "Approx ARM stress (Nm) at center axle over first stage of motion";
end

% Stage 2-
%   Motion after theta=theta_2
disp "Solving stage_2";
stage_2;
printf("Solved motion from t=%d to t=%d.\n", t_s1(end), t(end));

% Store simulation data so far
t_s2     = t;
theta_s2 = theta;
omega_s2 = omega;
phi_s2   = phi;

% Concatenate simulation data
t     = cat (1, t_s1, t_s2);
theta = cat (1, theta_s1, theta_s2);
omega = cat (1, omega_s1, omega_s2);
phi   = cat (1, phi_s1, phi_s2);

if motion_plots
  % Plot omega and theta over time:
  figure;
  ax = plotyy(t, rad2deg(theta), t, rad2deg(omega), @plot, @plot);
  title "Angular Motion of the Arm";
  xlabel "time (s)";
  ylabel (ax(1), "Angular Position (deg)");
  ylabel (ax(2), "Angular Velocity (deg/s)");
  hold on;
  plot(t_s1(end)*ones(1,2), [0 1]);
  grid on;

  figure;
  ax = plotyy(t, theta, t, phi, @plot, @plot);
  title "Angular Positioning of the Arm";
  xlabel "time (s)";
  ylabel (ax(1), "Angular Position of the THROWING ARM (rad)");
  ylabel (ax(2), "Angular Position of the WEIGHT ARM (rad)");
  hold on;
  plot(t_s1(end)*ones(1,2), [0 1]);
  grid on;
  
  figure;
  plot(theta, omega*l_1);
  title "Linear Tangential Velocities";
  xlabel "Theta (rad)";
  ylabel "Tangential Velocity (m/s)";
  hold on;
  plot(pi*ones(1,2), [0 1]);
  plot(1.25*pi*ones(1,2), [0 1]);
  plot(1.5*pi*ones(1,2), [0 1]);
end
