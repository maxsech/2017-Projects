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

    normalComparison = imabsdiff(targetImage, curentOrganism);  %Finding the difference between the target and the member of the population
    foundPixelsNormal = numel(find(normalComparison < tolerance));  %finding where that absolute difference is less than the tolerance
    normalFitnessValues(1, i) = foundPixelsNormal / (targetWidth * targetHeight);  %dividing the number of pixels found to be within tolerance by the total number of pixels
end

%% Mean Filter

meanFitnessValues = zeros(1, popSize);

kernel = ones(3)/9;

noiseReducedImageTarget = uint8(conv2(targetImage, kernel));

for i = 1:popSize
    curentOrganism = uint8(inputPopulation{1, i});

    noiseReducedImagePopulation = uint8(conv2(curentOrganism, kernel)); %applying a mean filter to the population member
    meanComparison = imabsdiff(noiseReducedImageTarget, noiseReducedImagePopulation);   %Finding the difference between the target and the member of the population
    foundPixelsMean = numel(find(meanComparison < tolerance));  %finding where that absolute difference is less than the tolerance
    meanFitnessValues(1, i) = foundPixelsMean / (targetWidth * targetHeight);  %dividing the number of pixels found to be within tolerance by the total number of pixels
end

%% Differential X

xDifferentialFitnessValues = zeros(1, popSize);

for i = 1:popSize
    xTarget = diff(targetImage,1,2); %Finding the difference between pixels in the x direction for the target image
    xPopulation = diff(uint8(inputPopulation{1, i}),1,2); %Finding the difference between pixels in the x direction for the currently selected member of the population
    
    xDiffernetialComparison = imabsdiff(xTarget, xPopulation); %Finding the absolute difference between the differences of the target and the member of the population
    foundPixelsdiffernetialX = numel(find(xDiffernetialComparison < diffentialTolerance)); %finding where that absolute difference is less than the tolerance
    xDifferentialFitnessValues(1, i) = foundPixelsdiffernetialX / (targetWidth * targetHeight); %dividing the number of pixels found to be within tolerance by the total number of pixels

end
    
%% Differential Y

yDifferentialFitnessValues = zeros(1, popSize);

for i = 1:popSize
    yTarget = diff(targetImage);    %Finding the difference between pixels in the y direction for the target image
    yPopulation = diff(uint8(inputPopulation{1, i}));   %Finding the difference between pixels in the y direction for the currently selected member of the population
    
    yDiffernetialComparison = imabsdiff(yTarget, yPopulation);  %Finding the absolute difference between the differences of the target and the member of the population
    foundPixelsdiffernetialY = numel(find(yDiffernetialComparison < diffentialTolerance));  %finding where that absolute difference is less than the tolerance
    yDifferentialFitnessValues(1, i) = foundPixelsdiffernetialY / (targetWidth * targetHeight);  %dividing the number of pixels found to be within tolerance by the total number of pixels
end

%% Combo

for i = 1:popSize
    %combining the separate fitness values into a unified fitness value
   fitnessValues(1, i) = sqrt(((normalFitnessValues(1, i))/1.01)^2 + (meanFitnessValues(1, i))^2 + ((xDifferentialFitnessValues(1, i))/2)^2 + ((yDifferentialFitnessValues(1, i))/2)^2);
   
end

end
