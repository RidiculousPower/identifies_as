
module ::IdentifiesAs::EqualsEqualsEquals
  
  #########
  #  ===  #
  #########

  def ===( object )

    is_equal = false

    if identifies_as_hash = ::IdentifiesAs.object_identities_hash( object )
      identifies_as_hash.each do |this_object, true_value|
        if super( this_object ) or ( self < this_object ) != nil
          is_equal = true
          break
        end
      end
    end

    if identifies_as_hash = ::IdentifiesAs.object_instance_identities_hash( object.class )
      identifies_as_hash.each do |this_object, true_value|
        if super( this_object ) or ( self < this_object ) != nil
          is_equal = true
          break
        end
      end
    end
    
    unless is_equal
      is_equal = super
    end
    
    return is_equal
    
  end
  
end
