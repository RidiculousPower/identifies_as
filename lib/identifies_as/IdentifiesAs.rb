
module ::IdentifiesAs
  
  extend ::ModuleCluster::Define::Cluster
  
  include self::ObjectInstance
  include_also_extends( self::ClassInstance )

  @identities = { }
  @instance_identities = { }
  
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
    
    return identifies_as_hash
    
  end

  ################################
  #  self.object_identifies_as?  #
  ################################

  def self.object_identifies_as?( object, other_object_type )

    object_identifies = object_instance_identifies_as?( object, other_object_type )

    unless object_identifies
      object_identifies = object_instances_identify_as?( object.class, other_object_type )
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
  
      if identifies_as_hash = @identities[ this_ancestor.__id__ ]
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
      if identifies_as_hash = @instance_identities[ this_ancestor ]
        object_identifies = identifies_as_hash.has_key?( other_object_type )
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
  #  self.object_stop_identifying_as!  #
  ######################################
  
  def self.object_stop_identifying_as!( object, *objects )

    if identifies_as_hash = @identities[ object.__id__ ]
      objects.each do |this_object|
        identifies_as_hash.delete( this_object )
      end
    end
    
    return identifies_as_hash

  end

  ################################################
  #  self.object_stop_instances_identifying_as!  #
  ################################################
  
  def self.object_stop_instances_identifying_as!( object_class, *objects )

    if identifies_as_hash = @instance_identities[ object_class ]
      object_identifies = identifies_as_hash.has_key?( object_class )
      objects.each do |this_object|
        object_identifies.delete( this_object )
      end
    end
    
    return identifies_as_hash

  end
      
end
