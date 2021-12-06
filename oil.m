function oil()
clc; clear all; close all;
GE={[2 3 4], [1 3 5], [1 2], [1 5], [2 4]}; %1PVZ
%GE={[2 3 5], [1 3 4], [1 2], [2 5], [1 4]}; %2PVZ
%GE={[3 2 6], [1 3 4], [1 2 7], [2 5], [4 6], [1 5], [3 8], [ 7 ]}; %3PVZ
%GE={[ 2 ], [ 1 3 ], [ 2 ]}; %4PVZ
%GE ={[2 4 5 7] [1 3 6] [2 6] [1 5] [1 4] [2 3] [1]};
tikrinamLaipsniusGrafo(GE);
k=1;
nelyg=0;
buta =[];
gretimos = [];
kelias = [];
virsune = [];
tic;
rastiKelia(GE);
kelias
disp('Skaiciavimu trukme, sekundemis:');
disp(toc);
    function rastiKelia(grafas)
        einVirsune = parinktiPradineVirsune(grafas);%paima pradine virsune 1
        disp('Pradedam nuo:');
        disp(einVirsune);
        detiKelia(einVirsune);%ikelia i kelia
        while ~isempty(grafasNeTuscias(grafas)) %kol yra likus virsune
            if yraGretimuVirsuniu(grafas, einVirsune)%jei turi gretima virsune ir yra ne tiltas
                virsunes = gretimosVirsunes(grafas, einVirsune);%randa gretimas virsunes
                k=1;
                virsune = virsunes(k);%paima pirma gretima virsune
                if arSiejancioji(grafas, einVirsune, virsune) == 0
                    while arSiejancioji(grafas, einVirsune, virsune) == 0
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
            else
                return;
            end
            einVirsune = virsune;
        end
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
    function prad = parinktiPradineVirsune(grafas)
        rado = 0;
        while rado ~= 1
            rastas = randi(length(grafas),1);
            koks = koksVirsunesLaipsnis(grafas, rastas);
            if rem(koks,2) == 1
                prad = rastas;
                rado = 1;
                break;
            end
        end
    end
    function koks = koksVirsunesLaipsnis(grafas, virs)
        koks = length(grafas{virs});
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
    function tuscias = grafasNeTuscias(grafas)
        for l=1:length(grafas)
            if grafas{l} ~= 0
                tuscias = 0;
                break;
            else
                continue;
            end
        end
        tuscias = 1;
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

%--------------------------TIKRINIMAS AR JUNGUS----------------------------
    function tikrinamLaipsniusGrafo(grafas)
        nelyg = 0;
        %RANDAME KIEK YRA NELYGINIU LAIPSNIU
        for v=1:length(grafas)
            if rem(length(grafas{v}),2) == 1    
            nelyg=nelyg+1; 
            end
        end
        %TIKRINAME AR NERA VIRSUNIU KURIOS NETURI GRETIMU VIRSUNIU
        for c=1:length(grafas)
            if isempty(grafas{c}) == 0
            disp('GRAFAS NEJUNGUS!');
            return
            end
        end
        %VISI LYGINIAI LAIPSNIAI
        %ARBA DU NELYGINIAI TIKTAIS TURI BUT
        if nelyg ~= 0 & nelyg ~= 2
            disp('GRAFO LAIPSNIAI TURI BUTI VISI LYGINIAI ARBA DU NELYGINIAI!');
            return
        end 
    end
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
arJungus(GE);
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
            disp('GRAFAS NEJUNGUS!');
        end
    end
%----------------------BAIGTA TIKRINIMAS AR JUNGUS-------------------------
end