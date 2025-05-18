# Statistical Techniques with R: Weight Change Analysis

This repository contains the R code and report for the COMP1814 coursework, which investigates weight changes in mice and rats following a nutritional supplement treatment using simulation, visualization, hypothesis testing, and distribution fitting.

## Contents

```
.
├── main.R                            # Complete R script with data generation, visualization, tests, and fitting
├── Report.pdf                        # Coursework Report 
├── distribution_fits_comparison.pdf  # Plots comparing fitted distributions (Weibull, Lognormal, Gamma)
└── README_R.md                       # This file
```

## Project Overview

In this analysis, we:

1. **Generated synthetic data** for:

   * Mice weights before/after treatment (Normal distribution)
   * Rats weights before/after treatment (Weibull distribution)
2. **Visualized** weight distributions using density plots and boxplots.
3. **Assessed normality** with Q–Q plots and the Shapiro–Wilk test.
4. **Performed hypothesis tests**:

   * Paired t-test for normally distributed mice data.
   * Wilcoxon signed‑rank test for rats data (non‑normal).
5. **Fitted distributions** (Weibull, Lognormal, Gamma) to the post‑treatment rats data and compared fits with density, CDF, Q–Q, and P–P plots.

## Prerequisites

* R version ≥ 4.0.0
* Installed packages:

  * `ggplot2`
  * `fitdistrplus`

You can install missing packages with:

```r
install.packages(c("ggplot2", "fitdistrplus"))
```

## Running the Analysis

1. Open R or RStudio in this project directory.

2. Source the script or run it line by line:

   ```r
   source("main.R")
   ```

3. The script will:

   * Generate and store synthetic datasets in memory.
   * Produce and display density and boxplots for both species.
   * Output results of normality tests and hypothesis tests in the console.
   * Save distribution fitting comparison plots to `distribution_fits_comparison.pdf`.

## Key Results

* **Mice paired t-test** showed a significant weight increase after treatment (t = –7.29, p < 1e–10).
* **Rats Wilcoxon test** indicated a significant median change (V = 6503, p ≈ 1.5e–5).
* Among fitted models for rats post‑treatment data, the **\[best‑fitting distribution]** can be judged visually from the PDF plots.

## References

* Wickham, H., & Grolemund, G. (2017). *R for Data Science*. O’Reilly Media.

## License

This coursework is distributed under CC BY‑NC‑SA 4.0. Please see the accompanying report for detailed attributions.
