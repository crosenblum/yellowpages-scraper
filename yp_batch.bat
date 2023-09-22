@echo off
setlocal
rem yellow page local download
rem craig m. rosenblum

rem set variables
set categories=Accountants,Architects,Attorneys,Auto Repair Shops,Banks,Beauty Salons,Car Dealerships,Caterers,Clothing Stores,Computer Repair Services,Contractors,Daycare Centers,Dentists,Doctors,Dry Cleaners,Electricians,Fitness Centers,Florists,Furniture Stores,Garden Centers,Grocery Stores,Hair Salons,Hardware Stores,Home Improvement Stores,Hotels,Insurance Agents,Jewelry Stores,Landscapers,Locksmiths,Notaries,Pest Control Services,Pet Grooming,Photographers,Plumbers,Printers,Real Estate Agents,Restaurants,Towing Services,Travel Agencies,Veterinarians
set first=1
set location=Burnsville,MN

rem loop thru each category
for %%a in (%categories%) do (

	rem which category am I working on
	echo -[ %%a ]-
	
	rem download all data for this category in burnsville
	python yellow_pages.py %%a %location% >nul 2>&1
	
	rem rename files for my purposes
	rem category-location-yellowpages-scraped-data.csv
	
	rem line break
	echo.
	
)

rem create merged csv file
>new.csv.tmp (
  for %%F in (*.csv) do (
    if defined first (
      type "%%F"
      set "first="
    ) else more +1 "%%F"
  )
)
ren new.csv.tmp new.csv

rem delete all other csv files
for %%f in (*.csv) do (

	rem check if file is new.csv
	if "%%f" neq "new.csv" (
	
		del "%%f" /f /q
		
	)
	
)

rem date time stamp summary file name
ren new.csv "companies_%DATE:~4,2%%DATE:~7,2%%DATE:~-4%.csv"
