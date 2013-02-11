require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'identifies_as'
  spec.rubyforge_project         =  'identifies_as'
  spec.version                   =  '1.1.1'

  spec.description               =  "Identities are interfaces. Sometimes it makes more sense to test an identity than a method- but then you don't want to limit flexibility. So why not let objects that claim to implement your interface identify as your object? IdentifiesAs permits objects to identify as if they are other types of objects."
  spec.summary                   =  "Provides IdentifiesAs, which offers :identifies_as!, :identifies_as?, :stop_identifying_as! and :identities, and overrides :is_a? and :===."

  spec.authors                   =  [ 'Asher' ]
  spec.email                     =  'asher@ridiculouspower.com'
  spec.homepage                  =  'http://rubygems.org/gems/identifies_as'

  spec.required_ruby_version     = ">= 1.9.1"

  spec.date                      = Date.today.to_s
  
  spec.files                     = Dir[ '{lib,spec}/**/*',
                                        'README*', 
                                        'LICENSE*',
                                        'CHANGELOG*' ]

end
