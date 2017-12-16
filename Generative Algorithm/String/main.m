clear;
clc;
close all;

%Defining constants
POPULATION_SIZE = 3000;
MATING_FACTOR = 25;
TARGET_FITNESS = 1;
MUTATION_RATE = 1;

found = false;

%creating a variable to keep track of the generation
generationCount = 1;

%Obtaining the target string from the user
targetInput = input('Please enter a target string \n', 's');
target = length(targetInput);

%Building the initial population, inputing the valued population size and
%target
initialPopulation = buildPopulation(POPULATION_SIZE, target);

population = initialPopulation;

fitnessValues = calculateFitness(population, targetInput, POPULATION_SIZE);

%The following loop will run until the target string is found or the target
%fitness is reached by at least one memeber of the population.

tic
while ~found && (max(fitnessValues) < TARGET_FITNESS)
    %printing the maximum fitness value of the current generation
    fprintf('current fitness: %f \n', max(fitnessValues));
    
    %Building a mating pool from which parents will be choosen to build the
    %next generation
    matingPool = buildMatingPool(fitnessValues, MATING_FACTOR, POPULATION_SIZE);
    
    %The following loop will run for for the entire population size,
    %creating a new generation
    for i = 1 : POPULATION_SIZE
        bound = length(matingPool);
        
        %Selecting a random parent from matingPool
        parent1Index = matingPool(randi([1,bound]));
        parent2Index = matingPool(randi([1,bound]));
        
        parent1 = population{parent1Index};
        parent2 = population{parent2Index};
        
        %Breeding the two parents, 
        child = breed(parent1, parent2);
        
        %Setting the mutated child to the ith value oF the new population
        population{1, i} = causeMutation(child, MUTATION_RATE);
    end
    
    %Iterating the generation
    generationCount = generationCount + 1;
    
    %Calculating the fitness values of the current generation
    fitnessValues = calculateFitness(population, targetInput, POPULATION_SIZE);
    
    %Finding the highest fitness value of the generation
    maxFitness(1, generationCount) = max(fitnessValues);
    
    %Finding the average fitness value of the generation
    avgFitness(1, generationCount) = sum(fitnessValues) / length(fitnessValues);
    
    %fprintf("Generation: %f , checker: %f \n", generationCount, sum(strcmp(targetInput, population)));
    
    if sum(strcmp(targetInput, population)) > 0 
        found = true;
    end
end

time = toc;

finalIndex = find(fitnessValues == max(fitnessValues), 1);
fprintf("The final output is: %s \n", population{1, finalIndex});
fprintf("The final output was found in %f seconds \n", time);
fprintf("The final output was found in %f generations \n", generationCount);

plot(avgFitness(1: generationCount - 1));

hold on 

plot(maxFitness(1: generationCount - 1));

legend('Average Fitness','Max Fitness');

delete log.txt

for i = 1 : generationCount
    logFile = fopen('log.txt', 'a');
    fprintf(logFile, "Generation %i:\n  Max Fitness: %f\n  Average Fitness: %f\n", i, maxFitness(1, i), avgFitness(1,i));
end

    
