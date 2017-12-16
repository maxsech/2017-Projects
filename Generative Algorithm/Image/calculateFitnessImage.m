function [fitnessValues] = calculateFitnessImage(inputPopulation, targetImage, tolerance, popSize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function checks how many elements of the random array
% has in common with the target image. This is dependent on 
% both the position and the value within a certain allowance, such as +-
% .1. Or the fitness can be assessed by using the average values around the
% pixel being analyzed. The fitness score is then looked at as a percentage 
% to properly assess the fitness.
%
% INPUTS: inputPopulation -- the input is the output of the build
%                            population function (the random 
%                            generated images from before)
%         targetImage -- the target image is the end result that is desired
%                        after all of the mutations have occured and is
%                        used to assess the fitness of a particular member
%                        of the population.
%         tolerance -- for determining whether a member is fit, there is
%                      a tolerance given so that values relatively close to
%                      a target value are also considered to be "fit".
%                      Therefore, to be fit a pixel doesn't have to match
%                      the target value exactly, it can be within the
%                      tolerance.
% OUTPUTS: fitnessValues -- outputs an array containing the fitness
%                           values (percent fitenss) of all members 
%                           of the population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[targetWidth, targetHeight] = size(targetImage);
diffentialTolerance = 3;

%% Normal

normalFitnessValues = zeros(1, popSize);


for i = 1:popSize
    curentOrganism = uint8(inputPopulation{1, i});

    normalComparison = imabsdiff(targetImage, curentOrganism);
    foundPixelsNormal = numel(find(normalComparison < tolerance));
    normalFitnessValues(1, i) = foundPixelsNormal / (targetWidth * targetHeight);
end

%% Mean Filter

meanFitnessValues = zeros(1, popSize);

kernel = ones(3)/9;

noiseReducedImageTarget = uint8(conv2(targetImage, kernel));

for i = 1:popSize
    curentOrganism = uint8(inputPopulation{1, i});

    noiseReducedImagePopulation = uint8(conv2(curentOrganism, kernel));
    meanComparison = imabsdiff(noiseReducedImageTarget, noiseReducedImagePopulation);
    foundPixelsMean = numel(find(meanComparison < tolerance));
    meanFitnessValues(1, i) = foundPixelsMean / (targetWidth * targetHeight);
end

%% Differential X

xDifferentialFitnessValues = zeros(1, popSize);

for i = 1:popSize
    xTarget = diff(targetImage,1,2);
    xPopulation = diff(uint8(inputPopulation{1, i}),1,2);
    
    xDiffernetialComparison = imabsdiff(xTarget, xPopulation);
    foundPixelsdiffernetialX = numel(find(xDiffernetialComparison < diffentialTolerance));
    xDifferentialFitnessValues(1, i) = foundPixelsdiffernetialX / (targetWidth * targetHeight);

end
    
%% Differential Y

yDifferentialFitnessValues = zeros(1, popSize);

for i = 1:popSize
    yTarget = diff(targetImage);
    yPopulation = diff(uint8(inputPopulation{1, i}));
    
    yDiffernetialComparison = imabsdiff(yTarget, yPopulation);
    foundPixelsdiffernetialY = numel(find(yDiffernetialComparison < diffentialTolerance));
    yDifferentialFitnessValues(1, i) = foundPixelsdiffernetialY / (targetWidth * targetHeight);
end

%% Combo

for i = 1:popSize
   fitnessValues(1, i) = sqrt(((normalFitnessValues(1, i))/1.01)^2 + (meanFitnessValues(1, i))^2 + ((xDifferentialFitnessValues(1, i))/2)^2 + ((yDifferentialFitnessValues(1, i))/2)^2);
   
end

end