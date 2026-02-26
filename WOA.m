close all
clear all
clc

% WOA

n=5;
dimensao=2;
limite_superior=[100 50];
limite_inferior=[-100 -25];

Gbest=inf;
xGbest=zeros(1,dimensao);

for i=1:n
    for j=1:dimensao
        part(i,j)=limite_inferior(1,j)+(limite_superior(1,j)-limite_inferior(1,j)).*rand;
    end
end

iter=0;
itmax=100;


while iter<itmax
  
    iter=iter+1
    
    a=2-iter*(2/itmax); %[0,2]
    
    for iN=1:n
        
        r1=rand();
        A=2*a*r1-a;
        C=2*r1;
        b=1;
        l=-1+(1+1)*rand(1); %[-1,1]
        p=rand();
       
        for jN=1:1:dimensao
            if(p<0.5)
                if(abs(A)<1)
                    D=abs(C*xGbest(1,jN)-part(iN,jN));
                    part(iN,jN)=xGbest(1,jN)-A*D;
                elseif(abs(A)>=1)
                        Xrand=part(randi([1,n]),:);
                        D1=abs(C*Xrand(jN)-part(iN,jN));
                        part(iN,jN)=Xrand(jN)-A*D1;
                end
          
                 elseif(p>=0.5)
                    D2=abs(xGbest(1,jN)-part(iN,jN));
                    part(iN,jN)=D2.*exp(b*l)*cos(2*pi*l)+xGbest(1,jN);
            end
        end
    end
        
    for i=1:1:n
        fobj=(part(i,1)^2+part(i,2)^2);
        
         if fobj<Gbest
            Gbest=fobj;
            xGbest(1,:)=part(i,:);
         end
    end
         
    for i=1:n
        for j=1:dimensao
            if part(i,j)>limite_superior(1,j)
                part(i,j)=limite_superior(1,j);
            end
             if part(i,j)<limite_inferior(1,j)
                part(i,j)=limite_inferior(1,j);
             end
        end
    end
    
    figure(1)
    plot(part(:,1),part(:,2),'rx')
    grid on
    axis([limite_inferior(1,1) limite_superior(1,1) limite_inferior(1,2) limite_superior(1,2)])
    view(0,90)
    pause(0.001)
end


