class NeuralNetwork {

  int InputNodes;
  int HiddenLayerOne;
  int HiddenLayerTwo;
  int OutputNodes; /* Fixed number of layers - decided by programmer */

  Matrix Weights1;
  Matrix Weights2;
  Matrix Weights3;

  Matrix HiddenOneBias;
  Matrix HiddenTwoBias;
  Matrix OutputBias;

  NeuralNetwork(int Input, int HiddenOne, int HiddenTwo, int Output) { /* Initialiser, each input is the number of nodes in each layer */
    InputNodes = Input;
    HiddenLayerOne = HiddenOne;
    HiddenLayerTwo = HiddenTwo;
    OutputNodes = Output;
    Weights1 = new Matrix(InputNodes, HiddenLayerOne, true);
    Weights2 = new Matrix(HiddenLayerOne, HiddenLayerTwo, true);
    Weights3 = new Matrix(HiddenLayerTwo, OutputNodes, true);
    HiddenOneBias = new Matrix(1, HiddenLayerOne, true);
    HiddenTwoBias = new Matrix(1, HiddenLayerTwo, true);
    OutputBias = new Matrix(1, OutputNodes, true);
  }

  Matrix ForwardPropogation(Matrix Input) { /* Propogates an input forward to reach an output */
    Matrix DotProduct1 = Matrix.Dot(Input, Weights1);
    DotProduct1.AddMatrix(HiddenOneBias);
    DotProduct1.Sigmoid();
    Matrix DotProduct2 = Matrix.Dot(DotProduct1, Weights2);
    DotProduct2.AddMatrix(HiddenTwoBias);
    DotProduct2.Sigmoid();
    Matrix DotProduct3 = Matrix.Dot(DotProduct2, Weights3);
    DotProduct3.AddMatrix(OutputBias);
    DotProduct3.Sigmoid();
    return DotProduct3;
  }
}
