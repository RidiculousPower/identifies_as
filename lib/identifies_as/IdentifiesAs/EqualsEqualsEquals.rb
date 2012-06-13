
module ::IdentifiesAs::EqualsEqualsEquals
  
  #########
  #  ===  #
  #########
  
  def ===( object )
    
    is_equal = false
    
    if ::IdentifiesAs.object_identifies_as?( object, self )
      is_equal = true
    else
      is_equal = super
    end

    return is_equal
    
  end
  
end
