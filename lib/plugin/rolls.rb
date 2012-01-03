module Plugin

  module LibrarySearch

    # Search Roll system for current or latest library files. This is useful
    # for plugin loading.
    #
    # This only searches activated libraries or the most recent version
    # of any given library.
    #
    def search_latest(match) #, options={})
      matches = []
      ledger.each do |name, lib|
        lib = lib.sort.first if Array===lib
        lib.loadpath.each do |path|
          find = File.join(lib.location, path, match)
          list = Dir.glob(find)
          list = list.map{ |d| d.chomp('/') }
          matches.concat(list)
        end
      end
      matches
    end

  end

end

::Library.extend(Plugin::LibrarySearch)

