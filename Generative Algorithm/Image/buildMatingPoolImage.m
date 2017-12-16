function [matingPool] = buildMatingPoolImage(inputFitness,matingFactor, popSize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes the fitness scores from the previous function
% and creates a sort of raffle by weighting the percentages so that
% the "fit" members will be selected more often that the nonfit members
% leading to a random weighted mating pool that is normalized with the 
% highest fitness value in a population being equivalent to 1.
%
% INPUTS: inputFitness -- the input is the percentage fitness found for
%                         found for each member of the population with the
%                         calculateFitness function
%         matingFactor -- a value used, such as ten, that is used to
%                         multiply by the member fitness percentage to
%                         determine the number of tickets the member adds
%                         to the raffle
% OUTPUTS: matingPool -- Outputs the indeces that the population members
%                        add to it, not the values of the pixels themselves
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Normilizing fitness values
topFit = max(inputFitness);

normilizedFitness = inputFitness/topFit;

repeatIndicator = int8(normilizedFitness .* matingFactor);

matingPool = [];


for i = 1 : popSize
        
    if repeatIndicator(1, i) > matingFactor/2
        
        bound = repeatIndicator(1, i);
        
        current = ones(1, bound) * i;
        
        matingPool = [matingPool , current];
        
    end
end

end