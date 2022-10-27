### Improving Parking Meter Revenue by Prioritizing Street Maintinence Requests

My original goal for this project was to determine if street maintinence affects the revenue of parking meters. 
This idea came from my own experience parking in San Diego, dodging construction zones and avoiding potholes.
My approach was to use geospatial methods to combine the meter locations and maintinence requests using a proximity buffer. 
From there I was able to determine meter revenue before and after the maitenence request was closed. 
I used the difference between the pre and post revenues to create a categorical priority system. 
I applied a Hypothesis Test using the bootstrap to determine which maintinence request types were most valueable to be completed first. 
Lastly I trained some machine learning models to predict

The datasets used originate from San Diego's open data portal, links to datasets can be found below.

Parking Meter Locations: https://data.sandiego.gov/datasets/parking-meters-locations/ \
Parking Meter Transactions: https://data.sandiego.gov/datasets/parking-meters-transactions/ \
Get It Done Applications(Maintinence Requests): https://data.sandiego.gov/datasets/get-it-done-311/
