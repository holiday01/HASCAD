# HASCAD
## Concept
The HASCAD is a cell composition deconvolution model to predict the 15 immune cell abundance from RNA-seq data, which the emdenble depp learning model trained on three PBMC scRNA-seq. We utilize the Harmony and Symphony to do pre-processing and remove batch effects between scRNA-seq to build the reference data.

### Model trained on PBMC results
While you prepare your gene expression matrix, you should check if the sort of genes is as same as the [reference genes](https://github.com/holiday01/HASCAD/blob/main/Source/gene.csv).
You can follow the [example file](https://github.com/holiday01/HASCAD/blob/main/Source/Example.csv) for your query.

#### At starting
You can run the `main.ipynb` and get a result.

#### Without Symphony-Harmony
And, your can modify [this script](https://github.com/holiday01/HASCAD/blob/main/Model/main.ipynb) to replace the file "Example.csv".
```
sample = pd.read_csv("../Source/Example.csv",header=None)
```
#### With Symphony-Harmony

Run `Harmony-Symphony/HS_main.R`
And, your can modify [this script](https://github.com/holiday01/HASCAD/blob/main/Model/main.ipynb) to replace the file "Example.csv".
```
sample = pd.read_csv("Harmony-Symphony/hs_exmple_output.csv",header=None)
```

#### Run your query
The gene expression without/with Symphony-Harmony.

Then you can run the script and obtain a plot like [this](https://github.com/holiday01/HASCAD/blob/main/Result/result.png)

![alt text](https://github.com/holiday01/HASCAD/blob/main/Result/result.png)

### Training your model
The two steps in this section. The first is that you will prepare your reference data and query data. The second is that the HASCAD trained by the reference data to predict the cell composition of query data.

#### With Symphony-Harmony

`make preparations`

## Require
### R for harmony-symphony analysis

R version 4.1.0

irlba 2.3.5

[Symphony](https://github.com/immunogenomics/symphony)

### Python for model training, predicting, and figure out
See the [requirement_python.txt](https://github.com/holiday01/HASCAD/blob/main/requirement_python.txt)


## Manuscript
Under review on [BMC journal](https://www.biomedcentral.com/) 
