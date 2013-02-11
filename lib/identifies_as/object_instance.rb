
module ::IdentifiesAs::ObjectInstance

  include ::IdentifiesAs::ActuallyIsA

  ####################
  #  identifies_as!  #
  ####################
  
  # Cause receiver to identify as specified objects.
  # @param [Array<Object>] objects Other objects self should identify as.
  # @return [Object] Self.
  def __identifies_as__!( *objects )

    return ::IdentifiesAs.object_identifies_as!( self, *objects )
    
  end

  alias_method :identifies_as!, :__identifies_as__!

  ####################
  #  identifies_as?  #
  ####################
  
  # Query whether receiver identifies as specified object.
  # @param [Object] object Object against which identity is being tested.
  # @return [true,false] Whether receiver identifies as object.
  def __identifies_as__?( object )
    
    return ::IdentifiesAs.object_identifies_as?( self, object )    
    
  end

  alias_method :identifies_as?, :__identifies_as__?

  ################
  #  identities  #
  ################
  
  # Identities that receiver identifies as, beyond those which it actually is.
  # @return [Array<Object>] Identities receiver identifies as.
  def __identities__
    
    return ::IdentifiesAs.object_identities( self )    
    
  end

  alias_method :identities, :__identities__

  ##########################
  #  stop_identifying_as!  #
  ##########################
  
  # Cause receiver to no longer identify as specified objects.
  # @param [Array<Object>] objects Other objects receiver should no longer identify as.
  # @return [Object] Self.
  def __stop_identifying_as__!( *objects )
    
    return ::IdentifiesAs.stop_object_identifying_as!( self, *objects )    
    
  end

  alias_method :stop_identifying_as!, :__stop_identifying_as__!

  ###########
  #  is_a?  #
  ###########
  
  def is_a?( object )
    
    is_type = false

    if __actually_is_a__?( ::IdentifiesAs ) and 
       __identifies_as__?( object )    
      is_type = true
    else
      is_type = super
    end
    
    return is_type
    
  end

  alias_method :__is_a__?, :is_a?

end
