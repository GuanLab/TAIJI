import glob
import sklearn
import numpy as np
from numpy import genfromtxt
from sklearn import ensemble
import pickle
import sys

num_tree=300
max_depth=3

test=genfromtxt('test.txt',delimiter='\t')
filename = 'monotherapy_model/monotherapy.model'
est= pickle.load(open(filename, 'rb'))
pred=est.predict(test[:,1:])
np.savetxt('output.txt', pred, delimiter='\n')

test=genfromtxt('test_reverse.txt',delimiter='\t')
filename = 'monotherapy_model/monotherapy.model'
est= pickle.load(open(filename, 'rb'))
pred=est.predict(test[:,1:])
np.savetxt('output_reverse.txt', pred, delimiter='\n')

test=genfromtxt('test_ori.txt',delimiter='\t')
filename = 'monotherapy_model/monotherapy_ori.model'
est= pickle.load(open(filename, 'rb'))
pred=est.predict(test[:,1:])
np.savetxt('output_ori.txt', pred, delimiter='\n')
