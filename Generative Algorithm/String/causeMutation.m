function [mutatedChild] = causeMutation(child, mutationRate)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes the string created by the breeding process and randomly 
% changes certain characters based off a defined mutation rate 
%
% INPUTS: child -- the string created by the breeding process
%
% OUTPUTS: output -- The newly mutated child
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mutatedChild = child;
childLength = length(child); 

for i = 1 : childLength
    rando = randi([1, 100]);
    
    if rando <= mutationRate
        mutationComplete = false;
        
        while ~mutationComplete
            dna = randi([32, 122]);
    
            if dna == 32 || (dna >= 65 && dna <= 90) || (dna >= 97 && dna <= 122)
                
                mutatedChild(i) = dna;
                mutationComplete = true;
                
            end
        end
    end
end