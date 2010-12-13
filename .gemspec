--- !ruby/object:Gem::Specification 
name: plugin
version: !ruby/object:Gem::Version 
  hash: 19
  prerelease: false
  segments: 
  - 1
  - 1
  - 0
  version: 1.1.0
platform: ruby
authors: 
- Thomas Sawyer
autorequire: 
bindir: bin
cert_chain: []

date: 2010-12-13 00:00:00 -05:00
default_executable: 
dependencies: 
- !ruby/object:Gem::Dependency 
  name: syckle
  prerelease: false
  requirement: &id001 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  type: :development
  version_requirements: *id001
description: Plugins is a general purpose plugin handler for Ruby. (NoteThis has nothing to do with Rails plugins.)
email: trasfire@gmail.com
executables: []

extensions: []

extra_rdoc_files: 
- README.rdoc
files: 
- lib/plugin.rb
- test/demos/helper.rb
- test/demos/plugins/example.rb
- test/demos/usage.rdoc
- README.rdoc
- HISTORY
- VERSION
- COPYING
has_rdoc: true
homepage: http://rubyworks.github.com/plugin
licenses: 
- Apache 2.0
post_install_message: 
rdoc_options: 
- --title
- Plugin API
- --main
- README.rdoc
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
required_rubygems_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
requirements: []

rubyforge_project: plugin
rubygems_version: 1.3.7
signing_key: 
specification_version: 3
summary: General Purpose Plugin Handler
test_files: []

