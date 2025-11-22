library(GENESPACE)
args <- commandArgs(trailingOnly = TRUE)
# get the folder where the genespace workingDirectory is located
wd <- args[1]
gpar <- init_genespace(wd = wd, path2mcscanx = "/usr/local/bin")
# run genespace

#options(mc.cores = 1)     #### diagnostic test -> give nothing different

out <- run_genespace(gpar, overwrite = TRUE)
# out <- run_genespace(gpar, overwrite = TRUE)
pangenome <- query_pangenes(out, bed = NULL, refGenome = "TAIR10", transform =
TRUE, showArrayMem = TRUE, showNSOrtho = TRUE, maxMem2Show = Inf)
# save pangenome object as rds
saveRDS(pangenome, file = file.path(wd, "pangenome_matrix.rds"))