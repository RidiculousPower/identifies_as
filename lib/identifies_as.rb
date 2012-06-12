
require 'module-cluster'

require_relative 'identifies_as/IdentifiesAs.rb'
require_relative 'identifies_as/IdentifiesAs/EqualsEqualsEquals.rb'

class ::Object
  extend ::IdentifiesAs::EqualsEqualsEquals
end
