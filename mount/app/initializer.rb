require 'sqlite3'
require 'csv'
require './app/server'
require './app/database'
require './app/logger'

class Initializer

  class << self

    def init()
      drop_tables
      create_tables

      Logger.info("processing clicks")
#    insert_click_data

      Logger.info("processing conversions")
#   insert_conversion_data

      Logger.info("processing impressions")
#  insert_impression_data

    end

    def run()
      App.run!
    end

    def drop_tables
      Database.dropTable("click")
      Database.dropTable("conversion")
      Database.dropTable("impression")
    end

    def create_tables
      Database.execute("create table if not exists click
                      (click_id INTEGER, banner_id INTEGER, campaign_id INTEGER,
                        CONSTRAINT click_pk PRIMARY KEY (click_id));")

      Database.execute("create table if not exists conversion
                      (conversion_id INTEGER,click_id INTEGER,revenue REAL,
                       CONSTRAINT click_pk PRIMARY KEY (conversion_id));")

      Database.execute("create table if not exists impression (banner_id INTEGER, campaign_id INTEGER,
                      CONSTRAINT click_pk PRIMARY KEY (banner_id,campaign_id));")
    end

    def insert_impression_data
      @impressions = File.read("data/impressions.csv")
      CSV.parse(@impressions).each_with_index do |row, i|
        next if i == 0
        Database.execute("INSERT INTO impression ( banner_id, campaign_id )
                          VALUES ('#{row[0]}','#{row[1]}')")
      end
    end

    def insert_conversion_data
      CSV.parse(File.read("data/conversions.csv")).each_with_index do |row, i|

        next if i == 0
        Database.execute("INSERT OR REPLACE INTO conversion ( conversion_id, click_id, revenue )
                          VALUES ('#{row[0]}','#{row[1]}','#{row[2]}')")
      end
    end

    def insert_click_data
      CSV.parse(File.read('data/clicks.csv')).each_with_index do |row, i|
        next if i == 0
        Database.execute("INSERT OR REPLACE  INTO click ( click_id, banner_id, campaign_id )
                          VALUES ('#{row[0]}','#{row[1]}','#{row[2]}')")
      end
    end
  end
end