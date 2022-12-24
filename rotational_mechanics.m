% Rotational Mechanics

% portion on the positive torque side of P0 found with some law of sines magic:
p_3 = @(theta, phi) 1-(l_2*cos(theta)/cos(phi-theta))/l_3;

% Moments of Inertia

% I of the throwing arm about P0
I_1   = (1/3)*m_1*l_1^2;
I_2   = (1/3)*m_2*l_2^2;
I_3   = (1/3)*m_3*l_3^2;

%l_cw  = @(phi) sqrt(l_3^2+l_2^2-2*l_3*l_2*cos(phi));  % law of cosines magic
I_cw  = @(phi) m_cw*(l_3^2+l_2^2-2*l_3*l_2*cos(phi));


% I of the weight about P1
%I_cw = m_cw*l_3^2+(1/3)*m_3*l_3^2;
