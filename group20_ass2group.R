#install.packages('RTextTools')
#install.packages('SparseM')


library(SparseM)
library(RTextTools)
setwd("~/group20_ass2group")
#setwd("~/Desktop/Monash-Ds/FIT5149 Applied data analysis/group20_ass2group")

############Validation##################

#load data
#train_data = readLines('./train_features(5).txt')
#train_label = readLines('./train_label(5).txt')
#validate_data = readLines('./validation_features(5).txt')
#validate_label = readLines('./validation_label(5).txt')

#all_data = c(train_data, validate_data, test_data)
#all_labels = c(train_label,validate_label)
#tfidf_matrix = create_matrix(as.matrix(all_data)[,1], weighting=tm::weightTfIdf)
#container <- create_container(tfidf_matrix,
#                              as.factor(all_labels),
#                              trainSize = 1:85000,
#                              testSize = 85001:106445,
#                              virgin = FALSE)

#for (i in seq(0,2,0.2)){
#     maxent_model <- train_model(container, algorithm = "MAXENT", use_sgd = FALSE,
#                                  l1_regularizer = i)#l1_regularizer = 0.8,
#     maxent_result <- classify_model(container, maxent_model)
#     print(i)
#     print(mean(validate_label == maxent_result[,"MAXENTROPY_LABEL"]))
#}
  
#maxent_model <- train_model(container, algorithm = "MAXENT", use_sgd = TRUE,l1_regularizer = 0.8)
#maxent_result <- classify_model(container, maxent_model)
#mean(validate_label == maxent_result[,"MAXENTROPY_LABEL"])
######################################################


#predict test label
train_data = readLines('./train features.txt')
train_label = readLines('./training_labels_final.txt')
test_data = readLines('./test features.txt')

all_data = c(train_data, test_data)
all_labels = c(train_label)

tfidf_matrix = create_matrix(as.matrix(all_data)[,1], weighting=tm::weightTfIdf)
container <- create_container(tfidf_matrix,
                              as.factor(all_labels),
                              trainSize = 1:106445,
                              testSize = 106446:133055,
                              virgin = FALSE)

maxent_model <- train_model(container, algorithm = "MAXENT", use_sgd = TRUE,l1_regularizer = 0.8)

maxent_result <- classify_model(container, maxent_model)

labels <- as.vector(maxent_result[,"MAXENTROPY_LABEL"])

######################################################
for (i in 1:length(labels)){
  labels[i] <- paste(paste('te_doc_',i,sep='') , labels[i], sep=' ')
}

# save output
fileConn<-file("testing_labels_pred.txt")
writeLines(labels, fileConn)
close(fileConn)


