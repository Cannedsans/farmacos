require 'sqlite3'

class Banco
  DATABASE_FILE = 'data/farmacia.db'

  def self.criar_banco
    SQLite3::Database.new(DATABASE_FILE) do |db|
      @db.execute <<-SQL 
      CREATE TABLE IF NOT EXISTS produtos(
        id integer PRIMARY KEY AUTOINCREMENT,
        nome text not null,
        preco float not null,
        descricao text
      );
        CREATE TABLE IF NOT EXISTS cliente(
            cpf VARCHAR(11) PRIMARY KEY,
            nome TEXT NOT NULL,
            endereco TEXT
        );
        CREATE TABLE IF NOT EXISTS pedido(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nomecliente TEXT NOT NULL, 
            produto INTEGER NOT NULL,
            criacao DATETIME DEFAULT CURRENT_TIMESTAMP
        );
      SQL
    end
  end

  def inserir()
    @db.execute()
  end 

  def ler()
    @db.execute()
  end

end

Banco.criar_banco
