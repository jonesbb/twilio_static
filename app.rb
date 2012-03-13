require 'sinatra'
require 'builder'

get '/index' do
      File.read(File.join('public', 'index.html'))
end

get '/hello' do
  "Hello, world!"
end

get '/public/twilio_tides.rb' do
      File.read(File.join('public', 'twilio_tides.rb'))
end


post '/' do
  builder do |xml|
    xml.instruct!
    xml.Response do
      xml.Sms("Hello from my Heroku app")
    end
  end
end