module Gem

  # Search RubyGems for matching paths in current gem versions.
  def self.search(match, options={})
    matches = []
    Gem::Specification.current_specs.each do |spec|
      glob = File.join(spec.lib_dirs_glob, match)
      list = Dir[glob] #.map{ |f| f.untaint }
      list = list.map{ |d| d.chomp('/') }
      matches.concat(list)
    end
    matches
  end

  class Specification
    # Return a list of active specs or latest version of spec if not active.
    def self.current_specs
      named = Hash.new{|h,k| h[k] = [] }
      each{ |spec| named[spec.name] << spec }
      list = []
      named.each do |name, vers|
        if spec = vers.find{ |s| s.activated? }
          list << spec
        else
          spec = vers.max{ |a,b| a.version <=> b.version }
          list << spec
        end
      end
      return list
    end

    # Return full path of requireable file given relative path.
    def find_requireable_file(file)
      root = full_gem_path

      require_paths.each do |lib|
        base = File.join(root, lib, file)
        Gem.suffixes.each do |suf|
          path = "#{base}#{suf}"
          return path if File.file? path
        end
      end

      return nil
    end
  end

end

