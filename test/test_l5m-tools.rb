require 'helper'

class TestL5mTools < Test::Unit::TestCase
#  should "probably rename this file and start testing for real" do
#    flunk "hey buddy, you should probably rename this file and start testing for real"
#  end

    should "duplicate app test" do        
        L5MTools.application.run('dup', 'c:/files.cvs', 'HelloWorld', 'Yahoo')    
    end
    #should "make app test" do        
       #L5MTools.application.make_app  
    #end
    
end
