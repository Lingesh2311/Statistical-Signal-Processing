%do_rlse
clear
clc
close all
%% Setting the Parameters
x_correct = [0.5 2.0]'; %The true value of unknown coefficient vector
NA = length(x_correct);
x = zeros(NA,1); % Initial Estimate of X = [a b] = [0 0]
P = 100*eye(NA,NA); % Initial Estimate of P = 100*Identity matrix
X_estimate = ones(10000,2); % Stores the parameter estimates
K_estimate = ones(10000,2); % Stores the gain K estimates
P_estimate = ones(10000,2); % Stores the Trace(covariance) estimates

%% Loading and defining the Input and Output Data Matrices
input = load('lab4.mat', 'u'); % Loads the Input data
A = horzcat(input.u.^0.5, sin(input.u)); % Stores the Input Data Matrix

output = load('lab4.mat', 'y'); % Loads the output data
b = output.y; % Stores the output Data Matrix

%% Calling the Function to calculate the RLS Estimate

for k = 1:100000 % Decides the amount of data to be used for calculating the Estimate
[x,K,P] = rlse_online(A(k,:),b(k,:),x,P); % Call the function 
X_estimate(k,:) = x;  % Store the parameter estimate
K_estimate(k,:) = K; % Store the Gain estimate
P_estimate(k,:) = trace(P); % Store the Covariance Estimate
end

%% Plotting the Estimate of Parameter
figure('Name','Coefficient','NumberTitle','off');
plot(X_estimate);
line([0 4500], [2,2], 'Color','r','LineStyle','--');
line([0 4500], [0.5,0.5], 'Color','b','LineStyle','-.');
xlim([0 4500]);
title('Estimate of Parameters');

%% Plotting the Estimate of Gain: K
figure('Name','Value of Gain K','NumberTitle','off');
plot(K_estimate);
xlim([0 1000]);
title('Estimate of K');

%% Plotting the Estimate of Covariance: Trace(P)
figure('Name','Trace of Covariance P','NumberTitle','off');
plot(P_estimate);
xlim([0 1000]);
title('Estimate of P');