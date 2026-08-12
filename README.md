# French Housing Price Determinants

Quantified a 1,083€/m² urban premium in the French housing market and rejected
the 2,500€/m² market consensus at p < 0.001, using statistical inference in R
across 30,892 municipalities.

Joint project with Julian Ansarinasab — Université Paris-Dauphine, December 2025.

## Key results

- **National average price:** 1,935.30€/m² (95% CI: [1924.26 ; 1946.33], margin of error €11)
- **Market consensus rejected:** t = −100.32, p < 0.001 against the 2,500€/m² reference
- **Urban premium:** 1,083€/m² (95% CI: [1020.42 ; 1145.47]), Welch t-test
- **Unemployment–price dependence:** χ² = 666.44, df = 4, p < 0.001

## Repository structure

- `report/` — final PDF report
- `src/analysis.Rmd` — full statistical analysis
- `src/merge_databases.R` — builds the final dataset from the raw sources
- `data/Base_Finale.xlsx` — merged dataset (30,892 municipalities)

## Data sources

Raw source files are not included in this repository. They are publicly available:

- [Real estate prices per m² — Data.gouv](https://www.data.gouv.fr/datasets/indicateurs-immobiliers-par-commune-et-par-annee-prix-et-volumes-sur-la-periode-2014-2024/)
- [Socio-economic indicators — INSEE](https://www.insee.fr/fr/statistiques/2521169)
- [Urban/rural density grid — INSEE](https://www.insee.fr/fr/information/6439600)

## Methods

Point and interval estimation, one-sample t-test, F-test for equality of
variances, Welch two-sample t-test, chi-square test of independence.

## Requirements

R with `readxl`, `dplyr`, `kableExtra`, `ggplot2`.
