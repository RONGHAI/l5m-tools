require 'l5m-tools/application'
require 'l5m-tools/svn'
module L5MTools 
    class << self 
        def application
          @application ||= L5MTools::Application.new
        end        
        def svn
           @svn ||= L5MTools::SVN.new
        end
    end
end