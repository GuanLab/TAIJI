import glob
import sklearn
import numpy as np
from numpy import genfromtxt
from sklearn import ensemble
import pickle
import sys

test=genfromtxt('test.txt',delimiter='\t')
if test.ndim==1:
    test=test.reshape((1,test.shape[0]))

filename = 'molecular_model/' + sys.argv[1] + '.model'
est= pickle.load(open(filename, 'rb'))
pred=est.predict(test[:,1:])
np.savetxt('output.txt', pred, delimiter='\n')

