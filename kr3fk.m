%Esta funcao retorna as matrizes de transformacao do elo e a matriz de
%transformacao base-efetuador (cinematica direta).
%O parametro de entrada eh um vetor de tamanho 6 com os angulos dos elos
%de 1 a 6 respectivamente.
%Exemplo: [T01 T12 T23 T34 T45 T56 T06] = kr3fk([0 -90 90 80 0 0])
%
%Acadêmicos: Christian Mailer e Maycon Klann

% As variáveis abaixo representam os parâmetros de Denavit-Hartenberg do
% robô KUKA KR 3 R540

function [T01, T12, T23, T34, T45, T56, Tfinal] = kr3fk(theta)

%theta(1)=theta(1)+90;

%theta(2)=theta(2)+180;

theta(3)=theta(3)-90;

%theta(4)=theta(4);

%theta(5)=theta(5)+0;

%theta(6)=theta(6)+0;

% Converte os angulos para radianos
theta = theta*pi/180;

% Distancias
alfa=[90 0 90 -90 90 180]*pi/180;

a=[20 260 20 0 0 0];

d=[-345 0 0 -260 0 -(75+146.9)];

% As matrizes abaixo são as matrizes de transformação de cada elo

for c=1:6

T(:,:,c) = [cos(theta(c)), -sin(theta(c))*cos(alfa(c)), sin(theta(c))*sin(alfa(c)), a(c)*cos(theta(c));...
        sin(theta(c)), cos(theta(c))*cos(alfa(c)), -cos(theta(c))*sin(alfa(c)), a(c)*sin(theta(c));...
        0,             sin(alfa(c)),               cos(alfa(c)),                d(c);...
        0,             0,                           0,                             1];
end

T01 = T(:,:,1);
T12 = T(:,:,2);
T23 = T(:,:,3);
T34 = T(:,:,4);
T45 = T(:,:,5);
T56 = T(:,:,6);

%T06
Tfinal = T(:,:,1)*T(:,:,2)*T(:,:,3)*T(:,:,4)*T(:,:,5)*T(:,:,6);

end





