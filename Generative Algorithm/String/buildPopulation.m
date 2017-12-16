function [out] = buildPopulation(popSize ,targetSize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function creates 200 random strings that match the  
% length of the target phrase.
%
% INPUTS: popSize -- The population size is the number of 
%                    members within the population consisting 
%                    of a single string each.
%
%         targetSize -- the length of the target phrase that 
%                       we are trying to each.
%         
% OUTPUTS: out -- output contains all 200 strings/
%                 population members each within a single cell array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:popSize
    organismRaw = zeros(1, targetSize);
    counter = 1;

    while ~isempty(find(organismRaw == 0, 1))
        
        dna = randi([32, 122]);
    
        if dna == 32 || (dna >= 65 && dna <= 90) || (dna >= 97 && dna <= 122)
        
            organismRaw(1, counter) = dna;
        
            counter = counter + 1;
        end
    end

    organism = string(char(organismRaw));
    
    population(1, i) = organism;
end

out = cellstr(population);
end