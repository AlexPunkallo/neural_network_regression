function [opt_ws,fval]=RBF(x0,train,sigma,rho1,rho2,N)
    rng('default');
    rng(1389921);
    options = optimoptions(@fminunc,'Algorithm','quasi-newton','Display','none');
    fun=@(w_all)RBF_error(w_all,train,sigma,rho1,rho2,N);
    [opt_ws,fval,~,~] = fminunc(fun,x0,options);   
end