# Obstacle-Navigation

## Download and Run
To run the program you will need [Processing](https://processing.org/)

## Player
Each player contians a brain, which has an array of direction vectors that are used to determine their direction. At first these vectors are all initialized randomly. Over multiple generations the players brains start to become optimized to navigate the wall. 

## Population
A population of 300 players are created, each with their own brain. Once all of the players in a population die then the fitness of each player is calculated. After the fitnesses are calculated, the population then performs Natural Selection. To do this a new generation is created which inherits some of the previous generation and mutates them to possibly create improvements. The players that are to be inherited is determined by their fitness, a player with a higher fitness is more likely to be chosen to be inherited.

## Mutation
When mutating a players brains, a global mutation rate is used to determine how much of the brain to mutate. This variable is initialized to 0.01 ( 1% ) but can be adjusted to cause more or less drastic mutations.

## Evolution Strategy
To ensure that populations cant decrease in quality by possible inheriting the worst players of a previous generation, the best player from the current generation is placed immediately into the next generation and is unmutated. Once a player reaches the finish, the maximum amount of steps any player can make is set to however many it took that player to reach it. This ensures that future generations will have to improve the quality of their moves in order to reach the finish in less steps than the previous generation.

![obstaclenavigation-1](https://user-images.githubusercontent.com/36581610/47609709-da813480-da11-11e8-9241-e7a8fc3d8417.gif)

![obstaclenavigation-2](https://user-images.githubusercontent.com/36581610/47609712-e3720600-da11-11e8-8d00-272e1c442c52.gif)
