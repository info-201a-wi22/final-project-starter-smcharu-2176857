funds_df <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
hospital_df <- read.csv("https://api.covidtracking.com/v1/states/current.csv", header = TRUE, stringsAsFactors = FALSE)

library("dplyr")
library("tidyr")

# DATA WRANGLING
# Getting rid of commas and dollar signs in X1st.Round.Payment
funds_df$X1st.Round.Payment <- c(funds_df$X1st.Round.Payment)
funds_df$X1st.Round.Payment <- gsub("[$,]", "", funds_df$X1st.Round.Payment)
funds_df$X1st.Round.Payment <- as.numeric(funds_df$X1st.Round.Payment)

# Getting rid of commas and dollar signs in X2nd.Round.Payment
funds_df$X2nd.Round.Payment <- c(funds_df$X2nd.Round.Payment)
funds_df$X2nd.Round.Payment <- gsub("[$,]", "", funds_df$X2nd.Round.Payment)
funds_df$X2nd.Round.Payment <- as.numeric(funds_df$X2nd.Round.Payment)

# Data Frame with total sum of payment for each state
df1_state <- funds_df %>%
  group_by(State) %>%
  select(-c(Returned..1st.Payment.)) %>%
  summarize(
    first_round_payment = sum(X1st.Round.Payment, na.rm = TRUE),
    second_round_payment = sum(X2nd.Round.Payment, na.rm = TRUE)
  )

# Renaming column "state" to "State"
hospital_df <- hospital_df %>%
  rename(State = state)

# Combining df1 and df2
combined_data <- left_join(df1_state, hospital_df, by = c("State"))
combined_data <- combined_data %>%
  mutate(total_payment = first_round_payment + second_round_payment)
#
#
#
#
#
#
#
#
# List of computed information about Datasets
summary_info <- list()

# Value 1: Calculates state that received most funding
summary_info$most_funding <- combined_data %>%
  filter(total_payment == max(total_payment)) %>%
  pull(State)

# Value 2: Calculates state that received least funding
summary_info$least_funding <- combined_data %>%
  filter(total_payment == min(total_payment)) %>%
  pull(State)

# Value 3: State with most hospitalized patients
summary_info$most_patients <- combined_data %>%
  filter(hospitalizedCumulative
         == max(hospitalizedCumulative, na.rm = TRUE)) %>%
  pull(State)

# Value 4: State with least hospitalized patients
summary_info$least_patients <- combined_data %>%
  filter(hospitalizedCumulative
         == min(hospitalizedCumulative, na.rm = TRUE)) %>%
  pull(State)

#Value 5: Total Funding given to all states
summary_info$total_funding <- combined_data %>%
  summarize(total = sum(total_payment)) %>%
  pull(total)

#Value 6: State with most positive cases
summary_info$most_positive_cases <- combined_data %>%
  filter(positive == max(positive, na.rm = TRUE)) %>%
  pull(State)

#Value 7: State with least positive cases
summary_info$least_positive_cases <- combined_data %>%
  filter(positive == min(positive, na.rm = TRUE)) %>%
  pull(State)

