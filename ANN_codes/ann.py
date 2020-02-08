# Importing the libraries

import numpy as np

import matplotlib.pyplot as plt

import pandas as pd



# Importing the dataset

import io

#dataset = pd.read_csv(io.BytesIO(uploaded['MC_Ntx.csv']))

dataset = pd.read_csv('MC_Ntx.csv')

#X = dataset.iloc[:0, :].values

X = [0.553042982266035,	0.696239864189143,	0.876514057731832,	1.10346582107342,	1.38918116319565,	1.74887546793278,	2.20170376864399,	2.77178082358891,	3.48946531473984,	4.39297655830032,	5.53042982266036,	6.96239864189143,	8.76514057731832,	11.0346582107342,	13.8918116319565,	17.4887546793278,	22.0170376864399,	27.7178082358891,	34.8946531473984,	43.9297655830032,	55.3042982266035,	69.6239864189143,	87.6514057731832,	110.346582107342,	138.918116319565,	174.887546793278,	220.170376864399,	277.178082358891,	348.946531473984,	439.297655830032,	553.042982266035,	696.239864189143,	876.514057731832,	1103.46582107342,	1389.18116319565,	1748.87546793278,	2201.70376864399,	2771.78082358891,	3489.46531473984,	4392.97655830032,	5530.4298226,	6962.39864189143,	8765.14057731832,	11034.6582107342,	13891.8116319565,	17488.7546793278,	22017.0376864399,	27717.8082358891,	34894.6531473984,	43929.7655830032,	55304.2982266035, 69623.9864189142, 87651.4057731832,	110346.582107342,	138918.116319565,	174887.546793278]

y = [0.0517828717114680,	0.0581284484704143,	0.0660997328344832,	0.0761162208627400,	0.0887066490866021,	0.104537336145883,	0.124447777103665,	0.149495382944266,	0.181011760721368,	0.220673552931224,	0.270591630836380,	0.333423409489391,	0.412514277135746,	0.512075676176404,	0.637409320370390,	0.795189487334910,	0.993818416994016,	1.24387373957031,	1.55867175788748,	1.95497657886493,	2.45389285655308,	3.08198968744680,	3.87271550883719,	4.86817934817320,	6.12139328110305,	7.69909551702774,	9.68530445161211,	12.1857929524086,	15.3337211495535,	19.2967276981381,	24.2858571478077,	30.5667988345560,	38.4740358066750,	48.4286572667541,	60.9607831072146,	76.7377947276648,	96.5998755280420,	121.604753738401,	153.084030304186,	192.714091492285,	242.605382572710,	305.414796725007,	384.487164288471,	484.033377174702,	609.354634216996,	767.124749339129,	965.745556482990,	1215.79433790343,	1530.58710301857,	1926.88771446844,	2425.80062493021,	3053.89476618112,	3844.61844159965,	4840.08057029029,	6093.29314057687,	7670.99429168987]

#y = dataset.iloc[1:, :].values



print(X)

print(y)



# Splitting the dataset into the Training set and Test set

from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.8, test_size = 0.2, random_state = 0)





# Make ANN

import keras

from keras.models import Sequential

from keras.layers import Dense



classifier = Sequential()

classifier.add(Dense(output_dim=5, init = 'uniform', activation='tanh', input_dim=5))

classifier.add(Dense(output_dim=5, init = 'uniform', activation='tanh'))

classifier.add(Dense(output_dim=5, init = 'uniform', activation='tanh'))

classifier.add(Dense(output_dim=5, init = 'uniform', activation='tanh'))

classifier.add(Dense(output_dim=5, init = 'uniform', activation='tanh'))

classifier.add(Dense(output_dim=5, init = 'uniform', activation='tanh'))

classifier.add(Dense(output_dim=5, init = 'uniform', activation='tanh'))

classifier.add(Dense(output_dim=5, init = 'uniform', activation='tanh'))

classifier.add(Dense(output_dim=5, init = 'uniform', activation='tanh'))

classifier.add(Dense(output_dim=5, init = 'uniform', activation='tanh'))



classifier.add(Dense(output_dim=1, init = 'uniform', activation='sigmoid', input_dim=5))

#use activation softmax or sth in case of more than two categories in output (non binary)



#Compiling the ANN

classifier.compile(optimizer='adam', loss='binary_crossentropy', metrics = ['accuracy'])

classifier.fit(X_train,y_train, batch_size = 10, nb_epoch = 100)



# Predicting the Test set results

y_pred = classifier.predict(X_test)

y_pred = (y_pred>0.5)



# Making the Confusion Matrix

from sklearn.metrics import confusion_matrix

cm = confusion_matrix(y_test, y_pred)

print(cm)