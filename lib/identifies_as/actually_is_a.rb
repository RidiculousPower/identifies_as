# -*- encoding : utf-8 -*-

module ::IdentifiesAs::ActuallyIsA

  ####################
  #  actually_is_a?  #
  ####################
  
  # Alias to the original :is_a? method without IdentifyAs functionality.
  # @param [Object] objects Other object to test identity against.
  # @return [true,false] Whether receiver is actually instance of specified object.
  alias_method :actually_is_a?, :is_a?

end
