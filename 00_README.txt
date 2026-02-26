Replication materials for:
Identifying barriers to Muslim integration in France
Claire L. Adida, David D. Laitin, and Marie-Anne Valfort
PNAS (2010) 107(52): 22384–22390
https://doi.org/10.1073/pnas.1015550107

Contact:
- Claire L. Adida (cadida@stanford.edu) 
- David D. Laitin (dlaitin@stanford.edu)

-----------------------------------------------------------------------
Overview
-----------------------------------------------------------------------
This replication package reproduces the main analyses, tables, and figures reported in Adida, Laitin, and Valfort (2010), “Identifying barriers to Muslim integration in France.”

The package contains:
1) Data files used in the analyses (Stata .dta format)
2) Original Stata replication materials (do-files and .smcl log files) for both:
   a) the CV (résumé audit) experiment analyses, and
   b) the survey analyses
3) R code to reproduce the CV (résumé audit) experiment analyses
4) R code to reproduce the survey analyses (OLS and ordered probit models)
5) R code to reproduce the paper’s figures (Figure 1, Figure 2a, Figure 2, and Figure 3)
6) Expected output images used to verify that results match the published paper and the original Stata outputs.

All primary analyses in this replication package are executed in R. The original Stata scripts and log files are included for reference and verification.

-----------------------------------------------------------------------
Table of Contents
-----------------------------------------------------------------------

Documentation / Reference
- README.txt ................................ This file
- Original Stata Do & Log Files/ ............. Original Stata scripts and logs
  - SurveyDataForPNAS.do ..................... Original Stata do-file for survey analyses
  - 2009Dec17CLA_CV.do ....................... Original Stata do-file for CV experiment analyses
  - CVAnalysisDec2009.smcl ................... Stata log file for CV experiment analyses

Data
- data/raw/OriginalData.dta .................. CV experiment dataset (raw)
- data/raw/NewAdidaCoding.dta ................ Corrected outcome coding for CV experiment (raw)
- data/raw/SurveyData.dta .................... Survey dataset used for Tables 2 and A4 (raw)

Code
- ALV_PNAS_Reproduction.Rmd .................. Master code (runs all analyses end-to-end)
- code/00_setup.R ............................ Set-up script shared by the following files 
- code/01_cv_analysis.Rmd .................... CV experiment replication
- code/02_survey_analysis.Rmd ................ Survey analyses replication (OLS, Table 2, Table A4)
- code/03_figures.Rmd ........................ Figure replication scripts

Outputs
- results/tables/cv/ .......................... CV output tables saved as PNG pages
- results/tables/sv/ .......................... Survey output tables saved as PNG pages
- results/figures/ ............................ Replicated figures (JPG)

-----------------------------------------------------------------------
Data Availability 
-----------------------------------------------------------------------
This replication package includes the analysis datasets in Stata (.dta) format:

1) OriginalData.dta
   - Description: CV (résumé audit) experiment dataset (paired applications to employers).
   - Used for: CV experiment analyses in Part 1 (summary stats, t-tests, logit models).

2) NewAdidaCoding.dta
   - Description: Corrected coding of the CV experiment outcome variable (newresult).
   - Used for: Replacing/merging corrected outcomes before constructing ControlWins/TestWins.

3) SurveyData.dta
   - Description: Survey dataset used for Part 2 analyses (income outcomes and covariates).
   - Used for: OLS income regression; Table 2 ordered probit models; Table A4 ordered probit model and predicted probabilities.

The original Stata do-file(s) used for the published analyses are included in:
- Original Stata Do & Log Files/

-----------------------------------------------------------------------
Software Requirements
-----------------------------------------------------------------------
R (tested on a Mac; version may vary depending on your environment)

Required R packages:
- broom
- dplyr
- ggplot2
- grid
- gridExtra
- haven
- here
- lmtest
- MASS
- ordinal
- purrr
- sandwich
- stringi
- stringr
- tibble
- tidyr

Note: The replication code installs missing packages automatically when run.

-----------------------------------------------------------------------
How to Reproduce Results
-----------------------------------------------------------------------

1) Download the replication folder.

2) Set the working directory to the root of the replication folder.
   IMPORTANT: The code should use relative paths (preferred).
   If using an absolute path, you must edit it to match your system.

3) Run the master script to reproduce ALL outputs:
   - Using the provided R Markdown:
       Render "ALV_PNAS_Reproduction.Rmd" from RStudio

Outputs will be written to:
- results/tables/cv/   (CV tables as PNG pages)
- results/tables/sv/   (Survey tables as PNG pages)
- results/figures/     (Figures 1–3)

-----------------------------------------------------------------------
What Each Script Produces
-----------------------------------------------------------------------

1) CV Experiment (Part 1)
- Inputs:
  - data/raw/OriginalData.dta
  - data/raw/NewAdidaCoding.dta
- Outputs:
  - results/tables/cv/summary_C1_*.png
  - results/tables/cv/ttests_C1_*.png
  - results/tables/cv/logits_C1_*.png
  - (and similarly for C2 and C3 codings)
- Notes:
  - The code reproduces 3 outcome codings (C1, C2, C3) and runs: summary statistics, Welch t-tests, and logit models with robust SEs.
  - For the interaction model, the code handles Stata-like separation behavior(dropping interact and interact!=0 observations when perfect prediction occurs).

2) Survey Analyses (Part 2)
- Inputs:
  - data/raw/SurveyData.dta
- Outputs:
  - results/tables/sv/OLS_robust_*.png
  - results/tables/sv/Table2_oprobit_robust_*.png
  - results/tables/sv/Table2_fit_stats_*.png
  - results/tables/sv/TableA4_oprobit_robust_*.png
  - results/tables/sv/TableA4_fit_stats_*.png
  - results/tables/sv/TableA4_predprob_*_*.png
- Notes:
  - OLS uses HC0 robust SEs.
  - Ordered probit models are estimated using ordinal::clm with a probit link.
  - Robust SEs for ordered probit are computed using a sandwich estimator
    designed to match Stata's robust variance (Huber-White).

3) Figures (Part 3)
- Outputs:
  - results/figures/PNAS2010ALVTable1.jpg   (Figure 1 replication)
  - results/figures/ALVPNASCVResultsFig2a.jpg (Figure 2a replication)
  - results/figures/ALVPNASCVResultsGraph2.jpg (Figure 2 replication)
  - results/figures/PNAS2010ALVTable3.jpg   (Figure 3 replication)

-----------------------------------------------------------------------
Notes
-----------------------------------------------------------------------
- If you see path errors, confirm the working directory is set to the replication root.
- The output file formats are images (JPG) to facilitate direct comparison with original published tables/figures and Stata outputs.
- Minor differences in floating point rounding may occur depending on R versions; key coefficients, robust SEs, R-squared values should otherwise match the paper and original Stata outputs.

-----------------------------------------------------------------------
Citation
-----------------------------------------------------------------------
C.L. Adida, D.D. Laitin, & M. Valfort, Identifying barriers to Muslim integration in France, Proc. Natl. Acad. Sci. U.S.A. 107 (52) 22384-22390, https://doi.org/10.1073/pnas.1015550107 (2010).