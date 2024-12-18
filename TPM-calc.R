library(dplyr)

in_f <- "raw-counts.txt"      
out_f <- "TPM.txt"                   

data <- read.table(in_f, header=TRUE, row.names=1, sep="\t", quote="")

nf_RPK <- 1000/data[,1]                
RPK <- data[,2:ncol(data)] * nf_RPK              

nf_RPM <- 1000000/colSums(RPK[, 1:ncol(RPK)])         
TPM <- data.frame(matrix(ncol = 0, nrow = nrow(data)))
cat("Num of Sample is:", length(nf_RPM))
for(i in 1:length(nf_RPM)){
  single <- RPK[, i] * nf_RPM[i]
  TPM <- cbind(TPM, single)
}

colnames(TPM) <- colnames(RPK)

tmp <- cbind(rownames(data), data[,1], TPM)
write.table(tmp, out_f, sep="\t", append=F, quote=F, row.names=F)
