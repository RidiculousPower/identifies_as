
require_relative '../lib/identifies_as.rb'

describe ::IdentifiesAs do

  ######################################
  #  identifies_as!                    #
  #  identifies_as?                    #
  #  instances_identify_as!            #
  #  instances_identify_as?            #
  #  identities                        #
  #  no_longer_identifies_as!          #
  #  instances_no_longer_identify_as!  #
  #  is_a?                             #
  #  ===                               #
  ######################################
  
  it 'lets an object pretend it is another object' do
    
    instance = Object.new
    instance.extend( IdentifiesAs )
    
    instance.identifies_as!( Array )
    instance.identifies_as?( Array ).should == true
    instance.identities.should == [ Array ]
    
    instance.is_a?( Array ).should == true
    ( Array === instance ).should == true

    class SomeOtherClass
    end
    class NotAnArray
      include IdentifiesAs
      identifies_as!( Array )
      instances_identify_as!( Array )
      identifies_as!( SomeOtherClass )
    end
    
    NotAnArray.is_a?( SomeOtherClass ).should == true
    
    instance = NotAnArray.new
    instance.identifies_as?( Array ).should == true
    instance.is_a?( Array ).should == true
    ( Array === instance ).should == true
    
  end
  
end
