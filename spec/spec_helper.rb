require('rspec')
require('lines')
require('stations')
require('pry')
require('pg')

DB = PG.connect({:dbname => 'trains_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
  end
end
