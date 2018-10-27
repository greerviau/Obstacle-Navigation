class Population {
   Player[] players;
   int bestPlayerNo;
   int gen = 1;
   int minSteps = 500;
   float fitnessSum = 0;
   Player bestPlayer;
   boolean finishFound = false;
   
   Population(int size) {
      players = new Player[size];
      for(int i = 0; i < players.length; i++) {
         players[i] = new Player(); 
      }
   }
   
   void update() {
      for(int i = 0; i < players.length; i++) {
         if(players[i].brain.steps > minSteps) {
            players[i].dead = true; 
         } else {
           players[i].update(); 
         }
      }
   }
   
   void show() {
      for(int i = 0; i < players.length; i++) {
         players[i].show(); 
      }
   }
   
   void setBestPlayer() {
      float max = 0;
      int maxIndex = 0;
      for(int i = 0; i < players.length; i++) {
         if(players[i].fitness > max) {
            max = players[i].fitness;
            maxIndex = i;
         }
      }
      println("Gen: "+gen+" Best Fitness: "+players[bestPlayerNo].fitness);
      bestPlayerNo = maxIndex;
      
      if(players[bestPlayerNo].reachedFinish) {
          minSteps = players[bestPlayerNo].brain.steps;
          finishFound = true;
      }
   }
   
   boolean done() {
      for(int i = 0; i < players.length; i++) {
         if(!players[i].dead && !players[i].reachedFinish)
           return false;
      }
      return true;
   }
   
   void naturalSelection() {
      Player[] newPlayers = new Player[players.length];

      setBestPlayer();
      
      newPlayers[0] = players[bestPlayerNo].clone();
      newPlayers[0].isBest = true;
      for(int i = 1; i < players.length; i++) {
         Player parent = selectPlayer();
         newPlayers[i] = parent.clone();
      }
      players = newPlayers.clone();
      gen+=1;
   }
   
   Player selectPlayer() {
      float  rand = random(fitnessSum);
      //println("Random Selection: "+rand);
      float runningSum = 0;
      for(int i = 0; i < players.length; i++) {
         runningSum += players[i].fitness;
         if(runningSum > rand)
           return players[i];
      }
      return players[0];
   }
   
   void mutate() {
      for(int i = 1; i < players.length; i++) {
         players[i].brain.mutate();
      }
   }
   
   void calculateFitness() {
      for(int i = 1; i < players.length; i++) {
         players[i].calculateFitness(); 
         fitnessSum += players[i].fitness;
      }
   }
}
