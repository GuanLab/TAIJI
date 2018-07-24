TAIJI: Approaching Experimental Replicates-level Accuracy for Drug Synergy Prediction

Please contact me (hyangl@umich.edu) if you have any questions or suggestions.

---

## Installation
Git clone a copy of TAIJI:

```
git clone https://github.com/GuanLab/TAIJI.git
```
## Required dependencies

* [python](https://www.python.org) (3.6.5)
* [numpy](http://www.numpy.org/) (1.13.3). It comes pre-packaged in Anaconda.
* [scikit-learn](http://scikit-learn.org) (0.19.0) A popular machine learning package. It can be installed by:

```
pip install -U scikit-learn
```

## Examples

### 1. Preparing monotherapy data
To run TAIJI, the monotherapy data are needed to extract features. Two types of files are needed: (1) a summary table: data/test_monotherapy.csv (2) the original monotherapy spread sheets: data/monotherapy_spread_csv/drug1.drug2.cell_line.Rep1.csv.

The example monotherapy data of 100 query drug combinations are provided. Of note, the monotherapy data were simulated and they are NOT real data.

### 2. Making predictions
Once you prepare and format the input monotherapy data, you can put them in the correponding data folder (and remove the example data). Then you can simply run TAIJI by

```
bash bash.sh
```
TAIJI automatically generates a prediction file prediction.csv in a very short time. If you run it using the simulated example data of 100 drug combinations, it takes about 5mins.

