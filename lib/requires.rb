
module ::IdentifiesAs
end

basepath = ''

files = [
  
  'module',
  
  'identifies_as/actually_is_a',
  
  'identifies_as/object_instance'
  
]

files.each do |this_file|
  require_relative( File.join( this_file ) + '.rb' )
end

class ::Object
  include ::IdentifiesAs::ActuallyIsA
  include ::IdentifiesAs::ObjectInstance
end
