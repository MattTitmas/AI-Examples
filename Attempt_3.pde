int Gen = 0;
int Rows = 40;
Snake[] Snakes;
int Index;

void setup() {
  size(800, 800);
  background(0);
  Snakes = new Snake[1000];
  for (int i = 0; i < Snakes.length; i++) {
    Snakes[i] = new Snake();
  }
  Index = 0;
}


void draw() {   
  boolean AllDead = true;
  background(0);
  for (int i = 0; i < Snakes.length; i++) {
    if (!Snakes[i].Dead) {
      AllDead = false;
      Snakes[i].Move();
      if (i == Index) {
        Snakes[i].Show();
      }
    } else {
      if (i == Index) {
        for (int j = 0; j < Snakes.length; j++) {
          if (!Snakes[j].Dead) {
            Index = j;
            break;
          }
        }
      }
    }
  }
  if (AllDead) {
    Evolve();
    Index = 0;
  }
}

void Evolve() {
  int[] FittestSnakes = FindFittestSnakes(10);
  int Count = Snakes.length/10;
  for (int i = 0; i < Snakes.length; i++) {
    int ToMutate = floor(i/Count);
    Snakes[i].Mutate(Snakes[FittestSnakes[ToMutate]]);
  }
} 



int[] FindFittestSnakes(int x) {
  int[] SnakeArray = new int[x];
  IntList FittestSnakes = new IntList();
  for (int i = 0; i < Snakes.length; i++) {
    if (FittestSnakes.size() < x) {
      FittestSnakes.append(Snakes[i].GetFitness());
      SnakeArray[i] = i;
    } else {
      for (int j = 0; j < FittestSnakes.size(); j++) {
        if (FittestSnakes.get(j) < Snakes[i].GetFitness()) {
          FittestSnakes.set(j, Snakes[i].GetFitness());
          SnakeArray[j] = i;
          break;
        }
      }
    }
  }
  println(Gen);
  Gen++;
  return SnakeArray;
}
