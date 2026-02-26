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
MEAN=zeros(n,dimensao);
ST=zeros(n,dimensao);

for i=1:n
    for j=1:dimensao
        particulas(i,j)=limite_inferior(1,j)+(limite_superior(1,j)-limite_inferior(1,j)).*rand;
    end
end

iter=0;
itmax=60;

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
    
    
    for zN=1:n
        for jN=1:dimensao
        MEAN(zN,jN)=(particulas(zN,jN)+xPbest(zN,jN)+ xGbest(1,jN))/3;
        end
    end
    
    for zY=1:n
        for jY=1:dimensao
        ST(zY,jY)=sqrt(((1/3)*(particulas(zY,jY)-MEAN(zY,jY))^2+(xPbest(zY,jY)-MEAN(zY,jY))^2+(xGbest(1,jY)-MEAN(zY,jY))^2));
        end
    end
     
    Z=((-2.*log(rand(n,dimensao))).^(1/2).*cos(2.*pi.*rand(n,dimensao)));
    particulas=MEAN+ST.*Z;
    
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
    pause(0.01)
end
    
