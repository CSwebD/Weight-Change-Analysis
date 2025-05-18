#Task1: Data	Generation

#a. The	weights	of	mice as	“before”	and	“after”	the	treatment,	coming	from	a	normal	
#distribution	with	mean	=	20,	and	variance	=	2.
#For	the	“after”	treatment	add	to	the	mean	1	unit	and	to	the	variance	0.5	units,	that	is	
#mean	=	21	and	variance	=	2.5.

set.seed(123)
mice_before <- rnorm(n = 200, mean = 20, sd = sqrt(2))
mice_after <- rnorm(n = 200, mean = 21, sd = sqrt(2.5))


#b. The	weights	of	rats as	“before”	and	“after”	the	treatment,	coming	from	a	Weibull	
#distribution	with	shape	=	10,	and	scale	=	20.
#For	the	“after”	treatment	remove	from	the	shape	1	unit	and	add	to	the	scale	1	unit,	that	
#is	shape	=	9	and	scale	=	21.

set.seed(123)
rats_before <- rweibull(n = 200, shape = 10, scale = 20)
rats_after <- rweibull(n = 200, shape = 9, scale = 21)



#1.c
# Ensure ggplot2 is installed and loaded
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
library(ggplot2)

# Combining mice and rats data into a single data frame for easier plotting
combined_data <- rbind(mice, rats)

# Density plot for Mice
ggplot(combined_data[combined_data$species == "Mice", ], aes(x = weight, fill = time)) +
  geom_density(alpha = 0.5) +
  scale_fill_manual(values = c("Before" = "blue", "After" = "red")) +
  ggtitle("Density Plot of Mice Weights Before and After Treatment") +
  labs(x = "Weight", y = "Density")

# Density plot for Rats
ggplot(combined_data[combined_data$species == "Rats", ], aes(x = weight, fill = time)) +
  geom_density(alpha = 0.5) +
  scale_fill_manual(values = c("Before" = "blue", "After" = "red")) +
  ggtitle("Density Plot of Rats Weights Before and After Treatment") +
  labs(x = "Weight", y = "Density")




#d. To compare the distributions of mice and rats before and after treatment using boxplots,
#we can use the geom = boxplot option in the qplot function. We can use the following code:

qplot(data = mice, x = time, y = weight, fill = time, geom = "boxplot") +
  ggtitle("Boxplot of Mice Weights Before and After Treatment")
qplot(data = rats, x = time, y = weight, fill = time, geom = "boxplot") +
  ggtitle("Boxplot of Rats Weights Before and After Treatment")



#Task 2: Appropriateness for Hypothesis t-testing

#a. To check for normality in the mice data set, we can use a QQ plot and the Shapiro-Wilk test. We can use the following code:

library(ggplot2)
ggplot(data.frame(mice = c(mice_before, mice_after)), aes(sample = mice)) + 
  stat_qq() + 
  ggtitle("QQ Plot of Mice Weights Before and After Treatment")

shapiro.test(c(mice_before, mice_after))

#b. Checking normality of rats data using a QQ plot and Shapiro-Wilk test:
# Combine the before and after treatment weights into a single vector
rats_combined <- c(rats_before, rats_after)
# Create a QQ plot to visually assess normality
qqnorm(rats_combined)
qqline(rats_combined)
# Perform a Shapiro-Wilk test to test for normality
shapiro.test(rats_combined)

#c) 
# Combining data into a suitable format
# No need to reinstall ggplot2 if it's already installed
# install.packages("ggplot2")
library(ggplot2)

# Combine the mice data
mice_data <- data.frame(
  Weight = c(mice_before, mice_after),
  Condition = factor(rep(c("Before", "After"), each = length(mice_before))),
  Species = "Mice"
)

# Combine the rats data
rats_data <- data.frame(
  Weight = c(rats_before, rats_after),
  Condition = factor(rep(c("Before", "After"), each = length(rats_before))),
  Species = "Rats"
)

#Plotting
# Density plot for Mice
mice_density <- ggplot(mice_data, aes(x = Weight, fill = Condition)) +
  geom_density(alpha = 0.5) +
  scale_fill_manual(values = c("Before" = "blue", "After" = "red")) +
  labs(title = "Density Plot Comparison for Mice Data",
       x = "Weight", y = "Density")
print(mice_density)

# Density plot for Rats
rats_density <- ggplot(rats_data, aes(x = Weight, fill = Condition)) +
  geom_density(alpha = 0.5) +
  scale_fill_manual(values = c("Before" = "blue", "After" = "red")) +
  labs(title = "Density Plot Comparison for Rats Data",
       x = "Weight", y = "Density")
print(rats_density)



#Task 3: Hypothesis testing

#a. T-test statistic

# Load data
mice_before <- read.csv("mice_before.csv", header = TRUE)
mice_after <- read.csv("mice_after.csv", header = TRUE)

# Combine data
mice <- data.frame(before = mice_before$weight, after = mice_after$weight)

# Paired t-test
t_test <- t.test(mice$before, mice$after, paired = TRUE)

# Extract and comment on t-test output
t_test$statistic  # t-test statistic
t_test$parameter  # degrees of freedom
t_test$p.value  # p-value
t_test$conf.int  # confidence interval
t_test$estimate  # sample estimates

#3a
# Perform a paired t-test for mice before and after treatment
mice_t_test <- t.test(mice_before, mice_after, paired = TRUE)

# Display the results
print(mice_t_test)

#3b
# Assuming rats_before and rats_after are available
# Perform the Wilcoxon signed-rank test
rats_wilcox_test <- wilcox.test(rats_before, rats_after, paired = TRUE)

# Print the results to extract the details
print(rats_wilcox_test)

#4
# Ensure the fitdistrplus package is installed and then load it
if (!requireNamespace("fitdistrplus", quietly = TRUE)) install.packages("fitdistrplus")
library(fitdistrplus)

# Assuming rats_after dataset is available and represents the weights after treatment
# Fit Weibull, Lognormal, and Gamma distributions to the rats_after data

fit_weibull <- fitdist(rats_after, distr = "weibull")
fit_lognorm <- fitdist(rats_after, distr = "lnorm")
fit_gamma <- fitdist(rats_after, distr = "gamma")

# Compare the fitted distributions visually using the comparison tool for density, CDF, QQ, and PP plots
pdf("distribution_fits_comparison.pdf")
par(mfrow = c(2, 2)) # Arrange plots in a 2x2 grid
plot.legend <- c("Weibull", "Lognormal", "Gamma")

# Density Comparison
denscomp(list(fit_weibull, fit_lognorm, fit_gamma), legendtext = plot.legend)
# CDF Comparison
cdfcomp(list(fit_weibull, fit_lognorm, fit_gamma), legendtext = plot.legend)
# QQ Plot Comparison
qqcomp(list(fit_weibull, fit_lognorm, fit_gamma), legendtext = plot.legend)
# PP Plot Comparison
ppcomp(list(fit_weibull, fit_lognorm, fit_gamma), legendtext = plot.legend)
dev.off() # Close the PDF device






