require 'sinatra'
require_relative 'Banco'

@banco = Banco.new 

get '/' do 
    erb :index
end 

get '/styles.css' do 
    scss :styles
end

get '' do
     
end 