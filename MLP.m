function [opt_ws,fval]=MLP(w_all,train,c,N)
    rng('default');
    rng(1389921);
    options = optimoptions(@fminunc,'Algorithm','quasi-newton','Display','none'); % Setting the options for fminunc
    %options = optimoptions('fminunc','Algorithm','quasi-newton','MaxFunEvals',10000,'MaxIter',10000);
    fun=@(w_all)MLP_error(w_all,train,c,N);       % call the error_fun and 
    [opt_ws,fval] = fminunc(fun,w_all,options);   %    minimize the weights
                                                  %    with fminunc function
end