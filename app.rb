require 'sinatra'
require 'builder'

# Define the route for the index.html - static homepage for the app
get '/' do
      File.read(File.join('public', 'index.html'))
end

# Setup a test of the tides script
get '/hello' do
  puts "Hello, world!"
  load 'public/twilio_tides.rb'
  puts "Here's tide info: #{@@tide_today}"

end

# Define a method that accepts both post and get requests
# This is useful because of the /loop redirect to /tides
def get_or_post(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end


# Create the TwiML response to read out the tide data
get_or_post '/tides' do
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
    if !params['Digits'] or params['Digits'] != '1'
        builder do |xml|
              xml.instruct!
              xml.Response do
                xml.Say("C-h-o-w-w.")
              end
        end
    else
      redirect '/tides'
    end
end 
