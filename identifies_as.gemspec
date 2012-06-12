require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'identifies_as'
  spec.rubyforge_project         =  'identifies_as'
  spec.version                   =  '1.0.1'

  spec.summary                   =  "Permits objects to identify as if they are other types of objects. Effects :is_a? and :===."
  spec.description               =  "Provides IdentifiesAs, which offers :identifies_as!, :identifies_as?, :no_longer_identifies_as! and :identities, and overrides :is_a? and :===."

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
