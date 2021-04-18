import glob
import sklearn
import numpy as np
from numpy import genfromtxt
from sklearn import ensemble
import pickle
import sys

num_tree=300
max_depth=3

train=genfromtxt('train.txt',delimiter='\t')

X=train[:,1:]
Y=train[:,1]

est = sklearn.ensemble.RandomForestRegressor(n_estimators=num_tree, max_depth=max_depth, random_state=0).fit(X,Y)
filename = 'molecular_model/' + sys.argv[1] + '.model'
pickle.dump(est, open(filename, 'wb'))


