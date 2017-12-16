function [matingPool] = buildMatingPool(inputFitness, matingFactor , popSize)

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
%
%         matingFactor -- a value used, such as ten, that is used to
%                         multiply by the member fitness percentage to
%                         determine the number of tickets the member adds
%                         to the raffle
%
% OUTPUTS: matingPool -- Outputs the indeces that the population members
%                        add to it, not the strings themselves
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Normilizing fitness values
topFit = max(inputFitness);

normilizedFitness = inputFitness/topFit;

repeatIndicator = normilizedFitness * matingFactor;

counter = 1; %Keeps track of position in mating pool

for i = 1 : popSize
    
    %fprintf("i: %f \n", i);
    
    if ~repeatIndicator(1, i) == 0
        
        
        for a = 1 : repeatIndicator(1, i)
            %fprintf("indi: %f \n", repeatIndicator(1, i));
            
            matingPool(1, counter) = i;
            
            %fprintf("pool: %f \n", matingPool(1, counter));
            
            counter = counter + 1;
        end
        
    end
end
end