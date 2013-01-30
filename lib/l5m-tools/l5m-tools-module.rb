require 'l5m-tools/application'

module L5MTools 
    class << self 
        def application
          @application ||= L5MTools::Application.new
        end
    end
end