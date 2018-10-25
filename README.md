TAIJI: Approaching Experimental Replicates-level Accuracy for Drug Synergy Prediction

This is the package of Yuanfang's winning algorithm in the AstraZeneca-Sanger Drug Combination Prediction DREAM Challenge

background: [Drug Combination Prediction](https://www.synapse.org/#!Synapse:syn4231880/wiki/)

see also: [Yuanfang Guan's 1st Place Solution](https://www.synapse.org/#!Synapse:syn5614689/wiki/396206) and [Original Code](https://www.synapse.org/#!Synapse:syn5614689/files/)

Please contact (gyuanfan@umich.edu or hyangl@umich.edu) if you have any questions or suggestions.

<p align="left">
<img src="https://github.com/Hongyang449/TAIJI/blob/master/figure/workflow.png" width="700">
</p>

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
To run TAIJI, the monotherapy data are required to extract features. Two types of files are needed: 

**1. summary table example** (e.g. data/test_monotherapy.csv)

| CELL_LINE | COMPOUND_A | COMPOUND_B | MAX_CONC_A | MAX_CONC_B | IC50_A | H_A | Einf_A |
| --------- | ---------- | ---------- | ---------- | ---------- | ------ | --- | ------ |
| MFM-223   | ADAM17     | AKT        | 3          | 1          | 0.226  | 1.9 | 17.47  |
| UM-UC-3   | AKT        | ATR_4      | 3          | 3          | 0.977  | 2.7 | 46.19  |

| IC50_B | H_B | Einf_B | SYNERGY_SCORE | QA | COMBINATION_ID | FILENAME                    |
| ------ | --- | ------ | ------------- | -- | -------------- | --------------------------- |
| 0.562  | 1.2 | 70.23  | NA            | 1  | ADAM17.AKT     | ADAM17.AKT.MFM-223.Rep1.csv |
| 1.12   | 1.9 | 81.79  | NA            | 1  | AKT.ATR_4      | AKT.ATR_4.UM-UC-3.Rep1.csv  |

* CELL_LINE: Normalized cell line name.
* COMPOUND_A: Name of drug/compound A described by its target.
* COMPOUND_B: Name of drug/compound B described by its target.
* MAX_CONC_A: Maximum concentration (uM) of drug A.
* MAX_CONC_B: Maximum concentration (uM) of drug B.
* IC50_A: Concentration where half of the maximum kill is obtained with drug A.
* H_A: Slope of the dose-response curve for drug A.
* Einf_A: Maximum cells killed (percentage) with drug A.
* IC50_B: Concentration where half of the maximum kill is obtained with drug B.
* H_B: Slope of the dose-response curve for drug B.
* Einf_B: Maximum cells killed (percentage) with drug B.
* SYNERGY_SCORE: To be predicted
* QA: Quality assessment flag of combination assays (1: good, -1: bad)
* COMBINATION_ID: Name for drug A and drug B combination
* FILENAME: the filename of the corresponding monotherapy spreadsheets

**2. monotherapy spreadsheets** (e.g. data/monotherapy_spread_csv/drug1.drug2.cell_line.Rep1.csv)

| --------- | --------- | ----- | ----- | ----- | ----- | ----- | ---------- |
|           | 0         | 0.03  | 0.1   | 0.3   | 1     | 3     | (=Agent 2) |
| 0         | 100       | 113.8 | 106.4 | 98.1  | 100.2 | 91.7  |            |
| 0.01      | 104.5     | NA    | NA    | NA    | NA    | NA    |            |
| 0.03      | 108.5     | NA    | NA    | NA    | NA    | NA    |            |
| 0.1       | 73        | NA    | NA    | NA    | NA    | NA    |            |
| 0.3       | 34.5      | NA    | NA    | NA    | NA    | NA    |            |
| 1         | 18.8      | NA    | NA    | NA    | NA    | NA    |            |
| (=Agent1) |           |       |       |       |       |       |            | 
| Agent1    | DRUG1     |       |       |       |       |       |            |  
| Agent2    | DRUG2     |       |       |       |       |       |            |  
| Unit1     | \muM      |       |       |       |       |       |            | 
| Unit2     | \muM      |       |       |       |       |       |            | 
| Title     | CELL_LINE |       |       |       |       |       |            |   

* the 1st row is the 5 concentrations of drug A (Agent1)
* the 2nd row is the corresponding 5 responses to drug A
* the 1st column is the 5 concentrations (0.01, 0.03, ... , 1) of drug B (Agent2)
* the 2nd column is the corresponding 5 responses (104.5, 108.5, 73, 34.5, 18.8) to drug B

The example monotherapy data of 100 query drug combinations are provided. Of note, the monotherapy data were simulated and they are NOT real data.

### 2. Making predictions (using default parameters)
Once you prepare and format the input monotherapy data, you can put them in the correponding data folder (and remove the example data). Then you can simply run TAIJI by
```
python TAIJI.py
```
TAIJI automatically generates a prediction file prediction.csv in a very short time. If you run it using the simulated example data of 100 drug combinations, it takes about 5mins.

You can also provide the input file/directory and output directory:
```
python TAIJI.py -i1 data/test_monotherapy.csv -i2 data/monotherapy_spread_csv/ -o ../
```
The argument i1 is the monotherapy summary table. The i2 is the directory of monotherapy spread sheets. The o is the output directory.

### 3. Making predictions (using customized parameters)
To run TAIJI with advanced options, you can check the descriptions by running:
```
python TAIJI.py -h
```
It returns:
```
  -i1 INPUT1, --input1 INPUT1
                        Input summary table (example: data/test_monotherapy.csv)
  -i2 INPUT2, --input2 INPUT2
                        Directory of the input monotherapy spread sheets (example: data/monotherapy_spread_csv/)
  -w1 WEIGHT1, --weight1 WEIGHT1
                        Weight for the monotherapy component
  -w2 WEIGHT2, --weight2 WEIGHT2
                        Weight for the cell line-drug component
  -w3 WEIGHT3, --weight3 WEIGHT3
                        Weight for the molecular profile component
  -o OUTPUTDIR, --outputdir OUTPUTDIR
                        Output directory
```
TAIJI has three prediction components based on different inputs: 1. monotherapy treatment effect 2. cell line-drug frequency 3. molecular profiles. The default weights of these three components are 1:1:2, which are based on [Yuanfang's winning solution](https://www.synapse.org/#!Synapse:syn5614689/wiki/396206).

These weights can be adjusted based on the input data. For example, if the user believes that their monotherapy input data is less reliable (e.g. due to large noise), they can adjust these weights (e.g. from 1:1:2 to 0.8:2:4) by running TAIJI like this:
```
python TAIJI.py -w1 0.8 -w2 2 -w3 4
```

