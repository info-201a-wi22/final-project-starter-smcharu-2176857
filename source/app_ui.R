library(shiny)
library(ggplot2)
library(plotly)
state_df <- read.csv("https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnytimes%2Fcovid-19-data%2Fmaster%2Fus-states.csv&filename=us-states.csv", header = TRUE, stringsAsFactors = FALSE)

# Define Page One

page_one <- 
  tabPanel(
    "Introducion" ,
    fluidPage(
      h1("Introduction"),
      img(
        src = "corona.png",
        height = 500, 
        width = 900
      ),
      p("This report dives into the ways the funding was handled and allocated 
        to hospitals during the start of the COVID-19 pandemic. We assess how 
        the funding of the CARES Act and the Paycheck Protection Program 
        and Health Care Enhancement Act and how that was handled. We want 
        our project to represent the data and how COVID-19 has impacted 
        the healthcare system as well as the economy."),
    )
  )

# Define Page Two
page_two <- 
  tabPanel(
    "Map",
    fluidPage(
h1("Hospitalization Funds and Hospitlaizations in the United States"),
p("This is a map of the United States that shows the amount of funds given to
  hospitals in each state through the Bipartisan CARES Act Paycheck 
  Protection Program and Health Enhancement Act and it also shows the number
  of hospitlizations per state. Based on the scale, you can see that the lighter 
  the blue is, the more hospital funds and hospitlization numbers the state 
  has gotten. Grayed out states are ones that do not have any accumulated data.
  One of our main research questions was surrounding the allocation
  of these funds and if they were done in an effective manner. When clicking 
  between the Funds and Patients option you can see that for a few states 
  there is not much of a differnce and this would mean that the funds were
  allocated in an effective manner. For example, California and Texas are 
  both light blue for both options which means that there was a meaningful 
  and effective allocation of funds. On the other hand, the amount of funds 
  that were allocated to New York is not proportional to the number of patients
  that they had. New York got almost 800 million dollars given to their 
  hosptials but only had around 40,000 patients hospitlized compared to other
  states that had more patients but got less funds. Another example is Illinois
  that got more than 800 million dollars in funds but had around 40,000 
  hospitlized patients."),
sidebarLayout(
  sidebarPanel(
    radioButtons(
      inputId = "value",
      label = h3("Type of Value"),
      choices = list("Funds (in Dollars)" = "total_funds", 
                     "Hospitilized Patients" = "state_total_patients"),
      selected = "total_funds"
    )
  ),
  mainPanel(
    plotlyOutput("map")
  )
)
    )
  )

# Define Page Three
page_three <-
  tabPanel(
    "Scatter Plot",
    fluidPage(
      titlePanel("Measurements of COVID-19 per state"),
      sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "state",
                      label = "Select A state",
                      choices = choice_states,
                      selected = "Washington"
          )
        ),
        mainPanel(plotlyOutput(outputId = "scatterplot"), 
        p("This scatterplot shows the number of cases versus deaths for 
        each state.Here looking at this data it can be seen that for each 
        state as cases are 
        still increasing continuously near the 
        end of the graph its evident that the plot flattens out 
        for each state near the end. This shows that less people 
        are dying, giving insight into the trajectory of COVID-19 in our 
        nation. Although cases are still prevalent the amount of deaths are 
        decreasing.Answering the question
        on how COVID-19 has progressed over time.
        This scatterplot shows us how COVID-19 has impacted each 
        state, being able to put a number to the exact amount of cases and 
        deaths shows impac, as it can be seen California had one of the
        highest numbers of cases. This chart can also be used in comparison with
        additonal data such as the map. This comparison can reveal if states with
        a high number of cases also have the highest number 
        of hospitalizations. " 

))
      )
    )
  )

