# ensures all model classes have been loaded
# skips over observers because some e.g ContentObserver need all models loaded first

Dir.glob(RAILS_ROOT + '/app/models/**/*.rb').each do |file|
  require file if (file =~ /observer.rb/).nil?
end