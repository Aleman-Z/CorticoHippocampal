% Wrong approach, since mdata coefficients are generated using a Parametric model. 
ptic('*** var_to_autocov... ');
[G,info] = var_to_autocov(A,SIG,acmaxlags);
ptoc;

%%
ptic('*** var_to_autocov... ');
[G,info] = var_to_autocov(mdata.coeffs,mdata.noisecov,acmaxlags);
ptoc;
