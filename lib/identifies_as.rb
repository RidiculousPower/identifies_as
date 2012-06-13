
require 'module-cluster'

module ::IdentifiesAs
end

basepath = 'identifies_as/IdentifiesAs'

files = [
  
  'ActuallyIsA',
  
  'ClassInstance',
  'ObjectInstance'
  
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end

require_relative( basepath + '.rb' )

class ::Object
  include ::IdentifiesAs
end

class ::Module
  include ::IdentifiesAs::ClassInstance
end
