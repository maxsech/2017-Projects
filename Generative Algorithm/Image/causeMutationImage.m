function [mutatedChild] = causeMutationImage(child, mutationRange, mutationRate)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes the image created by the breeding process and increases or
% decreases the brightness of a pixel withing mutationRange or have a one
% in four chance to ranomly mutate.
%
% INPUTS: child -- the string created by the breeding process
%
%         mutationRange -- The range by which the brightness of a
%                          particular pixel will be changed.
%
%         randomMutationRate -- The rate by which a pixel will undergo a
%                               completely random mutation.
%                               
%
% OUTPUTS: output -- The newly mutated child
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mutatedChild = child ;
completelyRandomChance = 25;

[childrows, childcolumns] = size(child);

for r = 1 : childrows
    for c = 1 : childcolumns
        rando1 = randi([1, 100]);

        if rando1 <= mutationRate
            
            rando2 = randi([1, 100]);

            if rando2 <= completelyRandomChance
                    dna = randi([1, 255]);

                    mutatedChild(r, c) = dna;
            else

                mutation = randi([-mutationRange, mutationRange]);

                mutatedChild(r, c) = mutatedChild(r, c) + mutation;

            end
        end
    end
end
end