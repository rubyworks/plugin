--- 
name: plugin
title: Plugin
contact: Trans <trasfire@gmail.com>
requires: 
- group: 
  - build
  name: syckle
  version: 0+
resources: 
  code: http://github.com/rubyworks/plugin
  mail: http://groups.google.com/rubyworks-mailinglist
  home: http://rubyworks.github.com/plugin
pom_verison: 1.0.0
manifest: 
- .ruby/date
- .ruby/loadpath
- .ruby/name
- .ruby/version
- lib/plugin.rb
- test/demos/helper.rb
- test/demos/plugins/example.rb
- test/demos/usage.rdoc
- README.rdoc
- HISTORY
- VERSION
- COPYING
version: 1.1.0
suite: rubyworks
copyright: Copyright (c) 2008 Thomas Sawyer
licenses: 
- Apache 2.0
repositores: 
  public: git://github.com/rubyworks/plugin.git
description: 
  Plugins is a general purpose plugin handler for Ruby. (Note: This has nothing to do with Rails plugins.)
summary: General Purpose Plugin Handler
authors: 
- Thomas Sawyer
created: 2008-08-17 09:00:06
