%Este programa calcula o jacobiano das velocidades lineares e angulares.
%Antes de executa-lo, execute o programa T06_zerograu.m

%Jacobiano Vel lineares

O_n = T06(1:3,4);

Z00 = [0 ; 0 ; 1];
O0 = [0 ; 0 ; 0];
subtrai = O_n - O0;
Jv1 = cross(Z00,subtrai);

Z01 = T01(1:3,3);
O1 = T01(1:3,4);
subtrai = O_n - O1;
Jv2 = cross(Z01,subtrai);

T02 = T01*T12;
Z02 = T02(1:3,3);
O2 = T02(1:3,4);
subtrai = O_n - O2;
Jv3 = cross(Z02,subtrai);

T03 = T02*T23;
Z03 = T03(1:3,3);
O3 = T03(1:3,4);
subtrai = O_n - O3;
Jv4 = cross(Z03,subtrai);

T04 = T03*T34;
Z04 = T04(1:3,3);
O4 = T04(1:3,4);
subtrai = O_n - O4;
Jv5 = cross(Z04,subtrai);

T05 = T04*T45;
Z05 = T05(1:3,3);
O5 = T05(1:3,4);
subtrai = O_n - O5;
Jv6 = cross(Z05,subtrai);

%Jacobiano Vel angulares - p1 a p6 = 1 ->juntas rotativas

%Jw = [p1Z0  p2Z1  p3Z2  p4Z3  p5Z4  p6Z5]
%Jw = [Z0  Z1  Z2  Z3  Z4  Z5]

% Os valores de Z foram calculares anteriormente
%Z0 = Z00
%Z1 = Z01
%Z2 = Z02
%Z3 = Z03
%Z4 = Z04
%Z5 = Z05

%Jacobiano

Jacobiano = [Jv1 Jv2 Jv3 Jv4 Jv5 Jv6; Z00 Z01 Z02 Z03 Z04 Z05];
