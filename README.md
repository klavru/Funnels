# Funnel Chart Analysis - E-Commerce Website

## Overview

This repository contains the analysis of user events from an e-commerce website to create a funnel chart and gain insights into user behavior and conversion rates. The primary goal is to understand how users progress through different stages of interaction on the website and identify areas for improvement.

## Task Description

The analysis begins with cleaning and processing the raw event data from the tc-da-1.turing_data_analytics.raw_events table. Duplicate events are removed to ensure the funnel analysis reflects unique user interactions. After this, the dataset is prepared for funnel analysis by selecting relevant events and focusing on the top three countries for comparison.

## Data Analysis

The analysis focuses on understanding user behavior and interactions on the e-commerce website using the tc-da-1.turing_data_analytics.raw_events table. Key steps include:

- **Data cleaning**: Removal of duplicate events based on the event timestamp.
- **Event selection**: Identification of relevant events for funnel analysis. In this case, events include 'session_start,' 'view_item,' 'add_to_cart,' 'begin_checkout,' and 'purchase.'

## Funnel Chart

The funnel chart is created based on the collected data. The funnel visualizes user progression through different events. The top three countries - the United States, India, and Canada - are compared to analyze any variations in user behavior.

<img width="1093" alt="image" src="https://github.com/klavru/Funnels/assets/128393456/09b239db-1794-4149-a276-6512ad3ec6fc">


## Insights

The analysis provides several key insights:

1. **Conversion Rates**: Conversion rates drop significantly as users progress through the funnel, from session start to purchase. Only a small percentage of users who visit the site complete a purchase. The Conversion Rate (COV%) is below 2%, which aligns with the typical COV% for e-commerce sites (average COV% for e-commerce is 2-3%).

- US: 1.66%
- India: 1.62%
- Canada: 1.77%

2. **View Item to Add to Cart**: The most substantial drop occurs between the "view_item" and "add_to_cart" events, indicating potential issues in product selection, pricing, or user engagement.
3. **Checkout to Purchase**: There is a significant drop from the "begin_checkout" to "purchase" event, suggesting that users encounter challenges during the checkout process.
4. **High-Intent Events**: The "view_item" and "add_to_cart" events show high user participation, but a drop in conversion rates indicates room for improvement in user experience.
5. **Country Differences**: User behavior and funnel performance are relatively consistent among the top three countries.

## Recommendations

Based on the insights, the following recommendations are provided:

1. **User Experience Enhancement**: Improve user experience at the "view_item" and "add_to_cart" stages to encourage more users to add items to their cart.
2. **Checkout Streamlining**: Simplify the checkout process to reduce friction, resolve payment issues, and provide a smoother experience.
3. **Conversion Rate Optimization (CRO)**: Implement CRO techniques to identify and address pain points in the user journey.
4. **Cart Abandonment Strategy**: Develop strategies to re-engage users who abandoned their carts.
5. **Payment Experience**: Ensure a seamless payment process with multiple payment options.
6. **Retargeting and Remarketing**: Re-engage users who dropped off at different funnel stages.
7. **A/B Testing**: Conduct A/B tests on critical funnel steps to optimize the user journey.
8. **Customer Support**: Provide accessible customer support during checkout.
9. **Mobile Optimization**: Ensure a mobile-friendly website.
10. **Localized Strategies**: Tailor strategies to the specific needs of users in different countries.
11. **Churn Analysis**: Conduct further analysis to understand and address the reasons for user churn at different funnel stages.

By implementing these recommendations and further analyzing user behavior, the aim is to improve conversion rates and user experience on the e-commerce platform.
