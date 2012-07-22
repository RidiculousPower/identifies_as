
module ::IdentifiesAs
end

# source file requires
require_relative './requires.rb'

module ::IdentifiesAs

  @identities = { }
  @instance_identities = { }
  
  @do_not_identify_as = { }
  @instances_do_not_identify_as = { }
  
  ###################
  #  self.included  #
  ###################

  def self.included( module_instance )
    
    super if defined?( super )
    
    module_instance.extend( self )
    
  end
  
  ################################
  #  self.object_identifies_as!  #
  ################################
  
  def self.object_identifies_as!( object, *objects )

    object_id = object.__id__
          
    unless identifies_as_hash = @identities[ object_id ]
      identifies_as_hash = { }
      @identities[ object_id ] = identifies_as_hash
    end
    
    objects.each do |this_object|
      identifies_as_hash[ this_object ] = true
    end
    
    if do_not_identify_as_hash = @do_not_identify_as[ object_id ]
      objects.each do |this_object|
        do_not_identify_as_hash.delete( this_object )
      end
    end
    
    return identifies_as_hash
    
  end

  ########################################
  #  self.object_instances_identify_as!  #
  ########################################
  
  def self.object_instances_identify_as!( object_class, *objects )

    unless identifies_as_hash = @instance_identities[ object_class ]
      identifies_as_hash = { }
      @instance_identities[ object_class ] = identifies_as_hash
    end
    
    objects.each do |this_object|
      identifies_as_hash[ this_object ] = true
    end
    
    if do_not_identify_as_hash = @instances_do_not_identify_as[ object_class ]
      objects.each do |this_object|
        do_not_identify_as_hash.delete( object_class )
      end
    end
    
    return identifies_as_hash
    
  end

  ################################
  #  self.object_identifies_as?  #
  ################################

  def self.object_identifies_as?( object, other_object_type )
    
    object_identifies = object_instance_identifies_as?( object, other_object_type )

    # If we got nil that means we were told to stop looking.
    unless object_identifies or object_identifies.nil?
      object_identifies = object_instances_identify_as?( object.class, other_object_type )
    end
    
    if object_identifies.nil?
      object_identifies = false
    end
    
    return object_identifies
    
  end

  #########################################
  #  self.object_instance_identifies_as?  #
  #########################################

  def self.object_instance_identifies_as?( object, other_object_type )
    
    object_identifies = false
    
    object_ancestor_chain = nil

    if object.actually_is_a?( ::Module )
      object_ancestor_chain = object.ancestors.dup
    else
      object_ancestor_chain = [ object ]
      if object.actually_is_a?( ::Symbol ) or object.actually_is_a?( ::Fixnum )
        object_ancestor_chain.concat( object.class.ancestors )
      else
        object_ancestor_chain.concat( class << object ; ancestors ; end )
      end
    end

    object_ancestor_chain.each do |this_ancestor|

      this_ancestor_id = this_ancestor.__id__

      if do_not_identify_as_hash = @do_not_identify_as[ this_ancestor_id ] and
         do_not_identify_as_hash.has_key?( other_object_type )
        object_identifies = nil
        break
      elsif identifies_as_hash = @identities[ this_ancestor_id ]
        break if object_identifies = identifies_as_hash.has_key?( other_object_type )
      end
  
    end
    
    return object_identifies
    
  end

  ########################################
  #  self.object_instances_identify_as?  #
  ########################################

  def self.object_instances_identify_as?( object_class, other_object_type )

    object_identifies = false
    object_class.ancestors.each do |this_ancestor|
      if do_not_identify_as_hash = @instances_do_not_identify_as[ this_ancestor ] and
         do_not_identify_as_hash.has_key?( other_object_type )
          object_identifies = nil
          break
      elsif identifies_as_hash = @instance_identities[ this_ancestor ]
        break if object_identifies = identifies_as_hash.has_key?( other_object_type )
      end

    end

    return object_identifies
    
  end

  ############################
  #  self.object_identities  #
  ############################
  
  def self.object_identities( object )
    
    return object_identities_hash( object ).keys
    
  end

  #####################################
  #  self.object_instance_identities  #
  #####################################
  
  def self.object_instance_identities( object_class )
    
    return object_instance_identities_hash( object_class ).keys
    
  end

  #################################
  #  self.object_identities_hash  #
  #################################
  
  def self.object_identities_hash( object )
    
    return @identities[ object.__id__ ]
    
  end

  ##########################################
  #  self.object_instance_identities_hash  #
  ##########################################
  
  def self.object_instance_identities_hash( object_class )
    
    return @instance_identities[ object_class ]
    
  end

  ######################################
  #  self.stop_object_identifying_as!  #
  ######################################
  
  def self.stop_object_identifying_as!( object, *objects )

    object_id = object.__id__

    if identifies_as_hash = @identities[ object_id ]
      objects.each do |this_object|
        identifies_as_hash.delete( this_object )
      end
    end

    unless do_not_identify_as_hash = @do_not_identify_as[ object_id ]
      do_not_identify_as_hash = { }
      @do_not_identify_as[ object_id ] = do_not_identify_as_hash
    end

    objects.each do |this_object|
      do_not_identify_as_hash[ this_object ] = true
    end
    
    return identifies_as_hash

  end

  ################################################
  #  self.stop_object_instances_identifying_as!  #
  ################################################
  
  def self.stop_object_instances_identifying_as!( object_class, *objects )

    if identifies_as_hash = @instance_identities[ object_class ]
      object_identifies = identifies_as_hash.has_key?( object_class )
      objects.each do |this_object|
        object_identifies.delete( this_object )
      end
    end

    unless do_not_identify_as_hash = @instances_do_not_identify_as[ object_class ]
      do_not_identify_as_hash = { }
      @instances_do_not_identify_as[ object_class ] = do_not_identify_as_hash
    end

    objects.each do |this_object|
      do_not_identify_as_hash[ this_object ] = true
    end

    return identifies_as_hash

  end
      
end
