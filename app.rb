require 'sinatra'
require_relative 'Banco'

get '/' do 
    erb :index
end 

get '/styles.css' do 
    scss :styles
end

get '/cadastro' do
    banco = Banco.new 
    @remedios = banco.ler("Produtos")
     erb :cadastro
end 

get '/clientes' do 
    banco = Banco.new 
    @cliente = banco.ler("cliente")
    erb :clientes
end

get '/compra' do
    banco = Banco.new 
    @pedidos = banco.pedidos
    @remedios = banco.ler("Produtos")
    @clientes = banco.ler("cliente")
    erb :compra
end 

get '/comprar' do 
    banco = Banco.new
    
    remedio = params[:remedio]
    cliente = params[:cliente]

    banco.comprar(remedio,cliente)
    redirect '/compra'
end

post '/remedio' do 
    banco = Banco.new

    nome = params[:nome]
    descricao = params[:descricao]
    preco = params[:preco]

    banco.inserirProduto(nome,preco,descricao)

    redirect '/cadastro'
end

post '/cliente' do 
    banco = Banco.new 

    cpf = params[:CPF]
    nome = params[:nome]
    endereco = params[:adress]
    
    banco.inserirCliente(cpf,nome,endereco)

    redirect '/clientes'
end
    

get '/clear' do
     banco = Banco.new
     banco.limpar
     redirect '/'
end 