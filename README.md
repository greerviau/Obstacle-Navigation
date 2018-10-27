# Obstacle-Navigation
## Player
Each player contains their own Neural Net. Each player can see in 8 directions and detects the distance to either the wall or the edge of the window. These distances are fed into the input of the Neural Net. The weights and bias' are randomized for the first population of players. The player has a knowledge of it's distance to the finish, they also count the amount of steps they have taken to get to the finish. If a player hits either the wall or the edge of the window it dies and stops counting steps. The output of the Neural Net determines which of 8 directions the player will move.

## Population
A population of 300 players are created, each with their own Neural Net. Once all of the players in a population die then the fitness of each player is calculated. After the fitnesses are calculated, the population then performs Natural Selection. To do this a new population is created which inherits some of the previous population and mutates them to possibly create improvements. The players that are to be inherited is determined by their fitness, a player with a higher fitness is more likely to be chosen to be inherited.

## Evolution Strategy
Some problems with simply creating players that move until they either die or find the finish is that evolution is not able to create mutations that actually improve the next population. To be able to create more useful mutations I used Incremental Learning. To do this each player initially starts out only being able to make 100 moves, and every 5 generations they gain another 50 moves. This allows them to better learn a situation before moves before moving onto a new situation.

![obstaclenavigation-1](https://user-images.githubusercontent.com/36581610/47600686-496b7880-d993-11e8-866e-0defac0e6432.gif)

![obstaclenavigation-2](https://user-images.githubusercontent.com/36581610/47607221-3389a200-d9eb-11e8-89fb-a9b07a38e714.gif)


