# = Plugin Handler
#
# Find plugins across various library managers.
#
# All plugins are expected to be within a library's designated
# loadpath(s) under a toplevel <tt>plugins/</tt> subdirectory.
# By using this assigned space plugins are kept isolated from
# normal library scripts, which helps prevent inadvertent
# name clashes.
#
# For example, lets say we want to create a pluggable template
# system for our "luckyweb" project. Our <tt>lib/</tt>
# directory would have the usual <tt>luckyweb</tt> directory,
# but also now a <tt>plugins/luckyweb/</tt> path in which the
# plugin templates would be stored.
#
# == How To Use
#
# Usage is very simple. Just supply a glob to the +Plugin.find+
# function.
#
#     Plugin.find('syckle/*')
#
# A shortcut is provided with <tt>[]</tt>.
#
#     Plugin['syckle/*']
#
# == Alternate Plugin Location
#
# By default <tt>plugins/</tt> is hardcoded into the system
# as a reliable convention. This is intentional. However,
# if you have specific need for serching for files outside
# that directory you can do so by supplying a <tt>:directory</tt>
# option to the <tt>#find</tt> command. Eg.
#
#     Plugin.find('discover.rb', :directory=>'rdoc')
#
# == A Note on RubyGems
#
# A way has not yet been devised to isolate the actived version
# of a gem from the latest inactive version. Therefore some
# overlap can occur if an older version of a plugin-containing
# gem has been activated prior to calling Plugin.find(). Such an
# occurance will be rare (considering the use cases of plugins),
# so it is nothing to be overly concerned about. Moreover, it is
# a long-way from the offical Gems plugin policy which is to find
# all matching files from *all* versions using Gem.find_files().
# I quote Eric Hodel, "It's an encouragement to make your plugin
# files as light as possible, such as requiring an additional file
# or calling some very stable API." While an understandable
# encouragment, ultimately it is not a robust solution.

module Plugin

  extend self

  DIRECTORY = 'plugins'

  # Find plugins, searching through standard $LOAD_PATH,
  # Roll Libraries and RubyGems.
  #
  # Provide a +match+ file glob to find plugins.
  #
  #   Plugins.find('syckle/*')
  #
  def find(match, options={})
    plugins = []
    plugins.concat find_roll(match, options)
    plugins.concat find_loadpath(match, options)
    plugins.concat find_gems(match, options)
    plugins.uniq
  end

  # Shortcut for #find.
  #
  #   Plugin['syckle/*']
  #
  alias_method :[], :find


  # Search roll for current or latest libraries.

  def find_roll(match, options={})
    plugins = []
    directory = options[:directory] || DIRECTORY
    if defined?(::Roll)
      ::Roll::Library.ledger.each do |name, lib|
        lib = lib.sort.first if Array===lib
        lib.loadpath.each do |path|
          find = File.join(lib.location, path, directory, match)
          list = Dir.glob(find)
          list = list.map{ |d| d.chomp('/') }
          plugins.concat(list)
        end
      end
    end
    plugins
  end

  # Search standard $LOAD_PATH.
  #
  # Activated gem versions are in here too.

  def find_loadpath(match, options={})
    plugins = []
    directory = options[:directory] || DIRECTORY
    $LOAD_PATH.uniq.each do |path|
      path = File.expand_path(path)
      list = Dir.glob(File.join(path, directory, match))
      #dirs = dirs.select{ |d| File.directory?(d) }
      list = list.map{ |d| d.chomp('/') }
      plugins.concat(list)
    end
    plugins
  end

  # Search latest gem versions.
  #
  # TODO: Is there anyway to skip active gems?

  def find_gems(match, options={})
    plugins = []
    directory = options[:directory] || DIRECTORY
    if defined?(::Gem)
      ::Gem.latest_load_paths do |path|
        list = Dir.glob(File.join(path, directory, match))
        list = list.map{ |d| d.chomp('/') }
        plugins.concat(list)
      end
    end
    plugins
  end

end

