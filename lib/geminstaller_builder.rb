require 'geminstaller_builder/gem_helper'

# Convert a list of gems into a valid geminstaller.yml file.
class GeminstallerBuilder
  include GemHelper

  def initialize options={}
    options = {
      :env => :default,
      :gems => {
        :default    => [],
        :test       => []
      },
      :paths => {
        :default    => "config/geminstaller.yml",
        :test       => "config/test/geminstaller.yml"
    }
    }.merge(options)

    @gems  = options[:gems]
    @paths = options[:paths]
  end

  def add gem, env=:default
    @gems[env.to_sym] << gem
  end

  alias_method :<<, :add

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
