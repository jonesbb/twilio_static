This is a Twilio demo application

Function:
Tells the caller what the Santa Monica Tides are for that particular day,
and give the caller the option to repeat the info or hangup.

Components:
1) Started with a quick-start skeleton for one page static sites on Heroku.
This is a basic cloud hosting tool using Heroku and Sinatra.
Credit to Dan Pritchett for this skeleton app. http://github.com/dpritchett/wwebsite

2) Wrote a ruby script to interpret the tide data from a xml file.
The xml source is a downloaded table of tides for 2012 found at this website:
http://co-ops.nos.noaa.gov/noaatidepredictions/NOAATidesFacade.jsp?Stationid=9410840

3) Filled in the skeleton app.rb with Twilio get/post commands to control the voice app

A description of assembling this app is at:
http://hacking-idiot.blogspot.com/2012/03/how-to-make-twilio-voice-app-hosted-by.html