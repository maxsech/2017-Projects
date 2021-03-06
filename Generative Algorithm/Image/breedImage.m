function [child] = breedImage(parent1, parent2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function combines the dna of the two input partent images 
% ('parent1' and 'parent2') and outputs the result image as 'child'. This
% combination happens either by randomly selecting a midpoint and selecting
% one half from one parent image and one half from the second parent image and
% combining them, or by selecting random values from both parent strings
%
% INPUTS: parent1 -- First string selected from the mating pool
%         parent2 -- Second string selected from the mating pool
%         
% OUTPUTS: child -- String created by the combination process of the two
%                   parent strings. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
%Midpoint
    
bound = size(parent1, 2);

midpoint = randi([2, bound - 1]);

parent1Cut = parent1(:, 1 : midpoint);
parent2Cut = parent2(:, midpoint + 1 : bound);

child = [parent1Cut , parent2Cut];

%}


%Random
[rows, columns] = size(parent1); %Getting size of the first parent, will be the same size as the second parent

parent1Mask = logical(randi([0 1], rows, columns)); %Creating a matrix of logical values that is the same size as the parents

%The following loops will run through each value of the logical mask, and if the value is true, the corresponding position in the child is
%filled with the value from the first parent, otherwise if the child value is set to the value from the second parent
for r = 1: rows
    for c = 1: columns
        if parent1Mask(r, c)
            child(r, c) = parent1(r, c);
        else
            child(r, c) = parent2(r, c);
        end
    end
end

end
