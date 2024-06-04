clc;clear;close all;
%% Define parameters 
b = 0.160; % Wheel distance
kr = 0.0005; % error constant for right wheel
kl = 0.0005; % error constant for left wheel
r = 0.033; % tyre radius mm

%% speed (You can either enter linear speed or enter the angular speed of tyres (Comment the line 13 and 14 for angular)
omega_r = 1.0; % right wheel rad/s
omega_l = 0.5; % left wheel rad/s
v_r = omega_r * r; % right wheel m/s
v_l = omega_l * r; % left wheel m/s
v_r = 0.15; % right wheel m/s
v_l = 0.15; % left wheel m/s

%% Initilaziton
dt = 0.1; 
T = 10; 
timesteps = T/dt;
x = 0; y = 0; theta = 0;
Sigma_p = zeros(3, 3); % covariance 
X = zeros(timesteps, 1);
Y = zeros(timesteps, 1);
Theta = zeros(timesteps, 1);
Sigma_all = zeros(3, 3, timesteps);

%% Main loop
for t = 1:timesteps
    delta_s_r = v_r * dt;
    delta_s_l = v_l * dt;
    delta_s = (delta_s_r + delta_s_l) / 2;
    delta_theta = (delta_s_r - delta_s_l) / b;
    x = x + delta_s * cos(theta + delta_theta / 2);
    y = y + delta_s * sin(theta + delta_theta / 2);
    theta = theta + delta_theta;

    % Update covariance 
    F_p = [1 0 -delta_s * sin(theta + delta_theta / 2); 
           0 1 delta_s * cos(theta + delta_theta / 2); 
           0 0 1];
       
    F_delta = [cos(theta + delta_theta / 2) / 2 -delta_s * sin(theta + delta_theta / 2) / (2 * b);
               sin(theta + delta_theta / 2) / 2 delta_s * cos(theta + delta_theta / 2) / (2 * b);
               1 / b -1 / b];
               
    Sigma_delta = [kr * abs(delta_s_r) 0; 0 kl * abs(delta_s_l)];
    Sigma_p = F_p * Sigma_p * F_p' + F_delta * Sigma_delta * F_delta';
    X(t) = x;
    Y(t) = y;
    Theta(t) = theta;
    Sigma_all(:, :, t) = Sigma_p;
    
    %%% I used it for debugging. commenout to see step by step
    % if mod(t, 10) == 0 
    %     figure(1);
    %     plot(X, Y, 'k');
    %     hold on;
    %     error_ellipse(Sigma_p(1:2, 1:2), [x y]);
    %     plot(x, y, 'ro'); 
    %     hold off;
    %     pause(0.1);
    % end
end

%% Plotting

figure(2);
plot(X, Y, 'k', 'LineWidth', 1.5);
hold on;
for t = 1:10:timesteps
    error_ellipse(Sigma_all(1:2, 1:2, t), [X(t) Y(t)]);
    plot(X(t), Y(t), 'ro'); 
end
xlabel('x [m]');
ylabel('y [m]');
title('Uncertainty Ellipses');
axis equal; 
grid on; 
hold off;
