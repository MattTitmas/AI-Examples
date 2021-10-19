static class Matrix {  
  int Rows;
  int Cols;
  double[][] Values;

  Matrix(int Width, int Height, boolean Random) {
    Rows = Width;
    Cols = Height;
    Values = new double[Rows][Cols];
    if (Random) {
      for (int i = 0; i < Rows; i++) {
        for (int j = 0; j < Cols; j++) {
          if (Math.random() < 0.5) { 
            Values[i][j] = -Math.random();
          } else {
            Values[i][j] = Math.random();
          }
        }
      }
    }
  }

  void Randomize() {
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        if (Math.random() < 0.5) { 
          Values[i][j] = -Math.random();
        } else {
          Values[i][j] = Math.random();
        }
      }
    }
  }

  static Matrix AddMatrix(Matrix First, Matrix Second) {
    Matrix NewMatrix = new Matrix(First.Rows, First.Cols, false);
    for (int i = 0; i < NewMatrix.Rows; i++) {
      for (int j = 0; j < NewMatrix.Cols; j++) {
        NewMatrix.Values[i][j] = First.Values[i][j] + Second.Values[i][j];
      }
    }
    return NewMatrix;
  }

  void AddMatrix(Matrix First) {
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        Values[i][j] += First.Values[i][j];
      }
    }
  }


  static Matrix SubtractMatrix(Matrix First, Matrix Second) {
    Matrix NewMatrix = new Matrix(First.Rows, First.Cols, false);
    for (int i = 0; i < NewMatrix.Rows; i++) {
      for (int j = 0; j < NewMatrix.Cols; j++) {
        NewMatrix.Values[i][j] = First.Values[i][j] - Second.Values[i][j];
      }
    }
    return NewMatrix;
  }

  void MultiplyMatrix(Matrix Second) {
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        Values[i][j] *= Second.Values[i][j];
      }
    }
  }

  static Matrix MultiplyMatrix(Matrix First, Matrix Second) {
    Matrix NewMatrix = new Matrix(First.Rows, First.Cols, false);
    for (int i = 0; i < First.Rows; i++) {
      for (int j = 0; j < First.Cols; j++) {
        NewMatrix.Values[i][j] = Second.Values[i][j] * First.Values[i][j];
      }
    }
    return NewMatrix;
  }

  void MultiplyNumber(float n) {
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        Values[i][j] *= n;
      }
    }
  }

  void Dot(Matrix Second) {
    if (Cols != Second.Rows) {
      println("The columns of the first matrix, "+Cols+", does not match the rows of the second, "+Second.Rows);
    } else {
      Matrix NewMatrix = new Matrix(Rows, Second.Cols, false);
      for (int i = 0; i < Rows; i++) {
        for (int j = 0; j < Second.Cols; j++) {
          float Sum = 0;
          for (int k = 0; k < Second.Rows; k++) {
            Sum += Values[i][k] * Second.Values[k][j];
          }
          NewMatrix.Values[i][j] = Sum;
        }
      }
    }
  }

  static Matrix Dot(Matrix First, Matrix Second) {
    if (First.Cols != Second.Rows) {
      println("The columns of the first matrix, "+First.Cols+", does not match the rows of the second, "+Second.Rows);
      return null;
    } else {
      Matrix NewMatrix = new Matrix(First.Rows, Second.Cols, false);
      for (int i = 0; i < First.Rows; i++) {
        for (int j = 0; j < Second.Cols; j++) {
          float Sum = 0;
          for (int k = 0; k < Second.Rows; k++) {
            Sum += First.Values[i][k] * Second.Values[k][j];
          }
          NewMatrix.Values[i][j] = Sum;
        }
      }
      return NewMatrix;
    }
  }

  static Matrix Transpose(Matrix First) {
    Matrix NewMatrix = new Matrix(First.Cols, First.Rows, false);
    for (int i = 0; i < NewMatrix.Cols; i++) {
      for (int j = 0; j < NewMatrix.Rows; j++) {
        NewMatrix.Values[j][i] = First.Values[i][j];
      }
    }
    return NewMatrix;
  }


  void Add(float N) {
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        Values[i][j] += N;
      }
    }
  }

  void Subtract(float N) {
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        Values[i][j] -= N;
      }
    }
  }

  static Matrix Subtract(Matrix First, int n) {
    Matrix NewMatrix = new Matrix(First.Rows, First.Cols, false);
    for (int i = 0; i < First.Rows; i++) {
      for (int j = 0; j < First.Cols; j++) {
        NewMatrix.Values[i][j] = First.Values[i][j] - n;
      }
    }
    return NewMatrix;
  }

  void Show() {
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        print(Values[i][j] + " ");
      }
    }
    println("");
  }

  int ShowMax() {
    double Value = 0;
    int Location = 0;
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        if (Value < Values[i][j]) {
          Value = Values[i][j];
          Location = i*Rows+j;
        }
      }
    }
    return Location;
  }

  void Sigmoid() {
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        double Val = Values[i][j];
        float F = (float)Val;
        Values[i][j] = 1/(1+(exp(-F)));
      }
    }
  }

  static Matrix SigmoidPrime(Matrix First) {
    Matrix NewMatrix = new Matrix(First.Rows, First.Cols, false);
    for (int i = 0; i < First.Rows; i++) {
      for (int j = 0; j < First.Cols; j++) {
        double Val = First.Values[i][j];
        float F = (float)Val;
        NewMatrix.Values[i][j] = F * (1-F);
      }
    }
    return NewMatrix;
  }

  static Matrix Array(int[] array) {
    Matrix NewMatrix = new Matrix(1, array.length, false);
    for (int i = 0; i < array.length; i++) {
      NewMatrix.Values[0][i] = array[i];
    }

    return NewMatrix;
  }

  static Matrix Mutate(Matrix First) {
    float NewValue;
    Matrix NewMatrix = new Matrix(First.Rows, First.Cols, false);
    for (int i = 0; i < First.Rows; i++) {
      for (int j = 0; j < First.Cols; j++) {
        if (Math.random() > 0.3) {
          if (Math.random() > 0.5) {
            NewValue = (float)Math.random()/5;
          } else {
            NewValue = (float)-Math.random()/5;
          }
        } else {
          NewValue = 0;
        }
        NewMatrix.Values[i][j] = First.Values[i][j] + NewValue;
      }
    }
    return NewMatrix;
  }
}
