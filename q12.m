%% 
clear all                  
rng('default');
rng(1389921);
x1=rand(1,100);
x2=rand(1,100);
eps=rand(1,100)*10^-1;     
z = franke(x1,x2);
z = z + eps;
x1=x1';
x2=x2';
z=z';
obs=[x1,x2,z];              
train = obs(1:75,:);
test = obs(76:end,:);
P=length(train);
w_mat=rand(P,3);  % weights matrix with columns: c1,c2 and w
rho1=10^(-3.5);   % initialize 1° regularization parameter
rho2=10^(-4.5);   % initialize 2° regularization parameter
tic                        
n=10;                     
perf_train=ones(n,3);      
perf_test=ones(n,3);
k=1;

for N=1:n
    for sigma=[0.3 0.5 1]
        figure(1)
        w_all=w_mat(1:N,:);
        [opt_ws,fval]=RBF(w_all,train,sigma,rho1,rho2,N);
        perf_train(N,k)=fval;
        [error_opt,~] = RBF_test(opt_ws,test,sigma,rho1,rho2,N);
        perf_test(N,k)=error_opt;
        if N==10 && sigma==0.3 
            [X1,X2] = meshgrid(0:0.02:1);
            test_fun = zeros([size(X1,2) size(X1,2)]);
            franky = zeros([size(X1,2) size(X1,2)]);
            for i = 1:size(X1,2)
                test_fun(:,i) = RBF_plot([X1(:,i) X2(:,i)],N,opt_ws,sigma);
                franky(:,i) = franke(X1(:,i), X2(:,i));
            end
            figure(l)
            surf(X1,X2,test_fun)
            hold on
            surf(X1,X2,franky)
            title('Real and approximating franke functions (RBF, N=8, \sigma=0.3)')
            xlabel('x_{1}')                           
            ylabel('x_{2}')
            zlabel('y')
            l=l+1;
        end
        k=k+1;
    end
    k=1;
    N
end
toc

figure(2)
hb = bar(perf_train);                                  
legend('\sigma_{1}=0.25','\sigma_{2}=0.5','\sigma_{3}=1') 
title('Training error performance (RBF)')           
xlabel('Neurons')                                           
ylabel('Error') 

figure(3)
hb = bar(perf_test);                                   
legend('\sigma_{1}=0.25','\sigma_{2}=0.5','\sigma_{3}=1') 
title('Test error performance (RBF)')               
xlabel('Neurons')                                            
ylabel('Error') 

RBF_error_mean=mean2(perf_train)     % Mean errors of RBF algorithm to
RBF_error_mean=mean2(perf_test)      %    insert in the performance table

%{
Algorithm = {'MLP (10 N''s, 3 c''s)';'RBF (10 N''s, 3 c''s)'};
Mean_train_error = [0.5684;0.4051]; 
Mean_test_error = [0.1557;0.1236];
Time_sec = [51.499182;285.546581];

---> Used to create the performance table

performance_table = table(Mean_train_error,Mean_test_error,Time_sec,'RowNames',Algorithm)
%}
