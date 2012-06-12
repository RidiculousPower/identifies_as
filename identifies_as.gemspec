require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'identifies_as'
  spec.rubyforge_project         =  'identifies_as'
  spec.version                   =  '1.0.3'

  spec.description               =  "Identities are interfaces. Sometimes it makes more sense to test an identity than a method- but then you don't want to limit flexibility. So why not let objects that claim to implement your interface identify as your object? IdentifiesAs permits objects to identify as if they are other types of objects."
  spec.summary                   =  "Provides IdentifiesAs, which offers :identifies_as!, :identifies_as?, :no_longer_identifies_as! and :identities, and overrides :is_a? and :===."

  spec.authors                   =  [ 'Asher' ]
  spec.email                     =  'asher@ridiculouspower.com'
  spec.homepage                  =  'http://rubygems.org/gems/identifies_as'

  spec.add_dependency            'module-cluster'

  spec.date                      =  Date.today.to_s
  
  spec.files                     = Dir[ '{lib,spec}/**/*',
                                        'README*', 
                                        'LICENSE*',
                                        'CHANGELOG*' ]

end
