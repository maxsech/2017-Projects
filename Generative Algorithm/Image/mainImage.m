%Partner 1: Maxwell Sechelski
%Partner 2: Jakob Monroe

clear;
clc;
close all;

%Defining constants
FILE = '25x25angry.png';
POPULATION_SIZE = 500;
MATING_FACTOR = 100;
EXPONENTIAL_FACTOR = 50;
MUTATION_RATE = 1;
MUTATION_RANGE = 50;
TARGET_FITNESS = .99;
TOLERANCE = 5;

found = false;

%creating a variable to keep track of the generation
generationCount = 1;

%Loading target image
inImg = imread(FILE);

%Pulling red, green and blue layers from image
targetImageRed = inImg(: , :, 1);
targetImageGreen = inImg(: , :, 2);
targetImageBlue = inImg(: , :, 3);

%Finding the size of the image
[targetWidth, targetHeight, targetPage] = size(inImg);

%Building the initial population, inputing the valued population size and
%target
initialPopulationRed = buildPopulationImage(POPULATION_SIZE ,targetWidth, targetHeight);
initialPopulationGreen = buildPopulationImage(POPULATION_SIZE ,targetWidth, targetHeight);
initialPopulationBlue = buildPopulationImage(POPULATION_SIZE ,targetWidth, targetHeight);

%Initializing the populations for each layer that will be iterated upon for
%each generation. The populations will be initialized with the values of the
%first generation that were generated on lines above.
redPopulation = initialPopulationRed;
greenPopulation = initialPopulationGreen;
bluePopulation = initialPopulationBlue;

%Finding fitness values for each layer
fitnessValuesRed = calculateFitnessImage(redPopulation, targetImageRed, TOLERANCE, POPULATION_SIZE);
fitnessValuesGreen = calculateFitnessImage(greenPopulation, targetImageGreen, TOLERANCE, POPULATION_SIZE);
fitnessValuesBlue = calculateFitnessImage(bluePopulation, targetImageBlue, TOLERANCE, POPULATION_SIZE);

%Finding the highest fitness value for each layer of the generation, then saving the most
%fit organisim for each layer.
maxFitnessRed(1, generationCount) = max(fitnessValuesRed);
maxFitnessRedOrganism(1, generationCount) = redPopulation(find(fitnessValuesRed == max(fitnessValuesRed), 1));

maxFitnessGreen(1, generationCount) = max(fitnessValuesGreen);
maxFitnessGreenOrganism(1, generationCount) = greenPopulation(find(fitnessValuesGreen == max(fitnessValuesGreen), 1));

maxFitnessBlue(1, generationCount) = max(fitnessValuesBlue);
maxFitnessBlueOrganism(1, generationCount) = bluePopulation(find(fitnessValuesBlue == max(fitnessValuesBlue), 1));  

maxFitness(1, generationCount) = (maxFitnessRed(1, generationCount) + maxFitnessGreen(1, generationCount) + maxFitnessBlue(1, generationCount)) / 3;

%Finding the average fitness value of each layer of the generation
avgFitnessRed(1, generationCount) = sum(fitnessValuesRed) / length(fitnessValuesRed);
avgFitnessGreen(1, generationCount) = sum(fitnessValuesGreen) / length(fitnessValuesGreen);
avgFitnessBlue(1, generationCount) = sum(fitnessValuesBlue) / length(fitnessValuesBlue);

%Finding the average fitness value of the generation
avgFitness(1, generationCount) = (avgFitnessRed(1, generationCount) + avgFitnessGreen(1, generationCount) + avgFitnessBlue(1, generationCount)) / 3;

%The following loop will run until the target string is found or the target
%fitness is reached by at least one memeber of the population.

