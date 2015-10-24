# Mean of a PMF

x <- 1:5
p <- x/sum(x)
sample <- rbind(x, p)
rownames(sample) <- c("X", "Prob")

MeanPMF <- function (data = sample){
        x <- dim(data)
        if(x[1]!=2 & x[2]!=2){
                print("Data is not two dimensional PMF")
        }
        else{
                if(x[1]==2){
                        y <- data[1,]*data[2,]
                        return(sum(y))

                }
                if(x[2]==2){
                        y <- data[,1]*data[,2]
                        return(sum(y))
                }
        }
}