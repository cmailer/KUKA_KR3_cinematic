%Acad�micos: Christian Mailer e Maycon Klann

% As vari�veis abaixo representam os par�metros de Denavit-Hartenberg do
% rob� KUKA KR 3 R540
c1=sym('c1'); %vari�vel para cosseno de theta 1
s1=sym('s1'); %vari�vel para seno de theta 1
c2=sym('c2'); %vari�vel para cosseno de theta 2              <-----------------
s2=sym('s2'); %vari�vel para seno de theta 2                 <-----------------
c3=sym('c3'); %vari�vel para cosseno de theta 3              <-----------------
s3=sym('s3'); %vari�vel para seno de theta 3                 <-----------------
cx=sym('cx'); %vari�vel para cosseno de theta 4              <-----------------
sx=sym('sx'); %vari�vel para seno de theta 4                 <-----------------
c5=sym('c5'); %vari�vel para cosseno de theta 5
s5=sym('s5'); %vari�vel para seno de theta 5
c6=sym('c6'); %vari�vel para cosseno de theta 6
s6=sym('s6'); %vari�vel para seno de theta 6

a1=sym('a1'); %vari�vel para a dist�ncia a1
a2=sym('a2'); %vari�vel para a dist�ncia a2
a3=sym('a3'); %vari�vel para a dist�ncia a3
d1=sym('d1'); %vari�vel para a dist�ncia d1
d4=sym('d4'); %vari�vel para a dist�ncia d4
d6=sym('d6'); %vari�vel para a dist�ncia d6

% As matrizes abaixo s�o as matrizes de transforma��o de cada elo

T01=[c1 0 s1 a1*c1; s1 0 -c1 a1*s1; 0 1 0 -d1; 0 0 0 1];
T12=[c2 -s2 0 a2*c2; s2 c2 0 a2*s2; 0 0 1 0; 0 0 0 1];
T23=[s3 0 -c3 a3*s3; -c3 0 -s3 -a3*c3; 0 1 0 0; 0 0 0 1];
T34=[cx 0 -sx 0; sx 0 cx 0; 0 -1 0 -d4; 0 0 0 1];
T45=[c5 0 s5 0; s5 0 -c5 0; 0 1 0 0; 0 0 0 1];
T56=[c6 s6 0 0; s6 -c6 0 0; 0 0 -1 -d6; 0 0 0 1];

% A matriz abaixo � a matriz de transforma��o do sistema de 
% coordenadas da flange ao sistema de coordenadas inercial

T06=T01*T12*T23*T34*T45*T56;




