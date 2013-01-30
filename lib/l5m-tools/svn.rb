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
    end

end