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

%Mutliplying the fitness value that ranges from 0 to 1 by the mating
%factor, this number will determine how many 'tickets' will be entered into
%the mating pool for each organisim.
repeatIndicator = int8(normilizedFitness .* matingFactor);

%Initializing the matingpool
matingPool = [];

%This for loop will run until each member of the population has had its
%tickets added to the pool. 
for i = 1 : popSize
        
    if repeatIndicator(1, i) ~= 0
        
        bound = repeatIndicator(1, i);
        
        current = ones(1, bound) * i; %Creating a matrix with a number of elements corresponding to the number of tickets for the selected member, and setting those elements to the value of the members index 
        
        matingPool = [matingPool , current]; %Adding the matrix created above to the mating pool
        
    end
end

end
