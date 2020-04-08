

# Created by Easton White
# Last edited 24-March-2020

# Johns Hopkins CSSE group https://github.com/CSSEGISandData/COVID-19 recently changed how they formatted data starting on March 24th. This code manually pulls data from daily updates to compile raw data. The .Rmd file includes code to subset this for only US states

dates_to_extract <- seq(as.Date('03-01-2020',format='%m-%d-%y'),as.Date(substr(Sys.time(),1,10)),1)

# Set up data frame
covid = data.frame(Date = as.Date(character()),Province.State = as.character(), Country.Region = as.character(), Cases = as.numeric(),Deaths = as.numeric(), Recovered = as.numeric(), Latitude = as.numeric(), Longitude = as.numeric())

# Download and compile each daily report
for (id in 1:(length(dates_to_extract)-1)){

date_id <- format(dates_to_extract[id],'%m-%d-%Y')

single_day <- read.csv(paste('https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/',date_id,'.csv',sep = ''),header=T)
single_day$Date <- date_id

single_day <- single_day %>%
  select('Date',contains('Province'),contains('Country'),'Confirmed','Deaths','Recovered',contains('Lat'),contains('Long')) 
names(single_day) <- names(covid)

covid <- rbind(covid,single_day)

}


write.csv(file = 'RawDataFiles/CompiledCovidData_all_Countries.csv',x = covid ,quote=F)

