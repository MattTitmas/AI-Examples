int Gen = 0; /* Counter - Current generation */
int Rows = 40; /* How many rows / cols are on the snake board */
Snake[] Snakes;
int noOfSnakes = 1000; /* The number of snakes per generation */
int Index; /* Which snake to show (whichever isn't currently dead) */

void setup() {
  size(800, 800);
  background(0);
  Snakes = new Snake[noOfSnakes];
  for (int i = 0; i < Snakes.length; i++) {
    Snakes[i] = new Snake();
  }
  Index = 0; /* Initially show the first snake, could be the worst / best / anywhere inbetween */
}


void draw() {   
  boolean AllDead = true; /* Checking to see once one generation is complete */
  background(0);
  for (int i = 0; i < Snakes.length; i++) {
    if (!Snakes[i].Dead) {
      AllDead = false; /* Atleast one snake is still alive, carry on showing this generation */
      Snakes[i].Move();
      if (i == Index) {
        Snakes[i].Show();
      }
    } else {
      if (i == Index) { /* If the snake we are showing dies */
        for (int j = 0; j < Snakes.length; j++) {
          if (!Snakes[j].Dead) {
            Index = j; /* Replace it with another snake */
            break;
          }
        }
      }
    }
  }
  if (AllDead) { /* All snakes dead - create new generation and reset boards */
    Evolve();
    Index = 0; 
  }
}

void Evolve() { /* Calculate snakes for the next generation */
  int[] FittestSnakes = FindFittestSnakes(10); /* Find the 10 fittest snakes (Those that did the best in the game) */
  int Count = Snakes.length/10;
  for (int i = 0; i < Snakes.length; i++) {
    int ToMutate = floor(i/Count);
    Snakes[i].Mutate(Snakes[FittestSnakes[ToMutate]]); /* Mutate each snake using one of the 10 fittest (100 snakes per fittest snake chosen) */
  }
} 



int[] FindFittestSnakes(int x) { /* Find the (x) fittest snakes and return an array of the locations in the Snakes[] */
  int[] SnakeArray = new int[x];
  IntList FittestSnakes = new IntList();
  for (int i = 0; i < Snakes.length; i++) {
    if (FittestSnakes.size() < x) { /* Fill the array to atleast 10 snakes */
      FittestSnakes.append(Snakes[i].GetFitness());
      SnakeArray[i] = i;
    } else {
      for (int j = 0; j < FittestSnakes.size(); j++) {
        if (FittestSnakes.get(j) < Snakes[i].GetFitness()) { /* If a new snake is better than any of the old ones, replace */
          FittestSnakes.set(j, Snakes[i].GetFitness());
          SnakeArray[j] = i;
          break;
        }
      }
    }
  }
  println(Gen); /* Used so the user can see how many generations have passed since starting */
  Gen++;
  return SnakeArray;
}
