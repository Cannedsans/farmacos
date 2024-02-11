require 'sinatra'
require_relative 'Banco'

get '/' do 
    banco = Banco.new 
    @remedios = banco.ler("Produtos")
    @cliente = banco.ler("cliente")
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
    @clientes = banco.ler("cliente")
    erb :compra
end 

post '/compra' do 
    banco = Banco.new
    
    remedio = params[:remedio]
    cliente = params[:cliente]

    banco.comprar(remedio,cliente)
    redirect '/'
end

post '/remedio' do 
    banco = Banco.new

    nome = params[:nome]
    descricao = params[:descricao]
    preco = params[:preco]

    banco.inserirProduto(nome,preco,descricao)

    redirect '/compra'
end

post '/cliente' do 
    banco = Banco.new 

    cpf = params[:CPF]
    nome = params[:nome]
    endereco = params[:adress]
    
    banco.inserirCliente(cpf,nome,endereco)

    redirect '/'
end
    

get '/clear' do
     banco = Banco.new
     banco.limpar
     redirect '/compra'
end 