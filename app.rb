require 'sinatra'
require_relative 'Banco'

get '/' do 
    erb :index
end 

get '/styles.css' do 
    scss :styles
end

get '/cadastro' do
     erb :cadastro
end 

get '/clientes' do 
    erb :clientes
end

get '/compra' do
    banco = Banco.new 
    @remedios = banco.ler("Produtos")
    erb :compra
end 

post '/remedio' do 
    banco = Banco.new

    nome = params[:nome]
    descricao = params[:descricao]
    preco = params[:preco]

    banco.inserir(nome,preco,descricao)

    redirect '/'
end
    