require 'sqlite3'

SQLite3::Database.new( "data.db" ) do |db|
  db.execute( "select * from table" ) do |row|
    p row
  end
end