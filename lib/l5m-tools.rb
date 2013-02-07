require 'l5m-tools/l5m-tools-module'
require 'l5m-tools/string'
require 'l5m-tools/svn'

module L5MTools
    class Application
        alias old_make_app make_app        
        def make_app(*args, &block)
            package = ask("rem","Please input package name").downcase
            application = ask("","Please input application name") 
            use_base_worker = ask("true","Use AbstractBaseWorker?").to_boolean
            old_make_app(package, application, use_base_worker, &block)
        end
        alias :make :make_app
        alias :dup :duplicate_app        
        def run(*args, &block)
            send args.shift, *args, &block
        end
    end
end
