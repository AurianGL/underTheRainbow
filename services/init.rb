require_relative './base_service'

Dir.glob(File.join(File.dirname(__FILE__), '*.rb')).each do |file|
  next if file == __FILE__
  autoload File.basename(file, '.rb').capitalize.to_sym, file
end