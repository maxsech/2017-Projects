function [fitnessValues] = calculateFitness(inputPopulation, targetString, popSize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function checks how many characters the random string
% has in common with the target string. This is dependent on 
% both the position and the character itself. The fitness score
% is then looked at as a percentage to properly assess the fitness.
%
% INPUTS: inputPopulation -- the input is the output of the build
%                            population function (the 200 random 
%                            cell array strings generated from before)
%
%         targetString -- The target string that the function will compare
%                         the input to to calculate a fitness value.
%
% OUTPUTS: fitnessValues -- outputs an array containing the fitness
%                           values (percent fitenss) of all 200 members 
%                           of the population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

targetLength = length(targetString);

match = zeros(1, targetLength);

fitnessValues = zeros(1, popSize);

for i = 1:popSize
    curentOrganism = inputPopulation{1, i};
    
    for a = 1: targetLength
        match(1, a) = strcmp(curentOrganism(1,a), targetString(1,a));
        %fprintf("%f , %f \n", a, targetLength);
    end
    
    matchPercent = sum(match) / targetLength;
    
    %fprintf("%f \n", match);
    
    fitnessValues(1, i) = matchPercent;
end
end