require 'l5m-tools/env'
require 'pathname'

module L5MTools
    class SVN
        require 'l5m-tools/tools'
        include Tools
        require 'l5m-tools/array'
        require 'yaml'
        
        class << self
            require "fileutils"
            include FileUtils
        end        
        copy(Pathname.new(__FILE__).parent + 'ignore/svn_ingore.yaml', File.expand_path('~/svn_ingore.yaml')) unless File.exists? File.expand_path('~/svn_ingore.yaml')
        IGNORE_FILES = YAML::load(File.open(File.expand_path('~/svn_ingore.yaml'), 'rb') { |f| f.read } )        
        SPERATE = "------------------------------------------------------------------------"        
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
        
        def method_missing(method_id, *arguments, &block) 
            self.class.class_eval %{
                def #{method_id}(packz, options={}, svn_options=[], &b)
                    rs = ''
                    packz.each{|pac|
                        next unless change_to_package_directory(pac)                       
                        rs << SVN.#{method_id}(*svn_options)
                    }
                    rs
                end
            }, __FILE__, __LINE__
            puts 
            send(method_id, arguments[0], arguments[1], arguments[2], &block)
        end
        
        def change_to_package_directory package
            change_directory "#{WORKSPACE}/#{package}"
        end
      

        def log packages, options={}, svn_options=[]
            log = ''
            usr = options[:username] || ''
            date = options[:date] || Date.today.strftime("%F")
            reverse = options[:reverse]            
            packages.each{|pac|     
                next unless change_to_package_directory(pac)
                commits =  SVN.log("-q", "-r", "HEAD:{#{date}}") .split($/).delete_if{|c| c[0] == '-' || (usr != '' && c.split("|")[1].strip != usr)}.collect! {|c| c.split("|")[0].strip[1..-1]}.sort!
                commits.reverse! if reverse
                commits.each{|c|
                    log << SVN.log("-v", "-r", c).gsub!(/(#{$/}){2,}/m,$/+$/)
                }
            }
            log.gsub!(/(#{SPERATE}#{$/}#{SPERATE})/m, SPERATE)
            log
        end 
        
        def status packages, options={}, svn_options=[]
            status  = ''
            packages.each{|pac| 
                innert_dirs =(pac.include?("tag"))?["src", "WebContent"]:["src"];
                lines = [];
                innert_dirs.each{|d|             
                    next unless change_to_package_directory("#{pac}/#{d}")
                    lines += (SVN.status).split($/)
                 }
                lines -= IGNORE_FILES[pac] unless IGNORE_FILES[pac].nil?
                status << "#{pac} #{$/}" << lines.join($/) << "#{$/}" unless lines.empty?
            } 
            status
        end

        def update packages, options={}, svn_options=[]
            log = ''
            packages.each{|pac|
                next unless change_to_package_directory(pac)
                log << pac+"...#{$/}"
                log << SVN.update
            }
            log
        end
        alias :st :status
        def run(*args, &block)
            cmd = args.shift
            cmd = args.shift if 'svn' == cmd
            args , svn_args = args[0..(args.index '--')], args[((args.index '--')+1)..-1] if args.index '--'
           
            options = {username:((args.option! '--user') || SVN_USER), reverse:(args.delete('-r')), date: (args.option!('--date')), mail:(args.delete('-e') || args.delete('--email')) }          
            options[:sendto] = args.option!('-s') || SENDER_EMAIL
            options[:title]  = args.option!('--title') || "svn #{cmd} @#{Time.now.strftime("%F %T")}" 
            
            packages =  args.empty? ? PACKAGES : args
            
            result = send cmd, packages, options, svn_args
            send_mail(options[:sendto], options[:title] , result) if options[:mail]
            block.call(result) if block_given?
            result
        end
    end
end
