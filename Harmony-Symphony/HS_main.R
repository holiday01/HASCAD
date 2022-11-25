library("symphony")
library("irlba")

####
data <- read.csv("./hsref_gene.csv")[,2]
l <- length(data)
exp <- read.csv("./hs_example.csv")
rownames(exp) <- exp[,1]
exp <- exp[,-1]
colnames(exp) <- c("value1","value2")
name <- colnames(exp)


exp <- log2(exp+1)
exp <- lapply(t(exp), as.numeric)
query_exp <- Matrix(exp, byrow = TRUE, nrow = l, sparse = TRUE)
colnames(query_exp) <- name
rownames(query_exp) <- data


l <- dim(query_exp)[2]
query_metadata <- cbind(rep("bulk",l), rep(1,l),rep(1,l),rep(1,l),rep("mix",l),rep(1,l),rep("mix",l))
colnames(query_metadata) <- c("donor","uUMI","nGene","percent_mito","cell_type","res.0.80","cell_subtype")
rownames(query_metadata) <- name


####


ref_exp_full = readRDS('./exprs_norm_all.rds')
ref_metadata = read.csv('./meta_data_subtypes.csv', row.names = 1)
ref_exp = ref_exp_full[data, ]

####
vargenes_means_sds = tibble::tibble(symbol = data, mean = Matrix::rowMeans(ref_exp))
vargenes_means_sds$stddev = symphony::rowSDs(ref_exp, vargenes_means_sds$mean)
head(vargenes_means_sds)
ref_exp_scaled = symphony::scaleDataWithStats(ref_exp, vargenes_means_sds$mean, vargenes_means_sds$stddev, 1)
####


set.seed(0)
s = irlba::irlba(ref_exp_scaled, nv = 100)
Z_pca_ref = diag(s$d) %*% t(s$v) # [pcs by cells]
loadings = s$u

set.seed(0)
ref_harmObj = harmony::HarmonyMatrix(
  data_mat = t(Z_pca_ref),  ## PCA embedding matrix of cells
  meta_data = ref_metadata, ## dataframe with cell labels
  theta = c(3),             ## cluster diversity enforcement
  vars_use = c('donor'),    ## variable to integrate out
  nclust = 100,             ## number of clusters in Harmony model
  max.iter.harmony = 20,
  return_object = TRUE,     ## return the full Harmony model object
  do_pca = FALSE            ## don't recompute PCs
)

reference = symphony::buildReferenceFromHarmonyObj(
  ref_harmObj,            # output object from HarmonyMatrix()
  ref_metadata,           # reference cell metadata
  vargenes_means_sds,     # gene names, means, and std devs for scaling
  loadings,               # genes x PCs matrix
  verbose = TRUE,         # verbose output
  do_umap = TRUE,         # Set to TRUE only when UMAP model was saved for reference
  save_uwot_path = './testing_uwot_model_1')

query = mapQuery(query_exp,             # query gene expression (genes x cells)
                 query_metadata,        # query metadata (cells x attributes)
                 reference,             # Symphony reference object
                 do_normalize = TRUE,  # perform log(CP10k+1) normalization on query
                 do_umap = TRUE
                  )        # project query cells into reference UMAP

x <- reference$loadings %*% query$Z
write.csv(x,"./hs_exmple_output.csv")
