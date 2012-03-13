#!/usr/bin/env ruby
#
#
#############
# created on 3/12/12 by Byron Jones
#
#

require 'rubygems'
require 'hpricot'
require 'twilio-ruby'
require 'sinatra'
require 'builder'

# Get Today's Date in yyyy/mm/dd format
t=Time.now
cdate = t.strftime("%Y/%m/%d")


# Read in the tides xml file
xml = File.read('9410840_2012_tides.xml')


# Initiate the variable to send in the SMS
@tide_today = ["Today's Tides"]

# Find the tide info for today's date
# There's usually more than one hi/lo for a day, so push all into an array
doc = Hpricot::XML(xml)
(doc/:item).each do |dat|
    tide_date = (dat/'date').inner_html
    tide_time = (dat/'time').inner_html
    tide_size = (dat/'predictions_in_ft').inner_html
    tide_hilo = (dat/'highlow').inner_html
    if tide_date == cdate then
      @tide_today << "#{tide_time}, #{tide_size}ft(#{tide_hilo})"
    end
end

# Join the array into one string
@tide_today = @tide_today.map! { |p| "#{p}" }.join("%0d")
#puts @tide_today





