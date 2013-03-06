# -*- encoding : utf-8 -*-

class ::Module
  
  ############################
  #  instances_identify_as!  #
  ############################
  
  # Cause instances of receiver to identify as specified objects.
  # @param [Array<Object>] objects Other objects self should identify as.
  # @return [Object] Self.
  def instances_identify_as!( *objects )
    
    return ::IdentifiesAs.object_instances_identify_as!( self, *objects )
    
  end

  ############################
  #  instances_identify_as?  #
  ############################
  
  # Query whether instances of receiver identify as specified object.
  # @param [Object] object Object against which identity is being tested.
  # @return [true,false] Whether instances of receiver identify as object.
  def instances_identify_as?( object )
    
    return ::IdentifiesAs.object_instances_identify_as?( self, object )    
    
  end


  #########################
  #  instance_identities  #
  #########################
  
  # Identities that instances of receiver identify as, beyond those which it actually is.
  # @return [Array<Object>] Identities instances of receiver identifies as.
  def instance_identities
    
    return ::IdentifiesAs.object_instance_identities( self )    
    
  end

  ####################################
  #  stop_instances_identifying_as!  #
  ####################################
  
  # Cause instances of receiver to no longer identify as specified objects.
  # @param [Array<Object>] objects Other objects instance of receiver should no longer identify as.
  # @return [Object] Self.
  def stop_instances_identifying_as!( *objects )
    
    return ::IdentifiesAs.stop_object_instances_identifying_as!( self, *objects )    
    
  end
  
  #########
  #  ===  #
  #########
  
  alias_method :case_compare, :===
  
  def ===( object )
    
    is_equal = false
    
    if ::IdentifiesAs::FakeInstance.case_compare( object ) and ::IdentifiesAs.object_identifies_as?( object, self )
      is_equal = true
    else
      is_equal = case_compare( object )
    end

    return is_equal
    
  end
  
  #######
  #  <  #
  #######

  alias_method :less_than, :<

  def <( object )
    
    is_less_than = less_than( object )
    
    if is_less_than.nil?
      # a class is < another class if it has the other class as one of its ancestors
      if self != object and ::IdentifiesAs.object_instance_identifies_as?( self, object )
        is_less_than = true
      end
    end
        
    return is_less_than
    
  end

  #######
  #  >  #
  #######

  alias_method :greater_than, :>

  def >( object )

    is_greater_than = greater_than( object )
    
    if is_greater_than.nil?
      # a class is > another class if the other class has it as one of its ancestors
      if self != object and 
         ::IdentifiesAs.object_instance_identifies_as?( object, self )
        is_greater_than = true
      else
        is_less_than = self < object
        unless is_less_than.nil?
          is_greater_than = ! is_less_than
        end
      end
    end
        
    return is_greater_than
    
  end

  ########
  #  <=  #
  ########

  alias_method :less_than_or_equal_to, :<=

  def <=( object )
    
    is_less_than_or_equal_to = less_than_or_equal_to( object )
    
    if is_less_than_or_equal_to.nil?
      # a class is < another class if it has the other class as one of its ancestors
      if self == object or 
         ::IdentifiesAs.object_instance_identifies_as?( self, object )
        is_less_than_or_equal_to = true
      end
    end
        
    return is_less_than_or_equal_to
    
  end

  ########
  #  >=  #
  ########

  alias_method :greater_than_or_equal_to, :>=

  def >=( object )

    is_greater_than_or_equal_to = greater_than_or_equal_to( object )
    
    if is_greater_than_or_equal_to.nil?
      # a class is < another class if it has the other class as one of its ancestors
      if self == object or 
         ::IdentifiesAs.object_instance_identifies_as?( object, self )
        is_greater_than_or_equal_to = true
      else
        is_less_than_or_equal_to = self <= object
        unless is_less_than_or_equal_to.nil?
          is_greater_than_or_equal_to = ! is_less_than_or_equal_to
        end
      end
    end
        
    return is_greater_than_or_equal_to
    
  end

  #########
  #  <=>  #
  #########

  alias_method :compare, :<=>

  def <=>( object )
    
    less_than_equal_to_greater_than = nil
    
    if self == object
      less_than_equal_to_greater_than = 0
    elsif self < object
      less_than_equal_to_greater_than = -1
    elsif self > object
      less_than_equal_to_greater_than = 1
    end
    
    return less_than_equal_to_greater_than
    
  end

end
