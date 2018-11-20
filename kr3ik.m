%Retorna a cinematica inversa com base na postura do efetuador e seu
%comprimento.
%Deve-se primeiro capturar as matrizes de transformacao utilizando-se a
%funcao kr3fk. Utilize "help kr3fk" para mais informacoes.
%Exemplo: combinacao = kr3ik(146.9,T01,T12,T23,T34,T45,T56,T06)
%
%Acadêmicos: Christian Mailer e Maycon Klann

function [combinacao] = kr3ik(comprimento_efetuador,T01,T12,T23,T34,T45,T56,T06)

%Thetas atuais
theta = [0 -90 90 80 0 0];

% Angulos limites das juntas convertidos em radianos
lim_a1=degtorad(170);
sup_a2=degtorad(50);
inf_a2=degtorad(-170);
sup_a3=degtorad(155);
inf_a3=degtorad(-110);
lim_a4=degtorad(175);
lim_a5=degtorad(120);
lim_a6=degtorad(350);

%os ângulos theta 4 à 6 são retirados da matriz de rotação R36 
T36 = T34*T45*T56;

% Por problemas de singularidade, algumas posicoes irao dar erro pois os
% elementos da matriz sao nulos. Sera preciso contornar esse problema
% fazendo-se a coleta de dados de outro ponto da matriz.

% Primeiro grupo de theta4, theta5 e theta6
theta4(1) = atan2(-(T36(2,3)),-(T36(1,3)));
theta5(1) = atan2(sqrt((T36(1,3))^2 + (T36(2,3))^2), -(T36(3,3)));
theta6(1) = atan2(-(T36(3,2)),-(T36(3,1)));

% Segundo grupo de theta4, theta5 e theta6
theta4(2) = atan2((T36(2,3)),(T36(1,3)));
theta5(2) = atan2(-sqrt((T36(1,3))^2 + (T36(2,3))^2), -(T36(3,3)));
theta6(2) = atan2((T36(3,2)),(T36(3,1)));

%fprintf('\ntheta14(1) e theta4(2) %i e %i',theta4(1),theta4(2));

%fprintf('\ntheta15(1) e theta5(2) %i e %i',theta5(1),theta5(2));

%fprintf('\ntheta16(1) e theta6(2) %i e %i \n',theta6(1),theta6(2));

%Para o cálculo dos ângulos de theta 1 à 3 foi utilizado o método
%geométrico e para isto necessita-se de alguns cálculos base
d6=(75+comprimento_efetuador);

P0W = T06(1:3,4) - T06(1:3,1:3)*[0;0;d6];

P1W = P0W - T01(1:3,4);

hip = sqrt(260^2 + 20^2);

%G = atan(260/20);

C = atan(20/260);

B = acos((norm(P1W)^2 - 260^2 - hip^2)/ (-2*260*hip));

E = acos((-norm(P1W)^2 - 260^2 + hip^2)/ (-2*260*norm(P1W)));

D = atan2(P1W(2,1),P1W(1,1));

% Ângulos theta 1
theta1(1) = atan2(P0W(2,1),P0W(1,1));
theta1(2) = atan2(-P0W(2,1),-P0W(1,1));

%fprintf('theta1(1) e theta1(2) %i e %i',theta1(1),theta1(2));

% Ângulos theta 2
theta2(1) = D + E;
theta2(2) = -D + E;
theta2(3) = -D - E;
theta2(4) = D - E;

%fprintf('\ntheta2(1), theta2(2), theta2(3) e theta2(4): %i, %i, %i e %i',theta2(1),theta2(2),theta2(3),theta2(4));

% Ângulos theta 3
theta3(1) = pi - B + C;
theta3(2) = pi - B - C;
theta3(3) = -pi + B - C;
theta3(4) = -pi + B + C;

%fprintf('\ntheta3(1), theta3(2), theta3(3) e theta3(4): %i, %i, %i e %i',theta3(1),theta3(2),theta3(3),theta3(4));

%Variavel que armazena a linha da matriz combinacoes
linha = 1;

%Vetor que armazena os valores de cada solucao
sequencia = [0,0,0,0,0,0];

%Matriz que armazena combinacoes encontradas
combinacoes = [0,0,0,0,0,0];

