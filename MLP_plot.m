function [yhat] = MLP_plot(test,N,w_all,c) % Similar to MLP_error but it returns
    f1=zeros(1,N);                         %    only the estimated y's    
    f2=zeros(1,N);                 
    yhat=zeros(1,length(test));
    for i=1:length(test)
        for j=1:N
            f1(j)=-w_all(j,1)+w_all(j,2)*test(i,1)+w_all(j,3)*test(i,2);
            f2(j)=(1-exp(-c*f1(j)))/(1+exp(-c*f1(j)));
            f2(j)=f2(j)*w_all(j,4);
        end
        yhat(1,i)=sum(f2);
    end
end