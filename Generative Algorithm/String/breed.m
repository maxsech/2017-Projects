function [child] = breed(parent1, parent2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function combines the dna of the two input partent strings 
% ('parent1' and 'parent2') and outputs the result string as 'child'. This
% combination happens either by randomly selecting a midpoint and selecting
% one half from one parent string and one half from the second parent string and
% combinging them, or by selecting random values from both parent strings
%
% INPUTS: parent1 -- First string selected from the mating pool
%         parent2 -- Second string selected from the mating pool
%         
% OUTPUTS: child -- String created by the combination process of the two
%                   parent strings. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Midpoint

%{
    
bound = length(parent1);

midpoint = randi([2, bound - 1]);


parent1Template = zeros(1, bound);
parent2Template = zeros(1, bound);

for i = 1: midpoint %parent1
    parent1Template(1, i) = 1;
end

for i = 0: (bound - midpoint) - 1 %parent2
    parent2Template(1, end - i) = 1;
end

parent1Cut = logical(parent1Template);
parent2Cut = logical(parent2Template);

child = [parent1(parent1Cut), parent2(parent2Cut)];

%}

%Random

bound = length(parent1);

parent1Template = zeros(1, bound);

for i = 1: bound %parent1
    parent1Template(1, i) = randi([1,2]) - 1;
    
end

parent1Cut = logical(parent1Template);

for i = 1: bound %breeding
    if(parent1Cut(i))
        child(1, i) = parent1(i);
    else
        child(1, i) = parent2(i);
    end
    
end
end