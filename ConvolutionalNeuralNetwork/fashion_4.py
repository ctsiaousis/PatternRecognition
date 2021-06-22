from __future__ import absolute_import, division, print_function, unicode_literals

# TensorFlow and tf.keras
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras import layers , models
from keras.layers.normalization import BatchNormalization

# Helper libraries
import numpy as np
import matplotlib.pyplot as plt

from plots import plot_some_data, plot_some_predictions

#execution time is also compared for different optimizers
import time

fashion_mnist = keras.datasets.fashion_mnist

(train_images, train_labels), (test_images, test_labels) = fashion_mnist.load_data()

class_names = ['T-shirt/top', 'Trouser', 'Pullover', 'Dress', 'Coat',
               'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot']

# Scale these values to a range of 0 to 1 before feeding them to the neural network model. 
# To do so, divide the values by 255. 
# It's important that the training set and the testing set be preprocessed in the same way
train_images = train_images / 255.0

test_images = test_images / 255.0

train_images_reshaped = train_images.reshape(-1,28,28,1) # reshape to mum_train_images X height X width X channels, where channels = 1
test_images_reshaped = test_images.reshape(-1,28,28,1) # reshape


# Build the model
# Building the neural network requires configuring the layers of the model, then compiling the model.

model = models.Sequential()# fill the model
# Conv1
model.add(layers.Conv2D(32, (3, 3), padding='same', activation=None, input_shape=(28, 28, 1)))
# Batch Normalization - 1
model.add(layers.BatchNormalization())
# with ReLU activation
model.add(layers.Activation('relu'))
# Conv2
model.add(layers.Conv2D(32, (3, 3), padding='same', activation=None, input_shape=(28, 28, 1)))
# Batch Normalization - 2
model.add(layers.BatchNormalization())
# with ReLU activation
model.add(layers.Activation('relu'))
# Max Pool-1
model.add(layers.MaxPooling2D((2, 2),padding='valid'))
# Conv3
model.add(layers.Conv2D(64, (3, 3), padding='same', activation=None, input_shape=(14, 14, 32)))
# Batch Normalization - 3
model.add(layers.BatchNormalization())
# with ReLU activation
model.add(layers.Activation('relu'))
# Conv4
model.add(layers.Conv2D(64, (3, 3), padding='same', activation=None, input_shape=(14, 14, 64)))
# Batch Normalization - 4
model.add(layers.BatchNormalization())
# with ReLU activation
model.add(layers.Activation('relu'))
# Max Pool-2
model.add(layers.MaxPooling2D((2, 2),padding='valid'))
# Conv5
model.add(layers.Conv2D(128, (3, 3), padding='same', activation=None, input_shape=(7, 7, 64)))
# Batch Normalization - 5
model.add(layers.BatchNormalization())
# with ReLU activation
model.add(layers.Activation('relu'))
# Max Pool-3
model.add(layers.MaxPooling2D((2, 2),padding='valid'))
# Flat Layer
model.add(layers.Flatten())
# Dense-1
model.add(layers.Dense(200))
# Batch Normalization - 6
model.add(layers.BatchNormalization())
# with ReLU activation
model.add(layers.Activation('relu'))
# Dense-2
model.add(layers.Dense(10))

model.summary() #prints a summary of the model's architecture

start_time = time.time()
optim = 'adam'
model.compile(optimizer=optim,
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])

#Train the model
# Training the neural network model requires the following steps:

#   1. Feed the training data to the model. In this example, the training data is in the train_images and train_labels arrays.
#   2. The model learns to associate images and labels.
#   3. You ask the model to make predictions about a test set—in this example, the test_images array.
#   4. Verify that the predictions match the labels from the test_labels array.

info = model.fit(train_images_reshaped, train_labels, epochs=50, validation_data=(test_images_reshaped, test_labels))

plt.plot(info.history['accuracy'], label='accuracy')
plt.plot(info.history['val_accuracy'], label = 'val_accuracy')
plt.xlabel('Epoch')
plt.ylabel('Accuracy')
plt.grid()
plt.legend()
plt.title("Execution time with %s optimizer: %s seconds ---" %(optim, (time.time() - start_time)))
plt.show()

# Evaluate accuracy
test_loss, test_acc = model.evaluate(test_images_reshaped,  test_labels, verbose=2)

print('\nTest accuracy:', test_acc)

# Make predictions
# With the model trained, you can use it to make predictions about some images. 
# The model's linear outputs, logits. 
# Attach a softmax layer to convert the logits to probabilities, which are easier to interpret. 
probability_model = tf.keras.Sequential([model, 
                                         tf.keras.layers.Softmax()])

predictions = probability_model.predict(test_images_reshaped)

plot_some_predictions(test_images, test_labels, predictions, class_names, num_rows=5, num_cols=3)