tic
while maxFitness(1, generationCount) < TARGET_FITNESS
    %printing the maximum fitness value of the current generation
    fprintf('current max fitness: %f \nCurrent average fitness: %f \nCurrent generation: %f \n', maxFitness(1, generationCount), avgFitness(1, generationCount), generationCount);
    
    %Building a mating pool from which parents will be choosen to build the
    %next generation
    matingPoolRed = buildMatingPoolImage(fitnessValuesRed.^EXPONENTIAL_FACTOR, MATING_FACTOR, POPULATION_SIZE);
    matingPoolGreen = buildMatingPoolImage(fitnessValuesGreen.^EXPONENTIAL_FACTOR, MATING_FACTOR, POPULATION_SIZE);
    matingPoolBlue = buildMatingPoolImage(fitnessValuesBlue.^EXPONENTIAL_FACTOR, MATING_FACTOR, POPULATION_SIZE);
    
    %The following loop will run for for the entire population size,
    %creating a new generation
    for i = 1 : POPULATION_SIZE
        boundRed = length(matingPoolRed);
        boundGreen = length(matingPoolGreen);
        boundBlue = length(matingPoolBlue);
        
        %Selecting a random parent from matingPool of each layer
        %Since the mating pool holds indicies of the population based on the number of tickets they were assigned, the members with their index represented in the mating pool
        %more times are more likely to be choosen.
        redParent1Index = matingPoolRed(randi([1,boundRed]));
        redParent2Index = matingPoolRed(randi([1,boundRed]));
        
        greenParent1Index = matingPoolGreen(randi([1,boundGreen]));
        greenParent2Index = matingPoolGreen(randi([1,boundGreen]));
        
        blueParent1Index = matingPoolBlue(randi([1,boundBlue]));
        blueParent2Index = matingPoolBlue(randi([1,boundBlue]));
        
        redParent1 = redPopulation{redParent1Index};
        redParent2 = redPopulation{redParent2Index};
        
        greenParent1 = greenPopulation{greenParent1Index};
        greenParent2 = greenPopulation{greenParent2Index};
        
        blueParent1 = bluePopulation{blueParent1Index};
        blueParent2 = bluePopulation{blueParent2Index};
        
        %Breeding the two parents, 
        redChild = breedImage(redParent1, redParent2);
        greenChild = breedImage(greenParent1, greenParent2);
        blueChild = breedImage(blueParent1, blueParent2);

        
        %Setting the mutated child to the ith value oF the new population
        redPopulation{1, i} = causeMutationImage(redChild, MUTATION_RANGE, MUTATION_RATE);
        greenPopulation{1, i} = causeMutationImage(greenChild, MUTATION_RANGE, MUTATION_RATE);
        bluePopulation{1, i} = causeMutationImage(blueChild, MUTATION_RANGE, MUTATION_RATE);
    end
    
    %Iterating the generation
    generationCount = generationCount + 1;
    
    %Calculating the fitness values of the current generation
    fitnessValuesRed = calculateFitnessImage(redPopulation, targetImageRed, TOLERANCE, POPULATION_SIZE);
    fitnessValuesGreen = calculateFitnessImage(greenPopulation, targetImageGreen, TOLERANCE, POPULATION_SIZE);
    fitnessValuesBlue = calculateFitnessImage(bluePopulation, targetImageBlue, TOLERANCE, POPULATION_SIZE);
    
    %Finding the highest fitness value of the generation
    maxFitnessRed(1, generationCount) = max(fitnessValuesRed);
    maxFitnessRedOrganism(1, generationCount) = redPopulation(find(fitnessValuesRed == max(fitnessValuesRed), 1));

    maxFitnessGreen(1, generationCount) = max(fitnessValuesGreen);
    maxFitnessGreenOrganism(1, generationCount) = greenPopulation(find(fitnessValuesGreen == max(fitnessValuesGreen), 1));

    maxFitnessBlue(1, generationCount) = max(fitnessValuesBlue);
    maxFitnessBlueOrganism(1, generationCount) = bluePopulation(find(fitnessValuesBlue == max(fitnessValuesBlue), 1));
    
    maxFitness(1, generationCount) = (maxFitnessRed(1, generationCount) + maxFitnessGreen(1, generationCount) + maxFitnessBlue(1, generationCount)) / 3;
    
    
    %Finding the average fitness value of the generation
    avgFitnessRed(1, generationCount) = sum(fitnessValuesRed) / length(fitnessValuesRed);
    avgFitnessGreen(1, generationCount) = sum(fitnessValuesGreen) / length(fitnessValuesGreen);
    avgFitnessBlue(1, generationCount) = sum(fitnessValuesBlue) / length(fitnessValuesBlue);
    
    avgFitness(1, generationCount) = (avgFitnessRed(1, generationCount) + avgFitnessGreen(1, generationCount) + avgFitnessBlue(1, generationCount)) / 3;
end

time = toc;

fprintf("The final output was found in %f seconds \n", time);
fprintf("The final output was found in %f generations \n", generationCount);

benchmarks = linspace(1, generationCount, 9);

%Sythesizing the benchmark images, pulling the the saved layers from the
%max fitness values of each layer
benchmark1(:, :, 1) =  maxFitnessRedOrganism{1, int16(benchmarks(1))};
benchmark1(:, :, 2) =  maxFitnessGreenOrganism{1, int16(benchmarks(1))};
benchmark1(:, :, 3) =  maxFitnessBlueOrganism{1, int16(benchmarks(1))};

