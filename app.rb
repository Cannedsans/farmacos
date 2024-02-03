require 'sinatra'

get '/' do 
    erb :index
end 

get '/styles.css' do 
    scss :styles
end