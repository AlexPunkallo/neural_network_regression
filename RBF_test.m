function [error_opt,yhat] = RBF_test(opt_ws,test,sigma_opt,rho1,rho2,N_opt)
    error_opt=0;
    f1=zeros(1,N_opt);
    f2=zeros(1,N_opt);
    yhat=zeros(1,length(test));
    for i=1:length(test)
        for j=1:N_opt
            f1(j)=norm(test(i,1:2)-opt_ws(j,1:2));
            f2(j)=(f1(j)^2+sigma_opt^2)^(-1/2);
            f2(j)=f2(j)*opt_ws(j,3);
        end
        yhat(1,i)=sum(f2);
        error_opt=error_opt+(test(i,3)-yhat(1,i))^2;
    end
    error_opt=1/2*error_opt+(rho1/2)*norm(opt_ws(:,3))^2+(rho2/2)*norm(opt_ws(:,1:2))^2;
end