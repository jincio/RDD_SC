# Interpreting RDD Results: Ejemplo1.R

## Overview
This document explains the results of a Regression Discontinuity Design (RDD) analysis examining the impact of a conditional cash transfer program on school attendance. The running variable is a poverty index (0-100), with a cutoff at 40 - households with an index below 40 receive the program.

## Main RDD Results

### Key Parameters
- Total observations: 1000
- Treatment group (below cutoff): 507 observations
- Control group (above cutoff): 493 observations
- Bandwidth (h): 14.320
- Bias bandwidth (b): 22.952
- Effective number of observations: 186 (treatment) and 178 (control)

### Interpretation of Results

The conventional estimate shows:
- Coefficient: -9.252
- Standard Error: 1.221
- z-statistic: -7.576
- p-value: < 0.001
- 95% Confidence Interval: [-11.646, -6.859]

The robust estimate provides:
- 95% Confidence Interval: [-11.812, -6.117]
- z-statistic: -6.170
- p-value: < 0.001

#### What These Numbers Mean:
1. **Treatment Effect**: The conventional estimate suggests that the program is associated with a 9.252 percentage point decrease in school attendance. This effect is:
   - Statistically significant (p < 0.001)
   - Precisely estimated (relatively narrow confidence intervals)
   - Robust to bias correction (as shown by the robust estimates)

2. **Bandwidth Selection**: 
   - The analysis uses a Mean Square Error (MSE) optimal bandwidth selector ("mserd")
   - The main bandwidth (h) of 14.320 indicates that the analysis focuses on observations within ±14.320 points of the cutoff
   - The bias bandwidth (b) of 22.952 is used for bias correction
   - The ratio ρ (h/b) = 0.624 indicates a conservative bandwidth choice

## Sensitivity Analysis

### Bandwidth Sensitivity
The analysis uses the MSE-optimal bandwidth selector, which provides a data-driven approach to selecting the optimal bandwidth. The results show:
- Consistent bandwidth selection for both sides of the cutoff (14.320)
- Reasonable effective sample sizes (186 and 178 observations)
- A robust approach using triangular kernel weights

### Placebo Tests
Placebo tests were conducted at false cutoffs (30, 35, 45, 50) to verify the validity of the main results:
```
Cutoff 30: 3.138
Cutoff 35: 1.592
Cutoff 45: 0.114
Cutoff 50: -0.036
```

These results show:
1. No significant discontinuities at false cutoffs
2. Coefficients get smaller as we move away from the true cutoff
3. The pattern supports the validity of the main analysis

## Recommendations for Reporting

When reporting these results, consider:

1. **Main Effect**: Report the conventional estimate with its confidence interval:
   "The program is associated with a 9.25 percentage point decrease in school attendance (95% CI: [-11.65, -6.86], p < 0.001)"

2. **Robustness**: Mention the robust confidence interval to demonstrate the stability of results:
   "Results are robust to bias correction, with robust confidence intervals of [-11.81, -6.12]"

3. **Context**: Discuss the bandwidth selection and effective sample size to demonstrate the analysis's reliability

4. **Validity**: Include the placebo test results to support the causal interpretation

## Limitations and Considerations

1. **Bandwidth Choice**: While optimal, the bandwidth includes only about 36% of the total sample (364/1000 observations)

2. **Interpretation**: The negative effect is substantial and unexpected for a conditional cash transfer program, warranting further investigation into:
   - Program implementation
   - Potential confounding factors
   - Alternative mechanisms
   - Data quality and collection processes

3. **External Validity**: Results may not generalize beyond the specific context and population studied

## Next Steps

Consider additional analyses:
1. Exploring different functional forms
2. Testing for manipulation of the running variable
3. Examining heterogeneous effects
4. Conducting additional robustness checks with different bandwidth selectors