ptic('*** var_to_autocov... ');
[G,info] = var_to_autocov(A,SIG,acmaxlags);
ptoc;

%%
ptic('*** var_to_autocov... ');
[G,info] = var_to_autocov(mdata.coeffs,mdata.noisecov,acmaxlags);
ptoc;
