module GemHelper
  # search remotely for gems
  def gem_search gem
    `gem search -r #{gem}`.grep(/^#{gem} \(/).first.chomp
  end

  # converts "rails (2.3.5)" to "2.3.5"
  def gem_version gem
    gem.gsub(/[^ ]* \(([0-9.]*),?.*\)/, "\\1")
  end

  def gem_to_yaml _gem
    # find most recent version of gem
    puts "finding #{_gem}"
    gem = gem_search _gem

    # convert to yaml
    puts "found #{gem}"
    "- name: #{gem.split(' ').first}\n  version: '= #{gem_version(gem)}'"
  end
end
