119th Congress District-Level Data (Demographic, Economic, Language and Partisan)

## RDH Date Retrieval
7/26/2024

## Sources
119th Congressional Block-Assignment File (https://redistrictingdatahub.org/dataset/119th-congressional-districts-and-block-assignment-file-nov-2024-election-active-jan-2025-jan-2027/)

U.S. Census Bureau 2020 PL, DHC and 2022 ACS Data via RDH Website

Voting Election Science Team for 2020 Election Results, Disaggregated to 2020 Blocks by RDH

## Fields:
Field Name                                             Description                                                                                                                                      
CONG119                                                119th Congressional District                                                                                                                     
STATE                                                  State                                                                                                                                            
DISTRICT                                               District                                                                                                                                         
TOTPOP20                                               Total 2020 Population (2020 PL Data)                                                                                                             
NH White                                               Non-Hispanic White (2020 PL Data)                                                                                                                
NH Black plus NH Black and White                       Non-Hispanic Black plus Non-Hispanic Black and White (2020 PL Data)                                                                              
NH Asian plus NH Asian and White                       Non-Hispanic Asian plus Non-Hispanic Asian and White (2020 PL Data)                                                                              
NH American Indian plus NH American Indian and White   Non-Hispanic American Indian plus Non-Hispanic American Indian and White (2020 PL Data)                                                          
NH Pacific Islander plus NH Pacific Islander and White Non-Hispanic Pacific Islander plus Non-Hispanic Pacific Islander and White (2020 PL Data)                                                        
NH Some Other Race plus NH Some Other Race and White   Non-Hispanic Some Other Race plus Non-Hispanic Some Other Race and White (2020 PL Data)                                                          
NH Other multiple-race                                 Non-Hispanic Other multiple-race (2020 PL Data)                                                                                                  
Hispanic                                               Hispanic Population (2020 PL Data)                                                                                                               
TOT_HOUSE22_est                                        Estimated Total Number of Households (2022 ACS)                                                                                                  
LESS_10K22_est                                         Estimated households with less than $10,000 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)            
10K_15K22_est                                          Estimated households with between $10,000 and $14,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)  
15K_20K22_est                                          Estimated households with between $15,000 and $19,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)  
20K_25K22_est                                          Estimated households with between $20,000 and $24,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)  
25K_30K22_est                                          Estimated households with between $25,000 and $29,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)  
30K_35K22_est                                          Estimated households with between $30,000 and $34,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)  
35K_40K22_est                                          Estimated households with between $35,000 and $39,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)  
40K_45K22_est                                          Estimated households with between $40,000 and $44,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)  
45K_50K22_est                                          Estimated households with between $45,000 and $49,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)  
50K_60K22_est                                          Estimated households with between $50,000 and $59,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)  
60K_75K22_est                                          Estimated households with between $60,000 and $74,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)  
75K_100K22_est                                         Estimated households with between $75,000 and $99,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)  
100_125K22_est                                         Estimated households with between $100,000 and $124,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)
125_150K22_est                                         Estimated households with between $125,000 and $149,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)
150_200K22_est                                         Estimated households with between $150,000 and $199,999 in household income in the past 12 months (in 2022 inflation-adjusted dollars) (2022 ACS)
200K_MOR22_est                                         Estimated households with more than $200,000 in household income in the past 12 months (in 2022 inflation-adjusted dollars)                      
Median_HH_Income                                       Estimated Median Household Income Based off of Estimated Income Range Counts (2022 ACS)                                                          
BACH_PLUS_pct                                          Estimated Percent of 25+ Population with Bachelor's Degree or Higher (2022 ACS)                                                                  
FOREIGN_BORN_pct                                       Estimated Foreign Born Population Percentage, out of Total (2022 ACS)                                                                            
ENG_LW_pct                                             Estimated Population Speaking English "Less Than Very Well", out of Total (2022 ACS)                                                             
PRES20_Total                                           Estimated Total 2020 Presidential Votes (3-party)                                                                                                
G20PREDBID_pct                                         Estimated Biden Support Percentage (3-party share)                                                                                               
G20PRELJOR_pct                                         Estimated Jorgensen Support Percentage (3-party share)                                                                                           
G20PRERTRU_pct                                         Estimated Trump Support Percentage (3-party share)                                      

## Processing Steps
Block-level population data from the 2020 P.L. census data release was gathered for every state and then aggregated to the 119th Congressional Districts using a block-assignment file. 

2022 ACS household income was originally available at the block-group level and consists of counts of households in the following income ranges: <10k, 10-15k, 20-25k, 25k-30k, 30-35k, 35-40k, 40-45k, 45-50k, 50-60k, 60-75k, 75-100k, 100-125k, 125-150k, 150k-200k and 200k+. This data was disaggregated from the block group level to the block-level based one each block's share of the total number of occupied housing units within the block group, resulting in an estimate of household counts in each of the ranges of incomes in each block. These counts are then aggregated up to the district-level using a block-assignment file. An estimated median income value was also calculated, based on the counts of households in each category is present above. For example, if a district had 2.2 households between 20-25k, 1 household between 35-40k and 2.5 households between 60k-70k, the median would be 35-40k. Ties go to the lower range. All values are in 2022 inflation-adjusted dollars.

​Language and foreign born population data was first disaggregated from the tract level to the block-level using total population at the block, and education was disaggregated from the block-group level to the block level using 25+ population. For all ACS data disaggregations, if there were any cases were there was data at the block group / tract in the data to disaggregate but not in the PL data with which I was creating a ratio, values were disaggregated proportionally across the relevant geography.

Election results data was initially retrieved from Voting Election Science Team (VEST) and disaggregated to the block-level using each block's population of non-incarcerated voting-age population. This data was joined to a block-assignment file and aggregated to the district-level.

Lastly, data was all aggregated to the 119th Congressional Districts using a block-assignment file.

Any blocks that are not assigned to a district have 0 total population and are filtered out of the final file.

Please note that some states used adjusted population data when drawing their congressional districts (https://redistrictingdatahub.org/reports/states-that-adjust-the-census-data-for-redistricting/), the data in this file is unadjusted, and as such, district-population deviations based on total population may be incorrect.

Please direct questions related to processing this dataset to info@redistrictingdatahub.org.