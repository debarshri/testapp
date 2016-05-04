class Database

  class << self

    $db = SQLite3::Database.new( "data.db" )

    def dropTable(tableName)
      $db.execute("drop table if exists #{tableName}")
    end

    def execute(stmt)
      $db.execute("#{stmt}")
    end

  end

end