require_relative "../config/environment.rb"
require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  
  attr_accessor :name, :grade 
  attr_reader :id
  
  def initialize(id = nil, name, grade)
    @id = id
    @name = name 
    @grade = grade
  end
  
  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.drop_table 
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end
  
  def save 
<<<<<<< HEAD
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)" 
    
    DB[:conn].execute(sql, self.name, self.grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
=======
    if self.id 
      update
    else 
      sql = "INSERT INTO students (name, grade) VALUES (?, ?)" 
      
      DB[:conn].execute(sql, self.name, self.grade)
      
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end
>>>>>>> ac508d170d378f7bf63540cd406677b0e03677d4
  end
  
  def self.create(name, grade)
    self.new(name, grade).tap {|student| student.save}
  end
  
  def self.new_from_db(row)
    self.new(row[0], row[1], row[2])
  end
<<<<<<< HEAD
=======
  
  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * FROM students
      WHERE name = ?
      ORDER BY id 
      LIMIT 1
    SQL
    
    self.new_from_db( DB[:conn].execute(sql, name).first )
  end
  
  def update 
    sql = <<-SQL 
      UPDATE students 
      SET name = ?, grade = ?
      WHERE id = ?
    SQL
    
    DB[:conn].execute(sql, self.name, self.grade, self.id)
  end
>>>>>>> ac508d170d378f7bf63540cd406677b0e03677d4
end
