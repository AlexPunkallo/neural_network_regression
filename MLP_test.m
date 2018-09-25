function [error_opt,yhat] = MLP_test(opt_ws,test,c,N)  % Similar to MLP_error but
    error_opt=0;                                       %    it uses the test set
    f1=zeros(1,N);                                     %    and the temporary optimal
    f2=zeros(1,N);                                     %    weights values
    yhat=zeros(1,length(test));
    for i=1:length(test)
        for j=1:N
            f1(j)=-opt_ws(j,1)+opt_ws(j,2)*test(i,1)+opt_ws(j,3)*test(i,2);
            f2(j)=(1-exp(-c*f1(j)))/(1+exp(-c*f1(j)));
            f2(j)=f2(j)*opt_ws(j,4);
        end
        yhat(1,i)=sum(f2);
        error_opt=error_opt+(test(i,3)-yhat(1,i))^2;
    end
    error_opt=1/2*error_opt;
end