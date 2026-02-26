close all
clear all
clc

% GWO

n=10;
dimensao=2;
limite_superior=[100 50];
limite_inferior=[-100 -25];

Galfa=inf;
xGalfa=zeros(1,dimensao);
Gbeta=inf;
xGbeta=zeros(1,dimensao);
Gdelta=inf;
xGdelta=zeros(1,dimensao);

for i=1:n
    for j=1:dimensao
        part(i,j)=limite_inferior(1,j)+(limite_superior(1,j)-limite_inferior(1,j)).*rand;
    end
end

iter=0;
itmax=25;


while iter<itmax
  
    iter=iter+1
    
    a=2-iter*(2/itmax); %[0,2]
    
    for iN=1:n
        for jN=1:1:dimensao
           
            %ALFA
            r1=rand();
            r2=rand(); 
            A1=2*a*r1-a;
            C1=2*r2;
            
            D_alfa(iN,jN)=abs(C1*xGalfa(1,jN)-part(iN,jN));
            X1=xGalfa(1,jN)-A1*D_alfa(iN,jN);
            
            %BETA
            r1=rand();
            r2=rand();
            A2=2*a*r1-a;
            C2=2*r2;
            
            D_beta(iN,jN)=abs(C2*xGbeta(1,jN)-part(i,jN));
            X2=xGbeta(1,jN)-A2*D_beta(iN,jN);
            
            %DELTA
            r1=rand();
            r2=rand();
            A3=2*a*r1-a;
            C3=2*r2;
            
            D_delta(i,jN)=abs(C3*xGdelta(1,jN)-part(iN,jN));
            X3=xGdelta(1,jN)-A3*D_delta(iN,jN);
            
            part(iN,jN)=(X1+X2+X3)/3;
        end
    end
            
            
    for i=1:1:n
        
        fobj=(part(i,1)^2+part(i,2)^2);
        
         if fobj<Galfa
            Galfa=fobj;
            xGalfa(1,:)=part(i,:);
         end
         
         if((fobj>Galfa) && (fobj<Gbeta))
             Gbeta=fobj;
             xGbeta(1,:)=part(i,:);
         end
         
         if((fobj>Galfa) && (fobj>Gbeta) && (fobj<Gdelta))
             Gdelta=fobj;
             xGdelta(1,:)=part(i,:);
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
    pause(0.01)
end
