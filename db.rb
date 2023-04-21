require 'sqlite3'

# Specify the path to your SQLite database file
DB_PATH = 'my_database.db'

# Open the SQLite database
db = SQLite3::Database.new(DB_PATH)

# Create "cards" table if it doesn't exist
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS cards (
    id INTEGER PRIMARY KEY,
    name TEXT,
    description TEXT
  );
SQL

# Create "locations" table if it doesn't exist
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS locations (
    id INTEGER PRIMARY KEY,
    name TEXT,
    address TEXT
  );
SQL

# Close the database
db.close