%Article:PySOA: A Novel Bio-Inspired Python Snake Optimization Algorithm
%Journal:International Journal of Intelligent Systems
%outhers:
%Mahmoud S. Diab(m.diab@aun.edu.eg)
%Yousef S. Alsahafi(ysalsahafi@uj.edu.sa)
%Mohamed M. Darwish(mohamed_darwish@aun.edu.eg)
%Diego Oliva(diego.oliva@cucei.udg.mx)
%Khalid M. Hony*(k_hosny@yahoo.com; k_hosny@zu.edu.eg)
%Developed at MATLAB R2016a
% You can simply define your cost in a seperate file and load its handle to fobj 
% The initial parameters that you need are:
%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of generations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n

% To run PySOA: [Best_score,Best_pos,POSA_cg_curve]=PySOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%__________________________________________

clear all 
clc
SearchAgents_no=30; % Number of search agents
Function_name='F1'; % Name of the test function that can be from F1 to F23 
Max_iteration=500; % Maximum number of iterations
max_distance=100;
Run_No=30;
% Load details of the selected benchmark function
[lb,ub,dim,fobj] = Get_Functions_details(Function_name);
results=zeros(1,Run_No);
for i=1:Run_No
    [Best_pos,Best_score,Conv_curve]=PySOA(SearchAgents_no,Max_iteration,max_distance,lb,ub,dim,fobj);
    results(1,i)=Best_score;
end
figure('Position',[500 500 660 290])
%Draw objective space
semilogy(Conv_curve,'Color','r')
title('Objective space')
xlabel('Iteration');
ylabel('Best score obtained so far');
axis tight
grid on
box on
legend('PySOA')
display(['The best solution obtained by PySOA is : ', num2str(Best_pos)]);
display(['The best optimal value of the objective funciton found by PySOA is : ', num2str(Best_score)]);
display(['results for 30 times run is: ',num2str(results)]);
        



