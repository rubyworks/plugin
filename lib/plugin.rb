require 'plugin/loadpath'
require 'plugin/rubygems' if defined?(::Gem)

module Plugin
  extend self

  # Find plugins, searching through ,
  # Rolls, RubyGems and standard $LOAD_PATH.
  #
  # Provide a +match+ file glob to find plugins.
  #
  #   Plugins.find('syckle/*')
  #
  def find(match, options={})
    plugins = []
    plugins.concat find_roll(match, options)
    plugins.concat find_gems(match, options)
    plugins.concat find_site(match, options)
    plugins.uniq
  end

  # Shortcut for #find.
  #
  #   Plugin['syckle/*']
  #
  alias_method :[], :find

  # Search rolls for current or latest libraries.
  #
  def find_roll(match, options={})
    return [] unless defined?(::Roll) #Library
    #::Library.search_latest(match)
    ::Library.find_files(match)
  end

  # Search latest gem versions.
  #
  def find_gems(match, options={})
    return [] unless defined?(::Gem)
    ::Gem.search(match)
  end

  # Search standard $LOAD_PATH.
  #
  def find_site(match, options={})
    $LOAD_PATH.search(match)
  end

end

