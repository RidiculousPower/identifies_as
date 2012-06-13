
module ::IdentifiesAs::ObjectInstance

  include ::IdentifiesAs::ActuallyIsA

  ####################
  #  identifies_as!  #
  ####################
  
  # Cause receiver to identify as specified objects.
  # @param [Array<Object>] objects Other objects self should identify as.
  # @return [Object] Self.
  def identifies_as!( *objects )

    return ::IdentifiesAs.object_identifies_as!( self, *objects )
    
  end

  ####################
  #  identifies_as?  #
  ####################
  
  # Query whether receiver identifies as specified object.
  # @param [Object] object Object against which identity is being tested.
  # @return [true,false] Whether receiver identifies as object.
  def identifies_as?( object )
    
    return ::IdentifiesAs.object_identifies_as?( self, object )    
    
  end

  ################
  #  identities  #
  ################
  
  # Identities that receiver identifies as, beyond those which it actually is.
  # @return [Array<Object>] Identities receiver identifies as.
  def identities
    
    return ::IdentifiesAs.object_identities( self )    
    
  end

  ##########################
  #  stop_identifying_as!  #
  ##########################
  
  # Cause receiver to no longer identify as specified objects.
  # @param [Array<Object>] objects Other objects receiver should no longer identify as.
  # @return [Object] Self.
  def stop_identifying_as!( *objects )
    
    return ::IdentifiesAs.object_stop_identifying_as!( self, *objects )    
    
  end

  ###########
  #  is_a?  #
  ###########
  
  def is_a?( object )
    
    is_type = false
    
    if identifies_as?( object )    
      is_type = true
    else
      is_type = super
    end
    
    return is_type
    
  end

end
