require 'sinatra'
require 'builder'

get '/' do
      File.read(File.join('public', 'index.html'))
end

get '/hello' do
  puts "Hello, world!"
  load 'public/twilio_tides.rb'
  puts "Here's tide info: #{@@tide_today}"

end

get '/public/twilio_tides.rb' do
      File.read(File.join('public', 'twilio_tides.rb'))
end


post '/test' do
  builder do |xml|
    xml.instruct!
    xml.Response do
      xml.Say("Hello from my Heroku app")
      xml.Sms("Hello from my Heroku app")
    end
  end
end

post '/reply' do
  load 'public/twilio_tides.rb'
  builder do |xml|
    xml.instruct!
    xml.Response do
          xml.Say("Hi #{@@tide_today}")
    end
  end
end