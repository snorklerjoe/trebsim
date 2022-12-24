% Parameter declarations-

% Simulation Parameters:
disp "\nSimulation Parameters:";
dt     = 0.0001        % Timestep
t_max  = 5             % Time to stop simulating

% Plots:
stress_plots     = 1   % Plots of arm stress
motion_plots     = 1   % Plots of motion

% Physical Trebuchet Parameters:
disp "\nPhysical Parameters:";
% arm
m_1  = 1     % Mass (kg) of sling side of the arm
l_1  = 1.0668% Length (m) of sling side of the arm
m_2  = 1     % Mass (kg) of weight side of the arm
l_2  = 0.178 % Length (m) of weight side of the arm

% weight
m_3  = 0.3   % Mass (kg) of the weight arm
m_cw = 6.8   % Mass (kg) of the weight
l_3  = .33   % Length of the weight arm

% sling
l_s  = 0.75  % Length (m) of the sling
m_sr = 0.05  % Total mass (kg) of the rope to the sling
m_sp = 0.05  % Total mass (kg) of the sling pouch

% projectile
m_p  = 0.1   % Mass (kg) of the projectile

% angles
% All angles are of the sling-side of the arm referenced to below the horizontal
theta_0 = deg2rad(-15)  % Starting angle of the arm
theta_2 = deg2rad(90)   % theta at the end of stage #1

phi_0   = deg2rad(5)    % Initial angle between l_3 and l_2

% Checks:
assert (l_3 > l_2, "The weight arm is too short to function!");
assert (l_s < (l_1+l_2), "The sling is too long");
assert (l_1 + l_2 < 1.75, "The throwing arm is illegally long");
disp "Passed parameter checks.\n\n";
