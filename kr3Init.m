%Esta funcao retorna a variavel de inicializacao do robo KUKA KR3 R540 na
%biblioteca Robotics Toolbox, de Peter Corke.
%O parametro de entrada eh um valor de comprimento do efetuador do robo.
%Exemplo: KUKA = kr3Init(146.9)
%
%Acadêmicos: Christian Mailer e Maycon Klann

function KUKA = kr3Init(comprimento_efetuador)

%Origem da garra com ralação à flange
efetuador=[0 0 comprimento_efetuador];

% Angulos limites das juntas convertidos em radianos
lim_a1=degtorad(170);
sup_a2=degtorad(50);
inf_a2=degtorad(-170);
sup_a3=degtorad(155);
inf_a3=degtorad(-110);
lim_a4=degtorad(175);
lim_a5=degtorad(120);
lim_a6=degtorad(350);

%DH
elo1 = Link('d', -345, 'a', 20, 'alpha', pi/2, 'offset', 0, 'qlim', [-lim_a1 lim_a1]);
elo2 = Link('d', 0, 'a', 260, 'alpha', 0, 'offset', 0, 'qlim', [inf_a2 sup_a2]);
elo3 = Link('d', 0, 'a', 20, 'alpha', pi/2, 'offset', -pi/2, 'qlim', [inf_a3 sup_a3]);
elo4 = Link('d', -260, 'a', 0, 'alpha', -pi/2, 'offset', 0, 'qlim',[-lim_a4 lim_a4]);
elo5 = Link('d', 0, 'a', 0, 'alpha', pi/2, 'offset', 0, 'qlim',[-lim_a5 lim_a5]);
elo6 = Link('d', -(75+comprimento_efetuador), 'a',  0, 'alpha', pi, 'offset', 0, 'qlim',[-lim_a6 lim_a6]);
DH = [elo1;elo2;elo3;elo4;elo5;elo6];

% Cria o SerialLink com nome KUKA
KUKA = SerialLink(DH, 'manufacturer', 'KUKA', 'name', 'KR 3 R540', 'tool', efetuador);

end


