%De acordo com o manual do robo kuka kr3 o workspace � formado pela rota��o
%das juntas A2, A3 e A5 (vista lateral fig. 4-2, enquanto que a vista
%superior do workspace do robo � formada pela rota��o da junta A1 (fig.
%4-3). Deste modo foi modelado atrav�s da rela��o de DH um robo KUKA e
%atrav�s da matriz de transforma��o que relaciona a base e a 
%ponta da flange foi poss�vel retirar os valores de x, y e z poss�veis.

%valor correspondente ao n�mero de elementos - quanto maior mais preciso o
%resultado, por�m maior o tempo de processamento
k=20;

%Dist�ncias conforme manual disponibilizado
a1=20;
a2=260;
a3=20;
d1=345;
d4=260;
d6=75+146.9;

%range para todos os �ngulos das juntas
theta1 = linspace(deg2rad(-170),deg2rad(170),k); 
theta2 = linspace(deg2rad(50),deg2rad(-170),k);    %invers�o de sinais para plotagem correta 
theta3 = linspace(deg2rad(155),deg2rad(-110),k);   %invers�o de sinais para plotagem correta 
theta5 = linspace(deg2rad(-120),deg2rad(120),k);   %invers�o de sinais para plotagem correta 

%valor dos �ngulos formados pelos thetas
c1=cos(theta1); s1=sin(theta1);
c2=cos(theta2); s2=sin(theta2);
c3=cos(theta3); s3=sin(theta3);
c5=cos(theta5); s5=sin(theta5);


sx=0;
cx=1;
s6=0;
c6=1;

%Matriz formada contendo os pontos de todas as combina��es de �ngulos e
%dist�ncias (a1, a2...) a fim de formar um espa�o tridimensional -
%workspace - coluna 1 = x, 2 = y , 3 = z.
matrix=zeros(k^4,3); 

%Contador para a altera��o de linha
i=1;

for v=1:k  %values for theta1

    for b=1:k  %values for theta2
        
        for n=1:k  %values for theta3
            
            for m=1:k  %values for theta5
                
                % Equa��es adquiridas com DH
                matrix(i,1)=a1*c1(1,v) + d6*(c5(1,m)*(c1(1,v)*c2(1,b)*c3(1,n) - c1(1,v)*s2(1,b)*s3(1,n)) - s5(1,m)*(s1(1,v)*sx + cx*(c1(1,v)*c2(1,b)*s3(1,n) + c1(1,v)*c3(1,n)*s2(1,b)))) + d4*(c1(1,v)*c2(1,b)*c3(1,n) - c1(1,v)*s2(1,b)*s3(1,n)) + a2*c1(1,v)*c2(1,b) + a3*c1(1,v)*c2(1,b)*s3(1,n) + a3*c1(1,v)*c3(1,n)*s2(1,b);
                matrix(i,2)=a1*s1(1,v) + d6*(c5(1,m)*(c2(1,b)*c3(1,n)*s1(1,v) - s1(1,v)*s2(1,b)*s3(1,n)) + s5(1,m)*(c1(1,v)*sx - cx*(c2(1,b)*s1(1,v)*s3(1,n) + c3(1,n)*s1(1,v)*s2(1,b)))) + d4*(c2(1,b)*c3(1,n)*s1(1,v) - s1(1,v)*s2(1,b)*s3(1,n)) + a2*c2(1,b)*s1(1,v) + a3*c2(1,b)*s1(1,v)*s3(1,n) + a3*c3(1,n)*s1(1,v)*s2(1,b);
                matrix(i,3)=a2*s2(1,b) - d1 + d4*(c2(1,b)*s3(1,n) + c3(1,n)*s2(1,b)) + d6*(c5(1,m)*(c2(1,b)*s3(1,n) + c3(1,n)*s2(1,b)) + cx*s5(1,m)*(c2(1,b)*c3(1,n) - s2(1,b)*s3(1,n))) - a3*c2(1,b)*c3(1,n) + a3*s2(1,b)*s3(1,n);
                      
                i=i+1;
            end
        end
    end
end

%subplot(2,1,1);
% scatter(-matrix(1:k^3,2),-matrix(1:k^3,3),10);
% title('Vista lateral do workspace do rob� KUKA');
%subplot(2,1,2);
scatter3(matrix(:,1), matrix(:,2) ,matrix(:,3));
title('Vista espacial do workspace do rob� KUKA');







