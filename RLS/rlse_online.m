%% Function to estimate the State, Gain, and Covariance
function [x,K,P] = rlse_online(aT_k1,b_k1,x,P)
K = P*aT_k1'/(aT_k1*P*aT_k1'+1); 
x = x +K*(b_k1-aT_k1*x); 
P = P-K*aT_k1*P; 