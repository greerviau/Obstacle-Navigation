class Matrix {
  
  int rows, cols;
  float[][] matrix;
  
   Matrix(int r, int c) {
     rows = r;
     cols = c;
     matrix = new float[rows][cols];
   }
   
   Matrix(float[][] m) {
      matrix = m;
      rows = matrix.length;
      cols = matrix[0].length;
   }
   
   void output() {
      for(int i = 0; i < rows; i++) {
         for(int j = 0; j < cols; j++) {
            print(matrix[i][j] + " "); 
         }
         println();
      }
      println();
   }
   
   void multiply(float n) {
      for(int i = 0; i < rows; i++) {
         for(int j = 0; j < rows; j++) {
            matrix[i][j] *= n; 
         }
      }
   }
   
   Matrix dot(Matrix n) {
     Matrix result = new Matrix(rows, n.cols);
     
     if(cols == n.rows) {
        for(int i = 0; i < rows; i++) {
           for(int j = 0; j < n.cols; j++) {
              float sum = 0;
              for(int k = 0; k < cols; k++) {
                 sum += matrix[i][k]*n.matrix[k][j];
              }  
              result.matrix[i][j] = sum;
           }
        }
     }
     return result;
   }
   
   void randomize() {
      for(int i = 0; i < rows; i++) {
         for(int j = 0; j < cols; j++) {
            matrix[i][j] = random(-1,1); 
         }
      }
   }
   
   void Add(float n) {
      for(int i = 0; i < rows; i++) {
         for(int j = 0; j < cols; j++) {
            matrix[i][j] += n; 
         }
      }
   }
   
   Matrix add(Matrix n) { 
      Matrix newMatrix = new Matrix(rows,cols);
      if(cols == n.cols && rows == n.rows) {
         for(int i = 0; i < rows; i++) {
            for(int j = 0; j < cols; j++) {
               newMatrix.matrix[i][j] = matrix[i][j] + n.matrix[i][j]; 
            }
         }
      }
      return newMatrix;
   }
   
   Matrix subtract(Matrix n) { 
      Matrix newMatrix = new Matrix(rows,cols);
      if(cols == n.cols && rows == n.rows) {
         for(int i = 0; i < rows; i++) {
            for(int j = 0; j < cols; j++) {
               newMatrix.matrix[i][j] = matrix[i][j] - n.matrix[i][j]; 
            }
         }
      }
      return newMatrix;
   }
   
   Matrix multiply(Matrix n) { 
      Matrix newMatrix = new Matrix(rows,cols);
      if(cols == n.cols && rows == n.rows) {
         for(int i = 0; i < rows; i++) {
            for(int j = 0; j < cols; j++) {
               newMatrix.matrix[i][j] = matrix[i][j] * n.matrix[i][j]; 
            }
         }
      }
      return newMatrix;
   }
   
   Matrix transpose() {
      Matrix n = new Matrix(rows, cols);
      for(int i = 0; i < rows; i++) {
         for(int j = 0; j < cols; j++) {
            n.matrix[j][i] = matrix[i][j]; 
         }
      }
      return n;
   }
   
   Matrix singleColumnMatrixFromArray(float[] arr) {
      Matrix n = new Matrix(arr.length, 1);
      for(int i = 0; i < arr.length; i++) {
         n.matrix[i][0] = arr[i]; 
      }
      return n;
   }
   
   void fromArray(float[] arr) {
      for(int i = 0; i < rows; i++) {
         for(int j = 0; j < cols; j++) {
            matrix[i][j] = arr[j+i*cols]; 
         }
      }
   }
   
   float[] toArray() {
      float[] arr = new float[rows*cols];
      for(int i = 0; i < rows; i++) {
         for(int j = 0; j < cols; j++) {
            arr[j+i*cols] = matrix[i][j]; 
         }
      }
      return arr;
   }
   
   Matrix addBias() {
      Matrix n = new Matrix(rows+1, 1);
      for(int i = 0; i < rows; i++) {
         n.matrix[i][0] = matrix[i][0]; 
      }
      n.matrix[rows][0] = 1;
      return n;
   }
   
   Matrix activate() {
      Matrix n = new Matrix(rows, cols);
      for(int i = 0; i < rows; i++) {
         for(int j = 0; j < cols; j++) {
            n.matrix[i][j] = sigmoid(matrix[i][j]); 
         }
      }
      return n;
   }
   
   float sigmoid(float x) {
      return 1 / (1 + pow((float)Math.E, -x)); 
   }
   
   Matrix sigmoidDerived() {
      Matrix n = new Matrix(rows, cols);
      for(int i = 0; i < rows; i++) {
         for(int j = 0; j < cols; j++) {
            n.matrix[i][j] = (matrix[i][j] * (1 - matrix[i][j])); 
         }
      }
      return n;
   }
   
   Matrix removeBottomLayer() {
      Matrix n = new Matrix(rows-1, cols);
      for(int i = 0; i < n.rows; i++) {
         for(int j = 0; j < cols; j++) {
            n.matrix[i][j] = matrix[i][j]; 
         }
      }
      return n;
   }
   
   void mutate(float mutationRate) {
      for(int i = 0; i < rows; i++) {
         for(int j = 0; j < cols; j++) {
            float rand = random(1);
            if(rand<mutationRate) {
               matrix[i][j] += randomGaussian()/5;
               
               if(matrix[i][j] > 1)
                  matrix[i][j] = 1; 
               if(matrix[i][j] <-1)
                 matrix[i][j] = -1;
            }
         }
      }
   }
   
   Matrix crossover(Matrix partner) {
      Matrix child = new Matrix(rows, cols);
      
      int randC = floor(random(cols));
      int randR = floor(random(rows));
      
      for(int i = 0; i < rows; i++) {
         for(int j = 0;  j < cols; j++) {
            if((i  < randR) || (i == randR && j <= randC))
               child.matrix[i][j] = matrix[i][j]; 
            else
              child.matrix[i][j] = partner.matrix[i][j];
         }
      }
      return child;
   }
   
   Matrix clone() {
      Matrix clone = new Matrix(rows, cols);
      for(int i = 0; i < rows; i++) {
         for(int j = 0; j < cols; j++) {
            clone.matrix[i][j] = matrix[i][j]; 
         }
      }
      return clone;
   }
}
