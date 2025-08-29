## Chemistry of stream water from the Luquillo Mountains

This repository presents visual representation of a) potassium, (b) nitrate-N, (c) magnesium, (d) calcium and (e) ammonium-N  ions before and after hurricane Hugo in Puerto Rico. Four watersheds namely Quebrada uno-Bisley (Q1), Quebrada dos-Bisley (Q2), Quebrada tres-Bisley (Q3) and Puente Roto Mameyes (PRM) at the Luquillo Mountain of Puerto Rico were taken as  a sample sites to calculate time-series plots of 9 weeks moving average from year 1988 to 1994.

All analysis were done on R Version 2025.05.1 using the following libraries tidyverse and janitor.

# Workflow

![Workflow diagram](Workflow.png)

# Contents

This repository contains the following documents
1. data = The folder includes all the raw data of the watersheds and helps you with the computation. The data can be accessed through <https://doi.org/10.6073/PASTA/F31349BEBDC304F758718F4798D25458>.
2. R = This folder contains the file with the codes that will run the full statistical and visual representation.
3. Output = This folder contains intermediate outputs in .rds file that will produce the expected output.
4. figs = This folder contains the visual representation that is derived from the raw data, and will run through the scripts in the folder R.

# References

McDowell, William H., and USDA Forest Service. International Institute Of Tropical Forestry (IITF). 2024. “Chemistry of Stream Water from the Luquillo Mountains.” Environmental Data Initiative.

Schaefer, Douglas. A., William H. McDowell, Fredrick N. Scatena, and Clyde E. Asbury. 2000. “Effects of Hurricane Disturbance on Stream Water Concentrations and Fluxes in Eight Tropical Forest Watersheds of the Luquillo Experimental Forest, Puerto Rico.” Journal of Tropical Ecology 16 (2): 189–207. <https://doi.org/10.1017/s0266467400001358>.
