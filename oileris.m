function oileris()
clc; clear all; close all;
%GE={[2 3 4], [1 3 5], [1 2], [1 5], [2 4]}; %1PVZ
%GE={[2 3 5], [1 3 4], [1 2], [2 5], [1 4]}; %2PVZ
GE={[2 3 6], [1 3 4], [1 2], [2 5], [4 6], [1 5]}; %3PVZ

Laikinas=GE;
nelyg=0;
%RANDAME KIEK YRA NELYGINIU LAIPSNIU
for i=1:length(Laikinas)
    if rem(length(Laikinas{i}),2) == 1    
    nelyg=nelyg+1; 
    end
end
%TIKRINAME AR NERA VIRSUNIU KURIOS NETURI GRETIMU VIRSUNIU
for i=1:length(Laikinas)
    if length(Laikinas{i}) == 0
        fprintf("GRAFAS NEJUNGUS!");
        break;
    end
end
%VISI LYGINIAI LAIPSNIAI
%ARBA DU NELYGINIAI TIKTAIS TURI BUT
if nelyg == 0 | nelyg ~= 2
    fprintf("GRAFO LAIPSNIAI TURI BUTI VISI LYGINIAI ARBA DU NELYGINIAI!");

end 
    if arYraKeliasIVisus(Laikinas) == 1
        fprintf("GRAFAS JUNGUS");
    else
        fprintf("GRAFAS NEJUNGUS");
    end
    
function gretimos = gretimosVirs(vir)
    gretimos = GE{vir};
end

function ar = arSiejancioji(virs)
    test = GE{virs};
    test(end) = [];
    if length(test) == 0
        ar = 0;
    else
        ar = 1;
    end
end
kelias=[];
betKuria = randi(2,1);
disp(', pradedame nuo: ');
disp(betKuria);
tic;
ieskomKelio(1);
    function ieskomKelio(vir)
        esama = vir;
        kelias = vir;
        paskt = gretimosVirs(esama);
        paskt = paskt(1);
        while length(kelias()) ~= 7
        imame = gretimosVirs(esama);%paima 1 gretimas
        imame = imame(1);%paima j? pirma (2)
            if arSiejancioji(imame) == 1%tikrina ar ji turi dar gretimu virsuniu
                for s=1:length(GE{imame})
                    if GE{imame}(s) == esama
                    l = GE{imame};
                    GE{imame}(s) = [];%pasalina iš 2 virš?n?s (1)
                    m = GE{imame};
                    break;
                    end
                end
                    GE{esama}(1) = [];
                    kelias(end+1)=imame;
                    esama = imame;
            else
                esama = imame(2);
                continue;
            end
        end
        kelias(end+1) = paskt;
    end
kelias
SkaiciavimuTrukme = toc;
n = length(Laikinas);  % ViršUniU sk.
V = 1:n;    % ViršUniU sArašas
%U = [ 1 2; 2 3; 3 1; 1 4; 4 5; 5 2]; %1PVZ
%UV = [ 2 1; 1 3; 3 2; 2 5; 5 4; 4 1]; %1PVZ
%U = [ 1 3; 1 2; 3 2; 2 4; 4 5; 5 1]; %2PVZ 
%UV = [ 1 2; 2 3; 3 1; 1 5; 5 4; 4 2]; %2PVZ 
U = [ 1 3; 1 2; 1 6; 3 2; 4 2; 4 5; 6 5]; %3PVZ 
UV = [ 1 2; 2 3; 3 1; 1 6; 6 5; 5 4; 4 2]; %3PVZ 
m = length(U(:, 1));

Ucell = [];
for BriaunosNr = m:-1:1
    Ucell{BriaunosNr} = U(BriaunosNr, :);
end
UVcell = [];
for BriaunosNr = m:-1:1
    UVcell{BriaunosNr} = UV(BriaunosNr, :);
end
Vkor = [];
orgraf = 0;
arc=0; poz=0; Fontsize=10; lstor=1; spalva='b';
figure(1)
title('Duotasis grafas')
plotGraphVU(V, Ucell, orgraf, arc, Vkor, poz, 10, 5, spalva);
plotGraphVU(V, UVcell, 1, arc, Vkor, poz, Fontsize, 2, 'r');

disp('Skaiciavimu trukme, sekundemis:');
disp(SkaiciavimuTrukme);
esama = 1;

%TIKRINAME AR YRA KELIAS I VISAS VIRSUNES
    function yra = arYraKeliasIVisus(kuris)
        yra = 0;
        yraSuma = 0;
        buti = kuris{1};
        for v=1:length(buti)
            esamas = buti(v);
            for z=1:length(kuris{esamas})
                buti(end+1)= kuris{esamas}(z);
            end
        end
        for a=1:length(kuris)
            for o=1:length(buti)
                if buti(o) == a
                    yraSuma = yraSuma +1;
                    break;
                end
            end
        end
        if yraSuma == length(kuris)
            yra = 1;
        else
            yra = 0;
        end
    end   
end