# -*- encoding : utf-8 -*-

require_relative '../lib/identifies_as.rb'

describe ::IdentifiesAs do

  ##########################
  #  identifies_as!        #
  #  identifies_as?        #
  #  identities            #
  #  stop_identifying_as!  #
  #  is_a?                 #
  #  ===                   #
  #  <                     #
  #  >                     #
  #  <=>                   #
  ##########################

  it 'lets an object pretend it is another object' do
    
    instance = Object.new
    instance.extend( ::IdentifiesAs )
    
    instance.identifies_as!( Array )
    instance.identifies_as?( Array ).should == true
    instance.identities.should == [ Array ]    
    instance.is_a?( Array ).should == true
    ( Array === instance ).should == true
    
    instance.stop_identifying_as!( Array )
    instance.identifies_as?( Array ).should == false
    instance.identities.should == [ ]    
    instance.is_a?( Array ).should == false
    ( Array === instance ).should == false
        
  end

  ####################################
  #  instances_identify_as!          #
  #  instances_identify_as?          #
  #  instance_identities             #
  #  stop_instances_identifying_as!  #
  #  is_a?                           #
  #  ===                             #
  #  <                               #
  #  >                               #
  #  <=>                             #
  ####################################
  
  it 'lets a class pretend its instances are also types of another object' do

    class SomeOtherClass
    end
    
    module SomeModule
    end

    class NotAnArray
      include ::IdentifiesAs
      identifies_as!( Array )
      instances_identify_as!( Array )
      identifies_as!( SomeOtherClass )
      instances_identify_as!( SomeModule )
    end
    class AlsoNotAnArray < NotAnArray
    end
    
    module Unrelated
    end
    
    NotAnArray.is_a?( SomeOtherClass ).should == true
    ( NotAnArray < Array ).should == true
    ( NotAnArray > Array ).should == false
    ( NotAnArray <= Array ).should == true
    ( NotAnArray >= Array ).should == false

    ( NotAnArray <=> Array ).should == -1
    ( Array <=> NotAnArray ).should == 1
    ( NotAnArray <=> NotAnArray ).should == 0
    ( NotAnArray <=> Unrelated ).should == nil

    AlsoNotAnArray.is_a?( SomeOtherClass ).should == true
    ( AlsoNotAnArray < Array ).should == true
    ( AlsoNotAnArray > Array ).should == false
    ( AlsoNotAnArray <= Array ).should == true
    ( AlsoNotAnArray >= Array ).should == false

    ( AlsoNotAnArray <=> NotAnArray ).should == -1
    ( NotAnArray <=> AlsoNotAnArray ).should == 1
    ( AlsoNotAnArray <=> Array ).should == -1
    ( Array <=> AlsoNotAnArray ).should == 1
    ( AlsoNotAnArray <=> AlsoNotAnArray ).should == 0
    ( AlsoNotAnArray <=> Unrelated ).should == nil
    
    not_an_array_instance = NotAnArray.new
    not_an_array_instance.identifies_as?( Array ).should == true
    not_an_array_instance.is_a?( Array ).should == true
    ( Array === not_an_array_instance ).should == true
    not_an_array_instance.identifies_as?( SomeModule ).should == true
    not_an_array_instance.is_a?( SomeModule ).should == true
    ( SomeModule === not_an_array_instance ).should == true

    also_not_an_array_instance = AlsoNotAnArray.new
    also_not_an_array_instance.identifies_as?( Array ).should == true
    also_not_an_array_instance.is_a?( Array ).should == true
    ( Array === also_not_an_array_instance ).should == true
    ( SomeModule === also_not_an_array_instance ).should == true
    also_not_an_array_instance.identifies_as?( SomeModule ).should == true
    also_not_an_array_instance.is_a?( SomeModule ).should == true

    module IncludersActLikeArray
      include IdentifiesAs
      instances_identify_as!( Array )
    end

    class AnotherNonArray
      include IncludersActLikeArray
    end

    another_non_array_instance = AnotherNonArray.new
    another_non_array_instance.identifies_as?( Array ).should == true
    another_non_array_instance.is_a?( Array ).should == true
    ( Array === another_non_array_instance ).should == true
    

    module IncludersAlsoActLikeArray
      include IncludersActLikeArray
    end

    class AndAnotherNonArray
      include IncludersAlsoActLikeArray
    end
    
    and_another_non_array_instance = AndAnotherNonArray.new
    and_another_non_array_instance.identifies_as?( Array ).should == true
    and_another_non_array_instance.is_a?( Array ).should == true
    ( Array === and_another_non_array_instance ).should == true
    
    AndAnotherNonArray.stop_instances_identifying_as!( Array )
    and_another_non_array_instance.identifies_as?( Array ).should == false
    and_another_non_array_instance.is_a?( Array ).should == false
    ( Array === and_another_non_array_instance ).should == false

    AnotherNonArray.stop_instances_identifying_as!( Array )
    another_non_array_instance.identifies_as?( Array ).should == false
    another_non_array_instance.is_a?( Array ).should == false
    ( Array === another_non_array_instance ).should == false
    
  end
  
end
