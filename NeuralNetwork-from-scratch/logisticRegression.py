from __future__ import print_function

import numpy as np

# Load data
fid = open('exam_scores_data1.txt', 'r')
lines = fid.readlines()
fid.close()

input_list = []
target_list = []

for line in lines:
    fields = line.rstrip().split(',')
    input_list.append([float(fields[0]), float(fields[1])])
    target_list.append([float(fields[2])]) 

X_all = np.array(input_list, dtype=np.float32) # Matrix of input features. shape = (num_examples, num_features)
Y_all = np.array(target_list, dtype=np.float32)   # Vector of target values. shape = (num_examples, )

N = X_all.shape[0] # Number of examples

# Normalize input data
# your code here


# Define the model
num_features = 2
output_depth = 1
batch_size = 8
learning_rate = 0.001


def sigmoid(z):
    # your code here

class NeuralNetwork:
    def __init__(self, input_depth, output_depth, learning_rate):
        self.W = np.sqrt(2.0/(input_depth + output_depth))*np.random.rand(input_depth, output_depth).astype(np.float32)
        self.b = np.zeros((output_depth, ), dtype=np.float32)   
        self.learning_rate = learning_rate

    def forward(self, x):
        # your code here

    def backward(self, X, Y, Y_predicted):
        # your code here  

    def cross_entropy(self, Y, Y_predicted):
        # your code here


    def update_weights(self, d_CE_d_W, d_CE_d_b):
        # your code here   


nn = NeuralNetwork(num_features, output_depth, learning_rate)

# Training the model
num_epochs = 55
num_batches = N - batch_size + 1

for epoch in range(num_epochs):
    epoch_loss = 0 
    for i in range(num_batches): # Sliding window of length = batch_size and shift = 1
        X = X_all[i:i+batch_size, :] 
        Y = Y_all[i:i+batch_size, :]

        Y_predicted = nn.forward(X) 
        batch_loss = nn.cross_entropy(Y, Y_predicted)   
        epoch_loss += batch_loss

        d_CE_d_W, d_CE_d_b = nn.backward(X, Y, Y_predicted) 
        nn.update_weights(d_CE_d_W, d_CE_d_b)

    epoch_loss /= num_batches
    print('epoch_loss = ', epoch_loss)


# Using the trained model to predict the probabilities of some examples and the compute the accuracy 

# Predict the normalized example [45, 85]
example = (np.array([[45, 85]], dtype=np.float32) - m)/s

print('Predicting the probabilities of example [45, 85]')
# your code here

# Predict the accuracy of the training examples
accuracy_np = .... # your code here

print('accuracy = ', accuracy_np) 

