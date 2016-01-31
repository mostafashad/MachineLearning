#Loading libraries and input data
library(ggplot2)
library(caret)
allData = read.csv("pml-training.csv") 

inTrain = createDataPartition(y=allData$classe, p=0.80, list=FALSE)

training = allData[inTrain,]
testing = allData[-inTrain,]

preObj = preProcess(training, method="knnImpute")

modFit = train(classe ~ .,method = "rf",data = training)

prediction = predict(modFit , newdata=testing)
prediction

confusionMatrix(prediction, testing$classe)

mainTest  = read.csv("pml-testing.csv")
finalResult = predict(modFit , newdata=mainTest  )

finalResult