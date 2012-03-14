#!/usr/bin/env ruby


###########################################################
# created on 3/12/12 by Byron Jones
# Name: twilio_tides.rb
# Function: Reads in NOAA xml file with 2012 tide data
#           and creates a class variable string to pass
#           into a Twilio voice app.
#
###########################################################

require 'rubygems'
require 'hpricot'
require 'builder'


# Get Today's Date in yyyy/mm/dd format
t=Time.now
cdate = t.strftime("%Y/%m/%d")


# Read in the tides xml file
xml = File.read('public/9410840_2012_tides.xml')


# Initiate the variable, prepending an intro.
@tide_today = ["Today's Tides are as follows:"]


# Find the tide info for today's date
# There's usually more than one hi/lo for a day, so push all into an array
doc = Hpricot::XML(xml)
(doc/:item).each do |dat|
    tide_date = (dat/'date').inner_html
    tide_time = (dat/'time').inner_html
    tide_size = (dat/'predictions_in_ft').inner_html
    tide_hilo = (dat/'highlow').inner_html
    if tide_date == cdate then
        if tide_hilo == "H" then
            tide_hilo = "high"
        elsif tide_hilo == "L" then
            tide_hilo = "low"
        end
      @tide_today << "#{tide_hilo} tide, #{tide_size}feet at #{tide_time}"
    end
end

# Join the array into one string
@@tide_today = @tide_today.map! { |p| "#{p}" }.join(", ")
#puts @@tide_today  # debug line to print value

# Length check (must be < 160 characters) for SMS
#puts @@tide_today.length   # debug line to print length





