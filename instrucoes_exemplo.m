% Abaixo seguem as instrucoes/exemplos de como usar o codigo criado.
%
%Acadêmicos: Christian Mailer e Maycon Klann

clc

% Para iniciar os parametros do robo na biblioteca robotics toolbox,
% utilizar o comando init abaixo:
KUKA = kr3Init(146.9); % 146.9 eh o comprimento do efetuador

% Para calcular a cinematica direta de um determinado angulo em graus,
% utilizar a funcao abaixo:
[T01 T12 T23 T34 T45 T56 T06] = kr3fk([50 -100 20 140 100 300]);
% Sao retornadas todas as matrizes de transformacao dos elos, sendo a T06 a
% matriz final
disp('Cinematica direta: ');
CinDireta = T06

% Para calcular as solucoes possiveis da cinematica inversa, utiliza-se a
% funcao abaixo que toma como argumentos o comprimento do efetuador e as
% matrizes de transformacao dos elos
disp('Cinematica inversa: ');
combinacao = kr3ik(146.9,T01,T12,T23,T34,T45,T56,T06);
% A resposta combinacao ira conter a melhor combinacao.
disp('Melhor combinacao: ');
combinacao

% Para calcular a velocidade no efetuador, utilizar a funcao abaixo que
% tem como argumentos os angulos das juntas em graus e velocidade das
% juntas em rad/s. O retorno eh dado por uma coluna cujos tres primeiros
% valores representam a velocidade em mm/s e os tres ultimos representam as
% velocidades em rad/s.
disp('Velocidade no efetuador:');
velocidade_efetuador = kr3fj([0 -90 90 80 1 0],[1 1 1 1 1 1])

% Para calcular a velocidade nas juntas, a funcao abaixo pode ser utilizada
% que toma como argumentos os angulos das juntas em graus e velocidade do
% efetuador em mm/s e rad/s (em forma de vetor). O retorno eh dado por uma 
% coluna cujos valores representam a velocidade das juntas em rad/s.
disp('Velocidade nas juntas:');
velocidade_juntas = kr3ij([0 -90 90 80 1 0],transpose(velocidade_efetuador))

% Para plotar o robo graficamente, basta utilizar o comando abaixo depois
% de fazer o init dos parametros de Denavit Hartenberg:
KUKA.teach([0 -90 90 80 1 0]*pi/180, 'notiles', 'floorlevel', 1, 'lightpos', [1000 -1000 0])
% Inverte e restringe os eixos de forma a demonstrar o robo corretamente
set(gca, 'ZDir', 'reverse','ZLim', [-1000 500], 'YLim', [-1200 1200], 'XLim', [-1000 1000]);

