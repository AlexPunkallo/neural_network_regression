function [error] = RBF_error(w_all,train,sigma,rho1,rho2,N)
    error=0;
    f1=zeros(1,N);
    f2=zeros(1,N);
    yhat=zeros(1,length(train));
    for i=1:length(train)
        for j=1:N
            f1(j)=norm(train(i,1:2)-w_all(j,1:2));
            f2(j)=(f1(j)^2+sigma^2)^(-1/2);
            f2(j)=f2(j)*w_all(j,3);
        end
        yhat(1,i)=sum(f2);
        error=error+(train(i,3)-yhat(1,i))^2;
    end
    error=1/2*error+(rho1/2)*norm(w_all(:,3))^2+(rho2/2)*norm(w_all(:,1:2))^2;
end