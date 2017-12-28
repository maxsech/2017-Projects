function [out] = buildPopulationImage(popSize ,targetWidth, targetHeight)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function creates random images that match the  
% size of the target image.
%
% INPUTS: popSize -- The population size is the number of 
%                    members within the population consisting 
%                    of a randomly generated image each (Note:
%                    the population size has to be smaller with
%                    the images due to memory constraints).
%         targetSize -- the size of the RGB image that is being
%                       the target image (r,c,p).
%     
% OUTPUTS: out -- output contains all population members each as 
%                 as a randomly generated image in black and white
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
population = zeros(1, popSize);
cellPopulation = num2cell(population);

for i = 1:popSize
    organismRaw = zeros(targetWidth, targetHeight); %Creating a template that is the same size as the target image
    
    %The following loops will fill the template with randomized number data from 1 to 255
    for w = 1 : targetWidth
        for h = 1 : targetHeight
            dna = randi([1, 255]);
         
            organismRaw(w, h) = dna;
        end
    end
    
    cellPopulation{1, i} = organismRaw; %adding the generated organism to the population
end

out = cellPopulation;
end
