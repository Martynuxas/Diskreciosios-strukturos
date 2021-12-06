function multiOil()
clc; clear all; close all;
%GE={[2 3 4], [1 3 5], [1 2], [1 5], [2 4]}; %1PVZ
%GE={[2 3 5], [1 3 4], [1 2], [2 5], [1 4]}; %2PVZ
%GE={[ 2 ], [ 1 3 ], [ 2 ]}; %3PVZ
%GE ={[2 4 5 7] [1 3 6] [2 6] [1 5] [1 4] [2 3] [1]};  %4PVZ 
%GE = {[2 4],[1],[5],[1],[3 7],[],[5]}; %5PVZ dest
%GE = {[4],[5],[4],[1 3],[2]}; %6PVZ dest
GE = {[2 4],[1],[5],[1],[3 7],[],[5],[10],[],[8]}; %7PVZ
Laikinas = GE;
k=1;
buta =[];
gretimos = [];
kelias = [];
virsune = [];
tic;

turimos = turimosVirsunes(GE);

while length(kelias) <= length(turimos)
kuria = kuriaVirsuneLankytiDabar(turimos, kelias);
if kuria == 0
    break;
end
rastiKelia(GE,kuria);
end
    function tureti = turimosVirsunes(graf)
        kiekis = [];
        for t=1:length(graf)
            if length(graf{t}) ~= 0
                kiekis(end+1) = t;
            end
        end  
        tureti = kiekis;
    end
    function kuria = kuriaVirsuneLankytiDabar(turimos, kelias)
        kuria = 0;
        for q=1:length(turimos) % 1 2 3 4 6
            buvo = 0;
            for l=1:length(kelias) % 1 4 3
                if turimos(q) == kelias(l)
                    buvo = 1;
                end
            end
            %tikrinam ar nebuvo rade, ir ar nelyginis laipsnis
            if buvo == 0 && rem(length(Laikinas{turimos(q)}),2) == 1
            kuria = turimos(q);
            break;
            end
        end
        disp('NER KUR EIT');
        return ;
    end
disp('Skaiciavimu trukme, sekundemis:');
disp(toc);
    function rastiKelia(grafas, kuriVirsune)
        einVirsune = kuriVirsune;
        disp('Pradedam nuo:');
        disp(einVirsune);
        detiKelia(einVirsune);%ikelia i kelia
            while yraGretimuVirsuniu(grafas, einVirsune)%jei turi gretima virsune ir yra ne tiltas
                virsunes = gretimosVirsunes(grafas, einVirsune);%randa gretimas virsunes
                k=1;
                virsune = virsunes(k);%paima pirma gretima virsune
                if arSiejancioji(grafas, einVirsune, virsune) == 0
                    while arSiejancioji(grafas, einVirsune, virsune) == 1
                    k=k+1;
                        if k > length(grafas{virsune})
                            k = k-1;
                            break;
                        end
                    virsune = virsunes(k); 
                    end
                end
                
                detiKelia(virsune);%ikelia ja i kelia
                grafas = salintiBriaunaIsGrafo(grafas, einVirsune, virsune);% briauna istrina
            einVirsune = virsune;
            end
            kelias
    end
    function Laikinas = salintiBriaunaIsGrafo(grafas, einVirsune, virsune)
        Laikinas = grafas;
        for r=1:length(grafas{einVirsune})
            if Laikinas{einVirsune}(r) == virsune
                Laikinas{einVirsune}(r) = [];
                break;
            end
        end
        for q=1:length(Laikinas{virsune})
            if Laikinas{virsune}(q) == einVirsune
               Laikinas{virsune}(q) = [];
               break;
            end
        end
    end
    function gret = gretimosVirsunes(grafas, virs)
        gret = grafas{virs};
    end
    function turi = yraGretimuVirsuniu(grafas, einVirsune)
        if grafas{einVirsune} ~= 0
            turi = 1;
        else
            turi = 0;
        end
    end
    function detiKelia(einVirsune)
        kelias(end+1) = einVirsune;
    end
%------------------------TIKRINIMAS AR BRIAUNA SIEJAN?IOJI-----------------
    function arSie = arSiejancioji(grafas, virsA, virsB)
        for r=1:length(grafas{virsA})
            if grafas{virsA}(r) == virsB
                grafas{virsA}(r) = [];
                break;
            end
        end
        for q=1:length(grafas{virsB})
            if grafas{virsB}(q) == virsA
               grafas{virsB}(q) = [];
               break;
            end
        end
         arSie = arJungus(grafas);
    end
    function ar = arJungus(grafas)
        buta = [];
        gretimos = [];
        t = 1;
        while isempty(grafas{t})
            if t == length(grafas)
                break;
            end
            t= t+1;
        end
        paieskaPlatyn(grafas, t);    
        kiekVir = 0;
        for z=1:length(grafas)
            for a=1:length(gretimos)
                if gretimos(a) == z
                kiekVir = kiekVir +1;
                break;
                end
            end
        end
        if kiekVir == kiekGrafasTuriNetusciu(grafas)
            ar = 1;
        else
            ar = 0;
        end
    end
    function paieskaPlatyn(grafas, k)
        if arJauButa(k) == 1
            return;
        end
        buta(end+1)=k;
        for l=1:length(grafas{k})
        eitiSudeti(grafas, grafas{k}(l));
        paieskaPlatyn(grafas, grafas{k}(l));
        end
    end
    function tiek = kiekGrafasTuriNetusciu(grafas)
        tiek = 0;
        for s = 1:length(grafas)
            if length(grafas{s}) ~=0
                tiek = tiek +1;
            end
        end
    end
%------------------------TIKRINIMAS AR BRIAUNA SIEJAN?IOJI-----------------
    function gretimosVirs(grafas, virs)
        for i=1:length(grafas{virs})
        gretimos(end+1) = grafas{virs}(i);
        end
    end
    function eitiSudeti(grafas, virs)
        gretimosVirs(grafas, virs);
    end
    function yra = arJauButa(virs)
        yra=0;
        for m=1:length(buta)
            if virs == buta(m)
            yra = 1;
            end
        end
    end
end