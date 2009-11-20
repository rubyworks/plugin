# = Plugin Handler
#
# Find plugins across various library managers.
#
module Plugin

  extend self

  DIRECTORY = 'plugin'

  # Find plugins, searching through standard $LOAD_PATH,
  # Roll Libraries and RubyGems.
  #
  # Provide a +match+ file glob to find plugins.
  #
  #   Plugins.find('syckle/*')
  #
  def find(match)
    plugins = []

    # Standard $LOAD_PATH
    $LOAD_PATH.uniq.each do |path|
      list = Dir.glob(File.join(path, DIRECTORY, match))
      #dirs = dirs.select{ |d| File.directory?(d) }
      list = list.map{ |d| d.chomp('/') }
      plugins.concat(list)
    end

    # ROLL (load latest or current versions only)
    if defined?(::Roll)
      ::Roll::Library.ledger.each do |name, lib|
        lib = lib.sort.first if Array===lib
        lib.load_path.each do |path|
          find = File.join(lib.location, path, DIRECTORY, match)
          list = Dir.glob(find)
          list = list.map{ |d| d.chomp('/') }
          plugins.concat(list)
        end
      end
    end

    # RubyGems (load latest versions only)
    # TODO: need current versions
    if defined?(::Gem)
      Gem.latest_load_paths do |path|
        list = Dir.glob(File.join(path, DIRECTORY, match))
        list = list.map{ |d| d.chomp('/') }
        plugins.concat(list)
      end
    end

    plugins
  end

  # Shortcut for #find.
  #
  #   Plugins['syckle/*']
  #
  alias_method :[], :find

end