%FAZ O CHECK PARA VALOR POSITIVO DE THETA1
    if (theta1(1) > -lim_a1) && (theta1(1) < lim_a1)
        sequencia(1)=theta1(1);
        %disp('theta1(1) ok')
        
        for k=1:2
            if (theta2(k) > inf_a2) && (theta2(k) < sup_a2)
                sequencia(2)=theta2(k);
                
                for m=1:2
                    if (theta3(m) > inf_a3) && (theta3(m) < sup_a3)
                        sequencia(3)=theta3(m);
                        
% AQUI FAZ O CHECK DO THETA 4 AO THETA 6                        
for j=1:2
    
    if (theta4(j) > -lim_a4) && (theta4(j) < lim_a4)
        sequencia(4)=theta4(j);
        
        if (theta5(j) > -lim_a5) && (theta5(j) < lim_a5)
            sequencia(5)=theta5(j);
    
            if (theta6(j) > -lim_a6) && (theta6(j) < lim_a6)
                %disp('Combinacao encontrada')
                sequencia(6) = theta6(j);
                combinacoes(linha,:) = sequencia;
                linha=linha+1;
            end
        end
    
    end
end
% ENCERRA O CHECK PARA OS VALORES DE THETA 4 A THETA 6
                        
                    end
                    
                end
                
            end
            
        end
        
        
    end
    % ENCERRA O CHECK PARA O VALOR POSITIVO DE THETA 1
    
    
   % FAZ O CHECK PARA O VALOR NEGATIVO DE THETA 1 
   if (theta1(2) > -lim_a1) && (theta1(2) < lim_a1)
        sequencia(1)=theta1(1);
        
        %disp('theta1(2) ok')
        
        for k=3:4
            if (theta2(k) > inf_a2) && (theta2(k) < sup_a2)
                sequencia(2)=theta2(k);
                
                
                for m=3:4
                    if (theta3(m) > inf_a3) && (theta3(m) < sup_a3)
                        sequencia(3)=theta3(m);
                        
                        
% AQUI FAZ O CHECK DO THETA 4 AO THETA 6                        
for j=1:2
    
    if (theta4(j) > -lim_a4) && (theta4(j) < lim_a4)
        sequencia(4)=theta4(j);
        
        if (theta5(j) > -lim_a5) && (theta5(j) < lim_a5)
            sequencia(5)=theta5(j);
    
            if (theta6(j) > -lim_a6) && (theta6(j) < lim_a6)
                %disp('Combinacao encontrada')
                sequencia(6) = theta6(j);
                combinacoes(linha,:) = sequencia;
                linha=linha+1;
            end
        end
    
    end
end

% ENCERRA O CHECK PARA OS VALORES DE THETA 4 A THETA 6
                        
                    end
                    
                end
                
            end
            
        end
       
    end
      % ENCERRA O CHECK PARA O VALOR NEGATIVO DE THETA 1 

% Checa se foram encontradas solucoes
if (linha == 1)
    disp('Nenhuma solucao foi encontrada');
    combinacao = 0;
    
else
    fprintf('\nForam encontradas %i solucoes!',linha-1);
    
    combinacoes = combinacoes*180/pi
    
    %disp('A melhor eh: ')
    
    % FAZ A DIFERENCA DE ANGULOS ENTRE AS SOLUCOES
    for c=1:linha-1
        
        deltaTOTAL(c) = 0;

        for j=1:6
            %SOMATORIO DA DIFERENCA
           deltaTOTAL(c) = deltaTOTAL(c) + abs(combinacoes(c,j) - theta(j)); 
        end
        
    end
    
    deltaMenor(1,1) = 0;
    deltaMenor(1,2) = 0;
    
    for c=1:linha-1
        % CLASSIFICA O MENOR SOMATORIO
        if (deltaTOTAL(c) < deltaMenor(1,1)) || (c == 1)
            deltaMenor(1,1) = deltaTOTAL(c);
            deltaMenor(1,2) = c;
            
            %RETORNA A MELHOR COMBINACAO
            combinacao = combinacoes(deltaMenor(1,2),:);
            
        end
        
    end
    
end

end
            
