# -*- encoding : utf-8 -*-

module ::IdentifiesAs
end

files = [
  
  'module',
  
  'identifies_as/actually_is_a',
  'identifies_as/object_instance',
  'identifies_as/fake_instance'
  
  
]

files.each { |this_file| require_relative( this_file << '.rb' ) }

class ::Object
  include ::IdentifiesAs::ActuallyIsA
  include ::IdentifiesAs::ObjectInstance
end
