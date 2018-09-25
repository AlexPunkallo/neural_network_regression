function [error] = MLP_error(w_all,train,c,N)
    error=0;                       
    f1=zeros(1,N);                
    f2=zeros(1,N);                
    yhat=zeros(1,length(train));
    for i=1:length(train)                                                   % For each set of x's
        for j=1:N                                                           % For each neuron 
            f1(j)=-w_all(j,1)+w_all(j,2)*train(i,1)+w_all(j,3)*train(i,2);  % Calculate the results using
            f2(j)=(1-exp(-c*f1(j)))/(1+exp(-c*f1(j)));                      %   the hyperbolic tangent as
            f2(j)=f2(j)*w_all(j,4);                                         %   activation function                          
        end
        yhat(1,i)=sum(f2);                      % Sum up all the results from the neurons
        error=error+(train(i,3)-yhat(1,i))^2;   %    and calculate the error for every set of x's
    end
    error=1/2*error;
end