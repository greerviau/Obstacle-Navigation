# Obstacle-Navigation
## Player
Each player contians a brain, which has an array of direction vectors that are used to determine their direction. At first these vectors are all initialized randomly.

## Population
A population of 300 players are created, each with their own brain. Once all of the players in a population die then the fitness of each player is calculated. After the fitnesses are calculated, the population then performs Natural Selection. To do this a new population is created which inherits some of the previous population and mutates them to possibly create improvements. The players that are to be inherited is determined by their fitness, a player with a higher fitness is more likely to be chosen to be inherited.

## Evolution Strategy
Once a player reaches the finish, the maximum amount of steps players can make is set to however many it took that player to reach it. This ensures that future generations will have to improve the quality of their moves in order to reach the finish in less steps than the previous.