benchmark2(:, :, 1) =  maxFitnessRedOrganism{1, int16(benchmarks(2))};
benchmark2(:, :, 2) =  maxFitnessGreenOrganism{1, int16(benchmarks(2))};
benchmark2(:, :, 3) =  maxFitnessBlueOrganism{1, int16(benchmarks(2))};

benchmark3(:, :, 1) =  maxFitnessRedOrganism{1, int16(benchmarks(3))};
benchmark3(:, :, 2) =  maxFitnessGreenOrganism{1, int16(benchmarks(3))};
benchmark3(:, :, 3) =  maxFitnessBlueOrganism{1, int16(benchmarks(3))};

benchmark4(:, :, 1) =  maxFitnessRedOrganism{1, int16(benchmarks(4))};
benchmark4(:, :, 2) =  maxFitnessGreenOrganism{1, int16(benchmarks(4))};
benchmark4(:, :, 3) =  maxFitnessBlueOrganism{1, int16(benchmarks(4))};

benchmark5(:, :, 1) =  maxFitnessRedOrganism{1, int16(benchmarks(5))};
benchmark5(:, :, 2) =  maxFitnessGreenOrganism{1, int16(benchmarks(5))};
benchmark5(:, :, 3) =  maxFitnessBlueOrganism{1, int16(benchmarks(5))};

benchmark6(:, :, 1) =  maxFitnessRedOrganism{1, int16(benchmarks(6))};
benchmark6(:, :, 2) =  maxFitnessGreenOrganism{1, int16(benchmarks(6))};
benchmark6(:, :, 3) =  maxFitnessBlueOrganism{1, int16(benchmarks(6))};

benchmark7(:, :, 1) =  maxFitnessRedOrganism{1, int16(benchmarks(7))};
benchmark7(:, :, 2) =  maxFitnessGreenOrganism{1, int16(benchmarks(7))};
benchmark7(:, :, 3) =  maxFitnessBlueOrganism{1, int16(benchmarks(7))};

benchmark8(:, :, 1) =  maxFitnessRedOrganism{1, int16(benchmarks(8))};
benchmark8(:, :, 2) =  maxFitnessGreenOrganism{1, int16(benchmarks(8))};
benchmark8(:, :, 3) =  maxFitnessBlueOrganism{1, int16(benchmarks(8))};

benchmark9(:, :, 1) =  maxFitnessRedOrganism{1, int16(benchmarks(9))};
benchmark9(:, :, 2) =  maxFitnessGreenOrganism{1, int16(benchmarks(9))};
benchmark9(:, :, 3) =  maxFitnessBlueOrganism{1, int16(benchmarks(9))};


subplot(3, 3, 1); imshow(benchmark1 / 255); title(['Generation ' num2str(int16(benchmarks(1)))]);
subplot(3, 3, 2); imshow(benchmark2 / 255); title(['Generation ' num2str(int16(benchmarks(2)))]);
subplot(3, 3, 3); imshow(benchmark3 / 255); title(['Generation ' num2str(int16(benchmarks(3)))]);
subplot(3, 3, 4); imshow(benchmark4 / 255); title(['Generation ' num2str(int16(benchmarks(4)))]);
subplot(3, 3, 5); imshow(benchmark5 / 255); title(['Generation ' num2str(int16(benchmarks(5)))]);
subplot(3, 3, 6); imshow(benchmark6 / 255); title(['Generation ' num2str(int16(benchmarks(6)))]);
subplot(3, 3, 7); imshow(benchmark7 / 255); title(['Generation ' num2str(int16(benchmarks(7)))]);
subplot(3, 3, 8); imshow(benchmark8 / 255); title(['Generation ' num2str(int16(benchmarks(8)))]);
subplot(3, 3, 9); imshow(benchmark9 / 255); title(['Generation ' num2str(int16(benchmarks(9)))]);

figure;

hold on

plot(avgFitness(1: generationCount - 1));

hold on 

plot(maxFitness(1: generationCount - 1));

legend('Average Fitness','Max Fitness');

delete log.txt

for i = 1 : generationCount
    logFile = fopen('log.txt', 'a');
    fprintf(logFile, "Generation %i:\n  Max Fitness: %f\n  Average Fitness: %f\n", i, maxFitness(1, i), avgFitness(1,i));
end

    
