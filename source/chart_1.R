funds_df <- read.csv("https://data.cdc.gov/api/views/b58h-s9zx/rows.csv?accessType=DOWNLOAD", header = TRUE, stringsAsFactors = FALSE)
library("dplyr")
library("tidyr")
library("ggplot2")

#DATA WRANGLING
funds_df$X1st.Round.Payment <- c(funds_df$X1st.Round.Payment)
funds_df$X1st.Round.Payment <- gsub("[$,]", "", funds_df$X1st.Round.Payment)
funds_df$X1st.Round.Payment <- as.numeric(funds_df$X1st.Round.Payment)

#getting rid of commas and dollar signs in X2nd.Round.Payment
funds_df$X2nd.Round.Payment <- c(funds_df$X2nd.Round.Payment)
funds_df$X2nd.Round.Payment <- gsub("[$,]", "", funds_df$X2nd.Round.Payment)
funds_df$X2nd.Round.Payment <- as.numeric(funds_df$X2nd.Round.Payment)

df_chart_1 <- funds_df %>%
  group_by(State) %>%
  select(-c(Returned..1st.Payment.)) %>%
  summarize(
    first_round_payment = sum(X1st.Round.Payment, na.rm = TRUE),
    second_round_payment = sum(X2nd.Round.Payment, na.rm = TRUE)
  ) %>%
  mutate(total_payments = first_round_payment + second_round_payment)

#
#
#
#

## Bar Chart that shows the total funds given for each state. You can see the
# amount of money that each state got and how it is compared to the rest
# of them.

chart_1 <- ggplot(data = df_chart_1) +
  geom_col(mapping = aes(x = State, y = total_payments)) +
  labs(
    title = "Total Number of Fuwnds for Each State",
    x = "State",
    y = "Total Funds Given"
  ) + theme(axis.text.x = element_text(angle = 90))