clc;
clear all;
close all;
%%
% Define number of features
Nf = 1000;

trainvec = [];
testvec = [];
% Define database size
for NDB = 200:1000:20000;

    % Genearate random Binary values
    A = round(rand(Nf,NDB));

    % Make it bipolar
    A = 2*A-1;

    % Train hpnn
    tic
    W = train_hpnn(A);
    
    t2 = toc;
    disp(['HPNN: For DB = ' num2str(NDB) ' : training time = ' num2str(t2)])
    
    % Train using second method
    tic
    op = train_direct(A);
    t1 = toc;
    disp(['P. method: For DB = ' num2str(NDB) ' : training time = ' num2str(t1)])
    
    
    trainvec = [trainvec;t1 t2];

    % Take any one pattern and recognise
    pattern = A(:,4);

    tic
    % Test hpnn
    ix = recognise_hpnn(pattern,A,W);
    t2 = toc;
    disp(['HPNN: For DB = ' num2str(NDB) ' : testing time = ' num2str(t2)])
    
    tic
    ix = test_direct(pattern,op);
    t1 = toc;
    
    disp(['P method: For DB = ' num2str(NDB) ' : testing time = ' num2str(t1)])

    testvec = [testvec;t1 t2];
end

figure;
plot(200:1000:20000,trainvec,'s-')
xlabel('No. of database');
ylabel('Training time (sec)');
grid on
legend('Previous Method','HPNN');

figure;
plot(200:1000:20000,testvec,'s-')
xlabel('No. of database');
ylabel('Testing time (sec)');
grid on
legend('Previous Method','HPNN');