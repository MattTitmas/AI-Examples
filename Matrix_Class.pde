static class Matrix {  /* Class used for matrices and matrix operations */
  int Rows;
  int Cols;
  double[][] Values;

  Matrix(int Width, int Height, boolean Random) { /* constructor - Random decides whether to add random floats between -1 & 1 instead of 0 */
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

  void Randomize() { /* randomizes the matrix */
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

  static Matrix AddMatrix(Matrix First, Matrix Second) { /* Static - Takes 2 matrices and returns the result of adding them element by element */
    Matrix NewMatrix = new Matrix(First.Rows, First.Cols, false);
    for (int i = 0; i < NewMatrix.Rows; i++) {
      for (int j = 0; j < NewMatrix.Cols; j++) {
        NewMatrix.Values[i][j] = First.Values[i][j] + Second.Values[i][j];
      }
    }
    return NewMatrix;
  }

  void AddMatrix(Matrix First) { /* Non Scalar - Adds second matrix to original */
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        Values[i][j] += First.Values[i][j];
      }
    }
  }


  static Matrix SubtractMatrix(Matrix First, Matrix Second) { /* Static - Takes 2 matrices and returns the result of subtracting them element by element */
    Matrix NewMatrix = new Matrix(First.Rows, First.Cols, false);
    for (int i = 0; i < NewMatrix.Rows; i++) {
      for (int j = 0; j < NewMatrix.Cols; j++) {
        NewMatrix.Values[i][j] = First.Values[i][j] - Second.Values[i][j];
      }
    }
    return NewMatrix;
  }

  void MultiplyMatrix(Matrix Second) { /* Multiplies one matrix by another element for element, storing it in the first matrix */
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        Values[i][j] *= Second.Values[i][j];
      }
    }
  }

  static Matrix MultiplyMatrix(Matrix First, Matrix Second) { /* Static - takes 2 matrices, multiplies element by element and returns a third */
    Matrix NewMatrix = new Matrix(First.Rows, First.Cols, false);
    for (int i = 0; i < First.Rows; i++) {
      for (int j = 0; j < First.Cols; j++) {
        NewMatrix.Values[i][j] = Second.Values[i][j] * First.Values[i][j];
      }
    }
    return NewMatrix;
  }

  void MultiplyNumber(float n) { /* Multiplies matrix by a scalar */
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        Values[i][j] *= n;
      }
    }
  }

  void Dot(Matrix Second) { /* Performs the dot product on a matrix given another matrix argument and stores it in the original */
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

  static Matrix Dot(Matrix First, Matrix Second) { /* Static - takes 2 matrices, performs the dot product in the order they're given and returns a 3rd matrix */
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

  static Matrix Transpose(Matrix First) { /* Static - returns a new matrix that is the transpose of the one passed as an argument */
    Matrix NewMatrix = new Matrix(First.Cols, First.Rows, false);
    for (int i = 0; i < NewMatrix.Cols; i++) {
      for (int j = 0; j < NewMatrix.Rows; j++) {
        NewMatrix.Values[j][i] = First.Values[i][j];
      }
    }
    return NewMatrix;
  }


  void Add(float N) { /* Adds a float to each element in a matrix */
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        Values[i][j] += N;
      }
    }
  }

  void Subtract(float N) { /* Subtracts a float from each element in a matrix */
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        Values[i][j] -= N;
      }
    }
  }

  static Matrix Subtract(Matrix First, int n) { /* Static - takes 2 matrices, subtracts the second from the first element by elements and returns the result */
    Matrix NewMatrix = new Matrix(First.Rows, First.Cols, false);
    for (int i = 0; i < First.Rows; i++) {
      for (int j = 0; j < First.Cols; j++) {
        NewMatrix.Values[i][j] = First.Values[i][j] - n;
      }
    }
    return NewMatrix;
  }

  void Show() { /* Prints matrix */
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        print(Values[i][j] + " ");
      }
    }
    println("");
  }

  int ShowMax() { /* returns the maximum value in the matrix */
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

  void Sigmoid() { /* Performs the sigmoid function on each element in the matrix */
    for (int i = 0; i < Rows; i++) {
      for (int j = 0; j < Cols; j++) {
        double Val = Values[i][j];
        float F = (float)Val;
        Values[i][j] = 1/(1+(exp(-F)));
      }
    }
  }

  static Matrix SigmoidPrime(Matrix First) { /* Performs the derivative of sigmoid on each element in the matrix (simplified because sigmoid previously used)*/
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

  static Matrix Array(int[] array) { /* Create a matrix from an array (same dimensions) */
    Matrix NewMatrix = new Matrix(1, array.length, false);
    for (int i = 0; i < array.length; i++) {
      NewMatrix.Values[0][i] = array[i];
    }

    return NewMatrix;
  }

  static Matrix Mutate(Matrix First) { /* Mutate a matrix, take a matrix and slightly change values, store result in NewMatrix and return */
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
