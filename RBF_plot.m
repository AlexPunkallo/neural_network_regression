function [yhat] = RBF_plot(test,N,w_all,sigma)
    f1=zeros(1,N);
    f2=zeros(1,N);
    yhat=zeros(1,length(test));
    for i=1:length(test)
        for j=1:N
            f1(j)=norm(test(i,1:2)-w_all(j,1:2));
            f2(j)=(f1(j)^2+sigma^2)^(-1/2);
            f2(j)=f2(j)*w_all(j,3);
        end
        yhat(1,i)=sum(f2);
    end
end