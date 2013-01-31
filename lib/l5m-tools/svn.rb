module L5MTools
    class SVN
        class << self
            def method_missing(method_id, *arguments, &block)
                self.class_eval %{
                    def self.#{method_id}(*args, &b)
                        cmd = "svn #{method_id} "
                        cmd << args.join(" ") if args
                        `\#{cmd}`
                    end
                }, __FILE__, __LINE__
                send(method_id, *arguments, &block)
            end        
        end
        
        def run(*args, &block)
            cmd = args.shift
            args = args[0..(args.index '--')] if args.index '--'
            options = {}
            options[:username] = args.option! '--user'
            options[:reverse] = args.delete('-r')
            options[:date] = args.option!('--date')
            options[:mail] = args.delete('-e') || args.delete('--email');
            options[:username] ||= SVN_USER
            packages =  args.empty? ? PACKAGES : args
            result = case cmd
                when 'status', 'st' then svn_status(packages)
                when 'update' then svn_update(packages)
                when 'log' then svn_log(packages, options[:date] , options[:username] , options[:reverse])
                else usage   
            end  
            #send_mail(SEND_TO, "svn #{cmd} @#{Time.now.strftime("%F %T")}" , result) if options[:mail] || (puts result) unless result.nil? || result.empty?       
        end       
    end
    class Application    
        

    end
end