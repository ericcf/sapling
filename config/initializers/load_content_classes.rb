# ensures all model classes have been loaded
Dir.glob(RAILS_ROOT + '/app/models/**/*.rb').each { |file| require file }