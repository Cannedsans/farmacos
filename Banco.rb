require 'sqlite3'

class Banco
  DATABASE_FILE = 'data/farmacia.db'

  def self.criar_banco
    db = SQLite3::Database.new(DATABASE_FILE)
    criar_tabelas(db)
    db.close
  end

  def self.criar_tabelas(db)
    db.execute <<-SQL 
      CREATE TABLE IF NOT EXISTS produtos (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          preco FLOAT NOT NULL,
          descricao TEXT
      );
      SQL
      db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS cliente (
          cpf VARCHAR(11) PRIMARY KEY,
          nome TEXT NOT NULL,
          endereco TEXT
      );
      SQL
      db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS pedido (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nomecliente TEXT NOT NULL, 
          produto INTEGER NOT NULL,
          criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (nomecliente) REFERENCES cliente(cpf),
          FOREIGN KEY (produto) REFERENCES produtos(id)
      );
      SQL
    
  end

  def inserirProduto(nome, preco, descricao)
    begin
      db = SQLite3::Database.new(DATABASE_FILE)
      db.execute('INSERT INTO produtos (nome, preco, descricao) VALUES (?, ?, ?);', [nome, preco, descricao])
      return true 
    rescue SQLite3::Exception => e
      puts "Erro ao inserir dados no banco de dados: #{e}"
      return false 
    ensure
      db.close if db
    end
  end 

  def inserirCliente(cpf,nome,endereco)
    begin
      db = SQLite3::Database.new(DATABASE_FILE)
      db.execute('INSERT INTO cliente VALUES(?,?,?)',[cpf,nome,endereco])
      return true 
    rescue SQLite3::Exception => e
      puts "Erro ao inserir dados no banco de dados: #{e}"
      return false 
    ensure
      db.close if db
    end
  end

  def ler(tabela)
     begin
            db = SQLite3::Database.new(DATABASE_FILE)
            consulta = "SELECT * FROM #{tabela};"
            valor = db.execute(consulta)
            return valor
        rescue SQLite3::Exception => e
            puts "Erro ao ler dados do banco de dados: #{e}"
            return nil
        ensure
            db.close if db
        end
    end

    def limpar
  begin
    db = SQLite3::Database.new(DATABASE_FILE)
    db.execute("DELETE FROM produtos;")
  rescue SQLite3::Exception => e
    puts "Erro ao limpar dados do banco de dados: #{e}"
    return nil
  ensure
    db.close if db
  end
end
end

Banco.criar_banco
