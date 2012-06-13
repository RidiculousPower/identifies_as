
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
    instance.extend( IdentifiesAs )
    
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

    class NotAnArray
      include IdentifiesAs
      identifies_as!( Array )
      instances_identify_as!( Array )
      identifies_as!( SomeOtherClass )
    end
    class AlsoNotAnArray < NotAnArray
    end
    
    NotAnArray.is_a?( SomeOtherClass ).should == true
    
    instance = NotAnArray.new
    instance.identifies_as?( Array ).should == true
    instance.is_a?( Array ).should == true
    ( Array === instance ).should == true

    instance = AlsoNotAnArray.new
    instance.identifies_as?( Array ).should == true
    instance.is_a?( Array ).should == true
    ( Array === instance ).should == true

    module IncludersActLikeArray
      include IdentifiesAs
      instances_identify_as!( Array )
    end

    class AnotherNonArray
      include IncludersActLikeArray
    end

    module IncludersAlsoActLikeArray
      include IncludersActLikeArray
    end

    class AndAnotherNonArray
      include IncludersAlsoActLikeArray
    end
    
    instance = AnotherNonArray.new
    instance.identifies_as?( Array ).should == true
    instance.is_a?( Array ).should == true
    ( Array === instance ).should == true
    
  end
  
end
