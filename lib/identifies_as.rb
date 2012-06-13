
require 'module-cluster'

require_relative 'identifies_as/IdentifiesAs.rb'
require_relative 'identifies_as/IdentifiesAs/ActuallyIsA.rb'
require_relative 'identifies_as/IdentifiesAs/EqualsEqualsEquals.rb'

class ::Object
  extend ::IdentifiesAs::EqualsEqualsEquals
  include ::IdentifiesAs::ActuallyIsA
  extend ::IdentifiesAs::ActuallyIsA
end
