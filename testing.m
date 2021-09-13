clear

D = 2.5*1e-2;
vsound = 340.3;
fc_teor_min = 500;
fc_teor_max = 7*1e3;

lambda_teor_min = vsound/fc_teor_min;
d_teor_min = lambda_teor_min/2 * 1e2;

lambda_teor_max = vsound/fc_teor_max;
d_teor_max = lambda_teor_max/2 * 1e2;


d_f_min = 2*D^2/lambda_teor_min;
d_f_max = 2*D^2/lambda_teor_max;