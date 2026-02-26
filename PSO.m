close all
clear all
clc


n=5;
dimensao=2;
limite_superior=[100 50];
limite_inferior=[-100 -25];


Gbest=inf;
xGbest=zeros(1,dimensao)+inf;
Pbest=zeros(n,1)+inf;
xPbest=zeros(n,dimensao)+inf;
v=rand(n,dimensao);

for i=1:n
    for j=1:dimensao
        particulas(i,j)=limite_inferior(1,j)+(limite_superior(1,j)-limite_inferior(1,j)).*rand;
    end
end

iter=0;
itmax=100;
c1=2; 
c2=2;
omega=0.4;


while iter<itmax
  
    iter=iter+1
    
    
    for iN=1:n
        fobj=(particulas(iN,1)^2)+(particulas(iN,2)^2);
        if fobj<Pbest(iN,1)
            Pbest(iN,1)=fobj;
            xPbest(iN,:)=particulas(iN,:);
        end
        if fobj<Gbest
            Gbest=fobj;
            xGbest(1,:)=particulas(iN,:);
        end
    end
    
    
    for jN=1:n
        v(jN,:)=omega.*v(jN,:)+c1*rand(1,dimensao).*(xPbest(1,:)-particulas(jN,:))+c2*rand(1,dimensao).*(xGbest(1,:)-particulas(jN,:));

    end
    
    particulas=particulas+v;
    
    for i=1:n
        for j=1:dimensao
            if particulas(i,j)>limite_superior(1,j)
                particulas(i,j)=limite_superior(1,j);
            end
             if particulas(i,j)<limite_inferior(1,j)
                particulas(i,j)=limite_inferior(1,j);
             end
        end
    end
    
    figure(1)
    plot(particulas(:,1),particulas(:,2),'rx')
    grid on
    axis([limite_inferior(1,1) limite_superior(1,1) limite_inferior(1,2) limite_superior(1,2)])
    view(0,90)
    pause(0.001)
  
    end
    
    
