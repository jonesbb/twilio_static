require 'sinatra'
require 'builder'

# Define the route for the index.html
get '/' do
      File.read(File.join('public', 'index.html'))
end

# Setup a test of the tides script
get '/hello' do
  puts "Hello, world!"
  load 'public/twilio_tides.rb'
  puts "Here's tide info: #{@@tide_today}"

end

# Create the TwiML response to read out the tide data
post '/reply' do
  load 'public/twilio_tides.rb'
  builder do |xml|
    xml.instruct!
    xml.Response do
            xml.Say("Hi #{@@tide_today}")
            xml.Gather(:action=>"/loop", :numDigits => 1) do
                  xml.Say("Press one to repeat or two to end this call.")
            end
    end
  end
end

# Loop the caller's feedback
post '/loop' do
    if params['Digits'] != '1'
        builder do |xml|
              xml.instruct!
              xml.Response do
                xml.Say("Caio")
              end
        end
    else
      redirect '/reply'
    end
end 