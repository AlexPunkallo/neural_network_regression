%%     
clear all
rng('default');             % setting the seed with the
rng(1389921);               % author matricola '1389921'
x1=rand(1,100);             % initialize x1 set (uniformly)
x2=rand(1,100);             % initialize x2 set (uniformly)
eps=rand(1,100)*10^-1;      % initialize error epsilon (uniformly, 10^-2 scale)
z = franke(x1,x2);          % initialize franke function and
z = z+eps;                  %          add the error epsilon
x1=x1';
x2=x2';
z=z';
obs=[x1,x2,z];              % final dataset

train = obs(1:75,:);        % divide the dataset in training (75%)
test = obs(76:end,:);       %                 and test (25%) sets
P=length(train);
w_mat=rand(P,4);            % define a weights matrix, considering in the
                            %    1° column the b values, the 2° w1, the 
                            %    3° w2 and in the 4° column the v values
                            
tic                         % consider to timing the algorithm
n=10;                       % number of neurons we want to test
perf_train=ones(n,3);       % initialiaze matrix that we will use to check
                            %     the performance of the error
perf_test=ones(n,3);
k=1;

for N=1:n                   % for each set of neurons
    for c=[0.5 1 5]         % for each parameter c chosen in [0.5 1 5]
        w_all=w_mat(1:N,:); % consider N neuron rows of the weights matrix
        [opt_ws,fval]=MLP(w_all,train,c,N); % insert our parameters in the
                                            %    MLP algorithm (see MLP.m)
        perf_train(N,k)=fval;               % keep the min value at neuron N,
                                            %    at c parameter
                
        [error_opt,~] = MLP_test(opt_ws,test,c,N); % obtain the error on the test set
        perf_test(N,k)=error_opt;                  % save the error
        
        if N==6 && c==5             % When neurons are 6 and c=5, plot the
            figure(1)               %     approximating function on the
                                    %     on the franke one
            [X1,X2] = meshgrid(0:0.02:1);
            test_fun = zeros([size(X1,2) size(X1,2)]);
            franky = zeros([size(X1,2) size(X1,2)]);
            for i = 1:size(X1,2)
                test_fun(:,i) = MLP_plot([X1(:,i) X2(:,i) ],N,opt_ws,c);
                franky(:,i) = franke(X1(:,i), X2(:,i));
            end
            surf(X1,X2,test_fun)
            hold on
            surf(X1,X2,franky)
            title('Real and approximating franke functions (MLP, N=6, c=5)')
            xlabel('x_{1}')
            ylabel('x_{2}')
            zlabel('y')
        end
        k=k+1;
    end
    k=1;
    N
end
toc

figure(2)
hb = bar(perf_train);                   % Create a bar plot with the
legend('c_{1}=0.5','c_{2}=1','c_{3}=5') %    performance of the training
title('Training error performance (MLP)')     %    error for each N neuron and  
xlabel('Neurons')                       %    each c parameter  
ylabel('Error') 

figure(3)
hb = bar(perf_test);                    % Create a bar plot with the
legend('c_{1}=0.5','c_{2}=1','c_{3}=5') %    performance of the test
title('Test error performance (MLP)')         %    error for each N neuron and  
xlabel('Neurons')                       %    each c parameter  
ylabel('Error')

mlp_error_mean=mean2(perf_train);       % Mean errors of MLP algorithm to
mlp_error_mean=mean2(perf_test);        %    insert in the performance table

