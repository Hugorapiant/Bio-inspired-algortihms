close all
clear all
clc
%-----HYBRID GSO With GREY WOLF-------

n = 10;  %nº de particulas
dim = 2; % dimensão 
l_sup = [10 10];
l_inf = [-10 -10];

X_alfa=zeros(1,dim);
X_beta=zeros(1,dim);
X_delta=zeros(1,dim);

% Inicialização de particulas
for i=1:n
    for j=1:dim
        X(i,j) = l_inf(1,j)+(l_sup(1,j)-l_inf(1,j)).*rand;
    end
end


% Inicialização dos Parâmetros

r_s = 10;              % Sensor Range 
ro = 0.4;              % Luciferin decay constant
gamma = 0.6;           % Luciferin enhancement fraction
beta = 0.08;           % Decision range gain
n_t = 4;               % Number of neighbors
step = 0.03;           % Distance moved by each gw 

luc = 4.*ones(n,1);    % Luciferin das Particulas
r_d = 4.*ones(n,1);    % Local decision range

iter = 0;
itmax = 80;

while iter<itmax
  
    iter=iter+1
    a=2-iter*(2/itmax); %[0,2]
     
    %---------Luciferin Update-----------
    for i=1:1:n
        fobj1 = (X(i,1)^2+X(i,2)^2);
        fobj = 200-fobj1;
        luc(i,:) = (1-ro).*luc(i,:)+gamma*fobj;
    end
    
   
    N = zeros(n,n);
    Nv = zeros(n,1);
    Nluc = zeros(n,n);
    
    for i=1:n 
        
        %-------Neighbords------
        for j=1:n
            Nsum=0;
            if(j~=i) 
                d = norm(X(j,:)-X(i,:));
            if((d<=r_d(i)) && (luc(j)>luc(i)))
                N(i,j) = 1;
                Nsum = Nsum+1;
            end 
            end
        Nv(i) = Nsum;
        end
      
       %-----Seleção-Alfa-Beta-Delta---
       Alfa_luc = 0; 
       Beta_luc = 0;
       Delta_luc = 0;
       
       for j=1:n
            Nluc(i,j) = (N(i,j)*luc(j));
       end
         for j=1:n
             if(Nluc(i,j)>Alfa_luc)
                Alfa_luc = Nluc(i,j);
                X_alfa = X(j,:);
             end
         end
         for j=1:n
            if((Alfa_luc>Nluc(i,j)) && (Nluc(i,j)>Beta_luc))
                Beta_luc = Nluc(i,j);
                X_beta = X(j,:);
            end
         end
         for j=1:n
            if((Alfa_luc>Nluc(i,j)) && (Beta_luc>Nluc(i,j)) && (Nluc(i,j)>Delta_luc))
                Delta_luc = Nluc(i,j);
                X_delta = X(j,:);
            end
         end
         
         %------Movimentaçao------
         for j=1:dim

                %ALFA
                r1=rand();
                r2=rand(); 
                A1=2*a*r1-a;
                C1=2*r2;
            
                D_alfa(i,j) = abs(C1*X_alfa(:,j)-X(i,j));
                X1 = X_alfa(:,j)-A1*D_alfa(i,j);
            
                %BETA
                r1=rand();
                r2=rand();
                A2=2*a*r1-a;
                C2=2*r2;
            
                D_beta(i,j) = abs(C2*X_beta(:,j)-X(i,j));
                X2 = X_beta(:,j)-A2*D_beta(i,j);
            
                %DELTA
                r1=rand();
                r2=rand();
                A3=2*a*r1-a;
                C3=2*r2;
            
                D_delta(i,j) = abs(C3*X_delta(:,j)-X(i,j));
                X3 = X_delta(:,j)-A3*D_delta(i,j);
            
                X(i,j)=(X1+X2+X3)/3;
        end
       
        r_d(i) = min(r_s, max(0,r_d(i)+beta*(n_t-Nv(i))));
            
    end
    
        % Border Control
    for i=1:n
        for j=1:dim
            if X(i,j)>l_sup(1,j)
                X(i,j)=l_sup(1,j);
            end
             if X(i,j)<l_inf(1,j)
                X(i,j)=l_inf(1,j);
             end
        end
    end
    
    %Plots
    figure(1)
    plot(X(:,1),X(:,2),'rx')
    grid on
    axis([l_inf(1,1) l_sup(1,1) l_inf(1,2) l_sup(1,2)])
    view(0,90)
    pause(0.01)
  
    end
    
    
