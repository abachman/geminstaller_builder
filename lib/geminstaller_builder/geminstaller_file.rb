require 'gem_helper'

# Convert a list of gems into a valid geminstaller.yml file.
class GeminstallerFile
  include GemHelper
  def initialize env=nil
    @gems = {:default => []}
    @paths = {:default => "config/geminstaller.yml"}
    %w(test staging production).each do |env|
      @paths[env.to_sym] = "config/#{env}/geminstaller.yml"
      @gems[env.to_sym] = []
    end
  end

  def add gem, env=:default
    @gems[env.to_sym] << gem
  end

  def save
    puts "\e[34m[ Saving Gems ]\e[0m"
    @gems.keys.each do |env|
      File.open(@paths[env], 'w') do |f|
        yaml_gems = @gems[env].map {|_g| gem_to_yaml(_g)}
        f.write "---\ndefaults:\n  install-options: '--no-rdoc --no-ri'\ngems:\n" + yaml_gems.join("\n")
      end
    end
  end
end
