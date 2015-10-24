# Bayes Rule

# You may want to read more on Wikipedia @ https://en.wikipedia.org/wiki/Bayes%27_rule for better understanding

##Sample Data
Sensitivity = 75/100
Specificity = 52/100
Prevalance = 30/100

# The probability of an event given an outcome would be defined by

Bayes <- function(sn=Sensitivity, sp=Specificity, p=Prevalance){
        print ((sn*p)/((sn*p)+((1-sp)*(1-p))))
}

#Example:
#When the subjects using the test were women who collected and tested their own samples, the overall sensitivity was 75%. Specificity was also low, in the range 52% to 75%.” Assume the lower value for the specificity. Suppose a subject has a positive test and that 30% of women taking pregnancy tests are actually pregnant. What number is closest to the probability of pregnancy given the positive test?