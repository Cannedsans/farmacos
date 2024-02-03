require 'sinatra'
require_relative 'Banco'

@banco = Banco.new 

get '/' do 
    erb :index
end 