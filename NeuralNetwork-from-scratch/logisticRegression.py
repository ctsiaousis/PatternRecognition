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
m = np.mean(X_all)
s = np.std(X_all)
X_all = (X_all-m)/s


# Define the model
num_features = 2
output_depth = 1
batch_size = 8
learning_rate = 0.001


def sigmoid(z):
    return 1 / (1 + np.exp(-z))

class NeuralNetwork:
    def __init__(self, input_depth, output_depth, learning_rate):
        self.W = np.sqrt(2.0/(input_depth + output_depth))*np.random.rand(input_depth, output_depth).astype(np.float32)
        self.b = np.zeros((output_depth, ), dtype=np.float32)   
        self.learning_rate = learning_rate

    def forward(self, x):
        return sigmoid(np.mat(x)*np.mat(self.W)+self.b)

    def backward(self, X, Y, Y_predicted):
        m   = X.shape[0]
        dZ  = Y_predicted - Y
        dW  = 1/m * np.dot(dZ.T,X)
        db  = 1/m * np.sum(dZ)
        return dW , db

    def cross_entropy(self, Y, Y_predicted):
        logY        = np.multiply(Y, np.log(Y_predicted))
        log1minusY  = np.multiply((1-Y), np.log(1-Y_predicted))
        return -np.mean(logY + log1minusY)


    def update_weights(self, d_CE_d_W, d_CE_d_b):
        self.W = self.W - np.dot(self.learning_rate,d_CE_d_W).reshape(2,1) #dot product shape depends on input matricies
        self.b = self.b - self.learning_rate * d_CE_d_b


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
print("Probability = ", nn.forward(example))

# TODO: find out accuracy and print learning curve

# Predict the accuracy of the training examples
# accuracy_np = .... # your code here

# print('accuracy = ', accuracy_np)

