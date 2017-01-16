require 'pry'

root_dir = File.dirname(__FILE__)
require_pattern = File.join(root_dir, '**/*.rb')
@failed = []

# Dynamically require everything
Dir.glob(require_pattern).each do |f|
  next if f.end_with?('/main.rb')
  begin
    require_relative f.gsub("#{root_dir}/", '')
  rescue
    # May fail if parent class is not required yet
    @failed << f
  end
end

# Retry unresolved requires
@failed.each do |f|
  require_relative f.gsub("#{root_dir}/", '')
end

@game = Game.new

while 1
  @game.update
end
