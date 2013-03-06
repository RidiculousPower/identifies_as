# -*- encoding : utf-8 -*-

module ::IdentifiesAs

  @identities = { }
  @instance_identities = { }
  
  @do_not_identify_as = { }
  @instances_do_not_identify_as = { }
  
  ##########################
  #  self.append_features  #
  ##########################

  def self.append_features( instance )
    
    instance.extend( self )
    unless instance.equal?( ::Object )
      instance.module_eval { include( ::IdentifiesAs::FakeInstance ) }
      instance.extend( ::IdentifiesAs::FakeInstance )
    end
    
    super
    
  end

  ########################
  #  self.extend_object  #
  ########################

  def self.extend_object( instance )
    
    unless instance.equal?( ::Object )
      instance.extend( ::IdentifiesAs::FakeInstance )
    end
    
    super
    
  end
  
  ################################
  #  self.object_identifies_as!  #
  ################################
  
  def self.object_identifies_as!( object, *objects )

    unless identifies_as_hash = @identities[ object_id = object.__id__ ]
      @identities[ object_id ] = identifies_as_hash = { }
    end
    
    objects.each { |this_object| identifies_as_hash[ this_object ] = true }
    
    if do_not_identify_as_hash = @do_not_identify_as[ object_id ]
      objects.each { |this_object| do_not_identify_as_hash.delete( this_object ) }
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
    
    objects.each { |this_object| identifies_as_hash[ this_object ] = true }
    
    if do_not_identify_as_hash = @instances_do_not_identify_as[ object_class ]
      objects.each { |this_object| do_not_identify_as_hash.delete( object_class ) }
    end
    
    return identifies_as_hash
    
  end

  ################################
  #  self.object_identifies_as?  #
  ################################

  def self.object_identifies_as?( object, type_in_question )
    
    # first check if the object we are given identifies as the other type
    object_identifies = object_instance_identifies_as?( object, type_in_question )

    # If we matched we can stop looking.
    # If we got nil that means we were told to stop looking.
    # otherwise, check if the class of the object we are given identifies as the other type
    if object_identifies
      # done - nothing to do
    elsif object_identifies.nil?
      object_identifies = false
    else
      object_identifies = object_instances_identify_as?( object.class, type_in_question ) || false
    end
    
    return object_identifies
    
  end

  #########################################
  #  self.object_instance_identifies_as?  #
  #########################################

  def self.object_instance_identifies_as?( object, type_in_question )
    
    object_identifies = false
    
    # if we don't have a module/class, check instance first
    # this is because module/class will start their own ancestor chain, but instance won't
    unless is_module = ::Module.case_compare( object )
      object_identifies = instance_identifies_as?( object, type_in_question )
    end
      
    unless object_identifies
      object_ancestors = nil
      if is_module
        object_ancestors = object.ancestors
      elsif ::Symbol.case_compare( object ) or ::Fixnum.case_compare( object )
        object_ancestors = object.class.ancestors
      else
        object_ancestors = object.singleton_class.ancestors
      end
      object_ancestors.each do |this_ancestor|
        object_identifies = instance_identifies_as?( this_ancestor, type_in_question )
        break if object_identifies or object_identifies.nil?
      end
    end
    
    return object_identifies
    
  end

  ##################################
  #  self.instance_identifies_as?  #
  ##################################
  
  def self.instance_identifies_as?( instance, type_in_question )

    instance_identifies = false

    # skip ancestor if it explicitly dis-identifies
    if do_not_identify_as_hash = @do_not_identify_as[ instance_id = instance.__id__ ] and
       do_not_identify_as_hash.has_key?( type_in_question )

      instance_identifies = nil

    elsif identifies_as_hash = @identities[ instance_id ]

      instance_identifies = identifies_as_hash.has_key?( type_in_question )

    end

    return instance_identifies
    
  end

  ########################################
  #  self.object_instances_identify_as?  #
  ########################################

  def self.object_instances_identify_as?( object_class, type_in_question )

    object_identifies = false
    object_class.ancestors.each do |this_ancestor|
      if do_not_identify_as_hash = @instances_do_not_identify_as[ this_ancestor ] and
         do_not_identify_as_hash.has_key?( type_in_question )
          object_identifies = nil
          break
      elsif identifies_as_hash = @instance_identities[ this_ancestor ]
        break if object_identifies = identifies_as_hash.has_key?( type_in_question )
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
      objects.each { |this_object| identifies_as_hash.delete( this_object ) }
    end

    unless do_not_identify_as_hash = @do_not_identify_as[ object_id ]
      do_not_identify_as_hash = { }
      @do_not_identify_as[ object_id ] = do_not_identify_as_hash
    end

    objects.each { |this_object| do_not_identify_as_hash[ this_object ] = true }
    
    return identifies_as_hash

  end

  ################################################
  #  self.stop_object_instances_identifying_as!  #
  ################################################
  
  def self.stop_object_instances_identifying_as!( object_class, *objects )

    if identifies_as_hash = @instance_identities[ object_class ]
      object_identifies = identifies_as_hash.has_key?( object_class )
      objects.each { |this_object| object_identifies.delete( this_object ) }
    end

    unless do_not_identify_as_hash = @instances_do_not_identify_as[ object_class ]
      do_not_identify_as_hash = { }
      @instances_do_not_identify_as[ object_class ] = do_not_identify_as_hash
    end

    objects.each { |this_object| do_not_identify_as_hash[ this_object ] = true }

    return identifies_as_hash

  end
      
end

# source file requires
require_relative './requires.rb'
