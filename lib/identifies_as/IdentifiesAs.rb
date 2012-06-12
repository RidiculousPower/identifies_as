
module ::IdentifiesAs
  
  extend ::ModuleCluster::Define::Cluster
  
  include_also_extends( self )

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
    
    object_identifies = false
    
    if identifies_as_hash = @identities[ object.__id__ ]
      object_identifies = identifies_as_hash.has_key?( other_object_type )
    end

    unless object_identifies
      object_identifies = object_instances_identify_as?( object.class, other_object_type )
    end
    
    return object_identifies
    
  end

  ########################################
  #  self.object_instances_identify_as?  #
  ########################################

  def self.object_instances_identify_as?( object_class, other_object_type )
    
    object_identifies = false

    if identifies_as_hash = @instance_identities[ object_class ]
      object_identifies = identifies_as_hash.has_key?( other_object_type )
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

  ##########################################
  #  self.object_no_longer_identifies_as!  #
  ##########################################
  
  def self.object_no_longer_identifies_as!( object, *objects )

    if identifies_as_hash = @identities[ object ]
      object_identifies = identifies_as_hash.has_key?( object )
      objects.each do |this_object|
        object_identifies.delete( this_object.__id__ )
      end
    end
    
    return identifies_as_hash

  end

  ##################################################
  #  self.object_instances_no_longer_identify_as!  #
  ##################################################
  
  def self.object_instances_no_longer_identify_as!( object_class, *objects )

    if identifies_as_hash = @instance_identities[ object_class ]
      object_identifies = identifies_as_hash.has_key?( object_class )
      objects.each do |this_object|
        object_identifies.delete( this_object )
      end
    end
    
    return identifies_as_hash

  end
  
  ####################
  #  identifies_as!  #
  ####################
  
  def identifies_as!( *objects )

    return ::IdentifiesAs.object_identifies_as!( self, *objects )
    
  end

  ############################
  #  instances_identify_as!  #
  ############################
  
  def instances_identify_as!( *objects )
    
    return ::IdentifiesAs.object_instances_identify_as!( self, *objects )
    
  end

  ####################
  #  identifies_as?  #
  ####################
  
  def identifies_as?( *objects )
    
    return ::IdentifiesAs.object_identifies_as?( self, *objects )    
    
  end

  ############################
  #  instances_identify_as?  #
  ############################
  
  def instances_identify_as?( *objects )
    
    return ::IdentifiesAs.object_instances_identify_as?( self, *objects )    
    
  end

  ################
  #  identities  #
  ################
  
  def identities
    
    return ::IdentifiesAs.object_identities( self )    
    
  end

  #########################
  #  instance_identities  #
  #########################
  
  def instance_identities
    
    return ::IdentifiesAs.object_instance_identities( self )    
    
  end

  ##############################
  #  no_longer_identifies_as!  #
  ##############################
  
  def no_longer_identifies_as!( *objects )
    
    return ::IdentifiesAs.object_no_longer_identifies_as!( self, *objects )    
    
  end

  ######################################
  #  instances_no_longer_identify_as!  #
  ######################################
  
  def no_longer_identifies_as!( *objects )
    
    return ::IdentifiesAs.object_instances_no_longer_identify_as!( self, *objects )    
    
  end

  ####################
  #  actually_is_a?  #
  ####################
  
  alias_method :actually_is_a?, :is_a?

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