page_four <- 
  tabPanel(
    "Summary",
    fluidPage( titlePanel("What to Take Away"),
      p("As can be seen, the main takeaways from the project are the analysis 
      regarding which states had the most funding, which states had the most 
      patients, and which state had the least funding. First, it is evident 
      that California, Texas, and Florida had the most patients hospitalized 
      with the number of people hospitalized being around 80,000. This is a 
      big number compared to the rest of the U.S. mostly had around 40-50,000
      people hospitalized per state. However, it is important to mention the 
      fact that Illinois was the state who had the most funding. Even though 
      they had 41,630 patients they received about 200,000,00 million dollars
      more than California. This helps us understand the allocation of funds
      better, as seen from the example above it is not based solely on the 
      number of patients being treated per state, if that were the case 
      California, Texas, and Florida would have the most funding. One has 
      to consider population size in this case, as the population size of 
      Illinois is much smaller than that of California. Hence, even though
      California had more patients when comparing it to their total population 
      of about 40 million people it isn't as dramatic as 41,000 people in a
      hospital with Illionos’s population size of 12 million. Another key
      takeaway to mention is that the number of cases will not always 
      translate to the number of hospitalizations. Showing that although 
      the number of cases shows the impact of COVID-19 for each state, it 
      is not sufficient to allocate funding primarily based on the number 
      of cases. This is because not all cases are considered fatal and in
      need of hospitalizations. This is evident in the fact that although
      California had the most cases but the state with the most amount of 
      patients was Florida. Providing insight on the fact that maybe the cases 
      in Florida were more severe than those in California resulting in more 
      hospitalizations.")
     
    )
  )
page_five <- 
  tabPanel(
    "Report",
    fluidPage(
      h1("Project Title: Aid to Impact"),
      h5("Authors: Niyat Efram, Rim Wolde, Saimanasvi Charugundla"),
      h5("Affiliation: INFO 201"),
      h5("Date: 3/9/2022"),
      h5("Key Words: Healthcare, Economy, Coronavirus, Law"),
      h3("Introduction"),
      p("Since the start of the coronavirus pandemic, policies have been 
        enacted to ease the financial pressure that hospitals and healthcare 
        providers on the front lines have been going through with the 
        increasing number of COVID-19 cases. Two acts that have provided 
        relief funds for hospitals and front-line workers all over the country 
        are the bipartisan CARES Act and the Paycheck Protection Program and 
        Health Care Enhancement Act. The goal of these bills is to replenish 
        the finances of hospitals around the country that have been drastically 
        impacted. In total, they have provided $175 billion in funds and have 
        been distributed in two rounds of payments to hospitals that have had 
        an influx of patients with the virus. Our project analyzes the data 
        represented in this dataset to better understand the effectiveness 
        of the relief funds and to also have an understanding of how COVID-19 
        has impacted the healthcare system as well as the economy."),
      h3("Design Situation"),
      h5("Project Framing:"),
      p("We are hoping to take this dataset and analyze the distribution of 
        funding and compare it to the impact of COVID-19 to get a clear picture 
        of the help that these healthcare providers received through the 
        funds."),
      h5("Human Values: "),
      p("The funding was given by the government through the CARES Act and the 
        Paycheck Protection Program and Health Care Enhancement Act allows for 
        security for all parts of healthcare systems such as the administration,
        hospitals, front-line workers, etc. Through these acts, the 
        United States government is giving charity to different hospitals all 
        over the country. The government is splitting up funds to each location 
        depending on the number of cases in the area and with this, they are 
        practicing equity."),
      h5("Direct Stakeholders:"),
      p("The United States Government, the U.S. Department of Health and 
        Human Services (HRSA), the Centers for Disease Control and 
        Prevention (CDC), and hospitals that have received aid. The U.S. 
        Government passed the two acts that provided funding for hospitals 
        around the country. The HRSA is the department that has collected the 
        data with the CDC being the organization that has federally funded this
        collection."),
      h5("Indirect Stakeholders:"),
      p(" Indirect Stakeholders would be individuals who were admitted into 
        hospitals that received funding through the CARES Act and the Paycheck 
        Protection Program and Health Care Enhancement Act as it would have 
        helped the patients. Along with this, the front-line workers are also 
        indirect stakeholders as they were given aid through the funding given 
        to them."),
      h5("Benefits:"),
      p("With the capacity and limits of hospitals and other healthcare systems 
        being pushed to the brim, the received financial aid eased the stress 
        and tension of front-line workers and saved the lives of individuals 
        who were admitted into overpopulated hospitals. The Paycheck Protection 
        Program and Health Care Enhancement Act provides $75 billion to support 
        the need for COVID-19 related expenses and losses. This dataset also 
        helps visualize which areas in the country got more funding compared to 
        other areas. With this visualization we can analyze the distribution of 
        funds and if it was done in an effective manner."),
      h5("Harms"),
      p(" When a viewer takes a look at this dataset, they might mistake this 
        dataset to be a record of the total amount of funding that these 
        healthcare administrators had received, rather than just the amount 
        of money that they received through these two Acts."),
      h3("Research Questions: How COVID-19 Impacted the Health Care System"),
      p("1. How were relief funds decided during the pandemic, 
        what were the criteria?"),
      p("2. Which states had the most patients?"),
      p("3. Which states were affected by the pandemic most?"),
      p("The questions are important because during the era of the COVID-19 
        pandemic, while population health was affected by skyrocketing death 
        rates, the economy was also an issue. There was a lack of finances in 
        the healthcare system with the large influx of infected people. The 
        motivation behind trying to find which states and cities were affected 
        by the pandemic the most was to figure out how the resources can be 
        better allocated. Within finding out what cities or states were 
        affected most, one can investigate what about them caused such high 
        rates, whether it be social inequity, poor financial standing, or 
        merely the fact that policies were not enacted. This is important as 
        it relates to the first questions about relief funds, in these states 
        and/or cities that were affected the most, what were the criteria in 
        determining the number of funds needed. Or vice versa, by seeing the 
        distribution of funds to cities one can answer the question of which 
        cities and states were affected most."),
      h3("The Dataset"),
      h5("SIZE AND COMPLEXITY:"),
      p("This data set consists of 6 features (columns) and more than 200 
        observations (rows). The data is taken from a national scale of the
        United States of America."),
      h5("Who or what is represented in the data?"),
      p("The data represents the quantitative impact of the bipartisan CARES
        Act and the Paycheck Protection Program and Health Enhancement Act, 
        by showing the number of funds given to hospitals around the nation.
        In terms of representation in the data, in an obvious sense, the 
        hospitals who treated COVID-19 patients are represented as they were 
        the ones who received the funds. In an analytical lens, this also 
        represents the impact that COVID-19 had on the healthcare system, 
        it represents the economic standing and need of these hospitals, which 
        can be correlated to the financial standing of the states in which they 
        are located."),
      h5("What is an observation? What variables are included (and excluded)?"),
      p("An observation represents the case in which characteristics are being 
        collected. A variable is what keys/attributes are being collected on 
        these observations. In this sense, an observation would be the rows, 
        which are the hospitals. The variables would be the columns which were: 
        the hospital names, the city of the hospital, the state it is located 
        in, the amount of money returned, the money given to them in the first 
        round of allocation, and finally the amount of money given during the 
        second round of allocation. The variables that were excluded would be 
        the number of patients being treated at the specific time of allocation. 
        Although all these hospitals had over 100 COVID-19 patients, it 
        excludes the amount in each hospital specifically."),
      h5("Who collected the data? When? For what purpose? How was the data 
         collection effort funded? Who is likely to benefit from the data or
         make money?"),
      p("The U.S Department of Health and Human Services (HRSA), collected the 
        data. In terms of who published the data, the data collection was 
        funded federally through the CDC, which pays great attention to all 
        aspects of the disease in the nation, including the economic impacts 
        of the disease. This data was collected through both resource 
        allocation periods which were throughout the year 2020, the data was 
        lastly updated in November 2020. The purpose of collecting this data 
        would be to represent the distribution of money and to also showcase 
        the economic impact of COVID-19. Looking at the number of money 
        hospitals needed to take care of patients, implies the severity of 
        the disease. The people more likely to benefit from the data would 
        be the government as they would be congratulated on giving money to 
        hospitals in need. However, the recognition they would benefit doesn't 
        suggest that anyone would make money from this data set, in fact, the 
        opposite."),
      h5("How was the data validated and held secure? Is it credible and 
         trustworthy?"),
      p("The data is validated in the terms that it came from a federal 
        institution, it was data essentially created by the government, which 
        in this society is taken to be validated because it would be coming 
        from a primary source. The data was about government funds, and the 
        data was recorded by the government, making it valid. In terms of 
        credibility, it is posted on the CDC database which goes to show that 
        it is true because the CDC is held to be one of the most respected 
        research databases."),
      h5("How did you obtain the data? Do you credit the source of the data?"),
      p("We obtained it through the “DATA.gov” website that the government has. 
        The website contains datasets from a range of subjects. We selected the 
        U.S. Department of Health which contained datasets concerning the 
        health and well-being of Americans, ranging from emergency release 
        funds to risk behavior in teens. After locating this data set, it led 
        us to the CDC website, we were then able to download the data from 
        there."),
      h3("Findings"),
      p("During the pandemic, funds were released to hospitals to 
        help assist with the floods of people and to ease financial 
        pressure off hospitals during the pandemic. When relief funds 
        started being handed out to individual hospitals, they were handed 
        out based on the amount of people they have. When diving deeper 
        into that, you see certain places such as New York and Illinois 
        who do not have that many patients receive a disproportionate amount 
        of funds, which leads to the reason why the data is supposed to show 
        some of the less meaningful funds that could have been distributed 
        elsewhere. When looking at the data, you see the states that were 
        affected the most in the U.S. were California, Texas and Florida. When 
        looking deeper into that, you see the trend of how states like Illinois 
        were given much more than a place with higher hospitalizations such as 
        Florida. In conclusion, we wanted our findings to show the 
        disproportionality in how the funds were distributed by state."),
      h3("Discussion"),
      p("When looking at the overall data and the work that was done to 
        show these findings in the data, I would say that the most important 
        thing that came out of this report was showing how the money that was 
        being distributed to hospitals and why some places received more than
        others and vice versa. During the pandemic the people suffered as well 
        as the economy. While the economy was not plummeting down, it was hard 
        to spread out money due to the amount of people that were contracting 
        the virus.
        One of our main goals was to show the disproportionate ways the funds
        were allocated and wanting to show this to help raise awareness and 
        raise questions as to why the policies that were first listed to 
        prevent this type of thing from happening were not being applied. 
        Things such as one’s economic status and things along those lines 
        could always be a factor of why funds were not distributed evenly and 
        it was a goal that our report can show the improper ways the funds 
        were allocated. The allocation of funds, while it does not seem like 
        a serious thing, could actually potentially changed some things such 
        as how certain cases could have been handled differently with some 
        extra help or how certain cases of COVID could have been prevented if 
        there was some extra financial assistance which then 
        would have led to more equipment and things along those lines."),
      h3("Conclusion"),
      p("In conclusion, our report was intended to show the common 
        trends and the mistakes that were made when allocating the funds 
        to hospitals around the country. We wanted to show the ties and how
        the pandemic led to not only the healthcare system being impacted 
        severely but also the economy and how that led to the findings in our 
        research that we now have in our report.")
      
    )
  )

# Define ui
ui <- (
  fluidPage(
    navbarPage(
      "Final Project",
      page_one,
      page_two, 
      page_three, 
      page_four,
      page_five
    )
  )
)
