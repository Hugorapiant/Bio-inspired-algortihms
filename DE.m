close all
clear all
clc


n=10;
dimensao=2;
limite_superior=[100 50];
limite_inferior=[-100 -25];


for i=1:n
    for j=1:dimensao
        particulas(i,j)=limite_inferior(1,j)+(limite_superior(1,j)-limite_inferior(1,j)).*rand;
    end
end

iter=0;
itmax=100;
F=0.9;
CR=0.6;

while iter<itmax
  
    iter=iter+1
   
    for iN=1:n 
        r1=iN;
        r2=iN;
        r3=iN;
     while(r1==r2 && r1==r3 && r1==iN && r2==r3 && r2==iN && r3==iN)
        r1=randi([1,n]);
        r2=randi([1,n]);
        r3=randi([1,n]);
     end
     
        patr1(iN,:)=particulas(r1,:);
        patr2(iN,:)=particulas(r2,:);
        patr3(iN,:)=particulas(r3,:);
        %MUTAÇAO
        V(iN,:)=patr1(iN,:)+F*(patr2(iN,:)-patr3(iN,:));
    
    Rand1=rand(1);
    Rand2=randi([1,dimensao]);
    
        %CRUZAMENTO
       for jN=1:1:dimensao
           
        if((Rand1<=CR) || (jN==Rand2))
            U(iN,:)=V(iN,:);
        else 
            U(iN,:)=particulas(iN,:);
        end
      end
    end
    
    %SELEÇAO
       
    for zN=1:n
        fobj=(particulas(zN,1)^2)+(particulas(zN,2)^2);
        fobjU=(U(zN,1)^2+U(zN,2)^2);
        
        if(fobjU<=fobj)
            particulas(zN,:)=U(zN,:);
        else
            particulas(zN,:)=particulas(zN,:);
        end
    end
    
   
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
    
    
