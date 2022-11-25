# HASCAD
## Concept
This HASCAD provide the two scenario.

### Model trained on PBMC results
The reference gene are regard to [genes](https://github.com/holiday01/HASCAD/blob/main/Source/gene.csv)
While you prepare your gene expression matrix, you should check if the your gene list is same as this tutorial, and order it as our gene list.
You can follow the example file for your [query](https://github.com/holiday01/HASCAD/blob/main/Source/Example.csv).
Here the `Example.csv` you can choice if expression data is transformed by symphony.

#### Without Symphony-Harmony
And, your can modify [this script](https://github.com/holiday01/HASCAD/blob/main/Model/main.ipynb) to replace the file "Example.csv".
```
sample = pd.read_csv("../Source/Example.csv",header=None)
```
#### With Symphony-Harmony


Then you can run the script and obtain a plot like [this](https://github.com/holiday01/HASCAD/blob/main/Result/result.png)

![alt text](https://github.com/holiday01/HASCAD/blob/main/Result/result.png)

### Training your model
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
