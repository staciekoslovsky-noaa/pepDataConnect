# pepDataConnect
Welcome to the GitHub site for the pepDataConnect R Package. This package is intended to serve as a direct gateway to the Polar Ecosystems 
Program centralized PostgreSQL database. There is a function to set up a connection to the database (pep_connect), and there are functions for 
loading each of the data sets stored within the database (matching the names of the schemas.tables in the database). This is the preferred method for extracting data from the database into R, because each of the functions pull the properly formatted data into R, taking into consideration time zones, spatial data formats, and other unique considerations for each table. Currently, this package only works to connect to the surv_jobss schema. Other schemas will be added in time.

To work with this package, you need to ensure you have an .Renviron file stored in your Documents folder on your computer. Either request one from stacie.hardy@noaa.gov OR make your own in Notepad++. The final format of the file is as follows:
pep_ip = (as provided)
pep_db = pep
pep_user = (as provided)
user_pw = (as provided)

Once this file is stored in the proper location, you need in install the pepDataConnect package from GitHub. To do this, open an RStudio window. In the console, enter the following code:
	remotes::install_github('staciekozhardy/pepDataConnect')
You will be prompted to install or update the requiste packages. Following the steps on screen, as appropriate for your computer. 

Once the package is installed, you can use it within RStudio sessions as you would any other package moving forward.

For now, this package will be under a great deal of development, as new datasets are added. Until this warning is removed, I encourage you to update this package at least once a week.

If there are specific data tables you'd like prioritized to be added to this package next, please submit those requests here: pepDataConnect_Updates+Improvements[https://github.com/users/StacieKozHardy/projects/4]
