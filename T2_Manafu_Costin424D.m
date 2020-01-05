%Manafu Costin-Mircea
%Grupa 424D
%Numarul de ordine 15

P=40; %Perioada
D=15; %Durata semnalelor[sec]
N=50; %Numar de coeficienti Fourier 
f=1/P; %Frecventa
w0=2*pi*f; %Pulsatia
rez=0.1; %Rezolutia temporala a semnalului

s1=[ones(1,D/rez),zeros(1,(P-D)/rez)]; %O perioada din semnalul dreptunghiular
t=0:rez:P; %Timpul echivalent petru o perioada
perioada=P/rez;%Cate esantioane avem intr-o perioada
semnal=repmat(s1,1,3);%Repetam semnalul initial de 3 ori

figure
plot(semnal)
title('3 perioade din semnal')
xlabel('t[s]')
ylabel('A')

%Determinam coeficientii Seriei Fourier Exponentiale
xk=zeros(1,2*N+1);
for m=-N:1:N
    for l=1:1:perioada
    xk(m+N+1)= xk(m+N+1)+semnal(l)*exp(-1i*m*w0*t(l));
    end
end

figure
stem((-N:N),abs(xk)) %Spectrul semnalului
title('Spectrul  de amplitudini al semnalului x(t)') 

s_rec=zeros(1,perioada); %Initializam semnalul pe care il vom reconstrui
for l=1:1:perioada
    for m=-N:1:N
        s_rec(l)= s_rec(l)+xk(m+N+1)*exp(1i*m*w0*t(l));
    end
end
s_rec=s_rec/perioada;%Normam semnalul reconstruit

figure
plot(real(s_rec))
hold on
plot(s1,'color','r')
title('x(t)-verde, Reconstructia folosind N coeficienti - albastru')


%Seriile Fourier sunt o unealta matematica folosita pentru a analiza
%functiile periodice descompunandu-le intr-o suma ponderata
%de functii sinusoidale componente care sunt denumite armonice.

%Numarul de termeni este finit, deci din start nu putem spune ca semnalul
%initial este aproximat la perfectiune. Insa cu cat acest numar este marit
%cu atat creste buna aproximare adica scade marja de eroare. Concluzia este
%ca am aproximat semnalul initial cu o anumita marja de eroare data de
%numarul de termeni.