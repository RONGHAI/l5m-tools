require 'l5m-tools/env'
require 'pathname'

module L5MTools    
    TEMPLATE_DIR = Pathname.new(__FILE__).parent + 'template'    
    
    class Application
        require 'l5m-tools/tools'
        include Tools        
        def duplicate_app(*args)
            delete = args.delete('-d')
            replacements  = {args[1] => args[2]}

            unless File.exist?(args[0])
                duplicate_wo_csv(*args)
            else
                File.open(args[0], "r") do |infile|
                    while (line = infile.gets)
                        line = line.chomp.strip
                        if line.length > 0 && line[0] != '#'
                            #duplicate_and_replace( line.chomp ,  replacements ) 
                            #FileUtils.rm(line, :force => true) if delete
                            FileUtils.rm(line, :force => true) if duplicate_and_replace( line.chomp ,  replacements )[1] != line && delete
                        end 
                    end
                end
            end
        end

        def duplicate_wo_csv(*args)
            delete = args.delete('-d')
            package = args[0]
            application = args[1]
            replacements  = {args[1] => args[2]}
            Dir.glob("#{WORKSPACE}/#{package}/{src,WebContent}/**/#{application}*.*", File::FNM_CASEFOLD).each{|line|  
                bn = File.basename(line, ".*")
                #puts line #File.basename(line, ".*") 
                unless(bn[application.length] =~ /[a-z0-9]/)
                    #puts line #File.basename(line, ".*") 
                    FileUtils.rm(line, :force => true) if duplicate_and_replace( line.chomp ,  replacements )[1] != line && delete
                end                
            }
        end

        #read file list from file and delete them
        def del(*args)
            replacements  = {args[1] => args[2]}
            File.open(args[0], "r") do |infile|
                while (line = infile.gets)
                    line = line.chomp.strip
                    if line.length > 0 && line[0] != '#'
                        FileUtils.rm(line, :force => true)
                    end
                end
            end
        end
        def make_app(package, application, use_base_worker, &block)
            application[0] = application[0].capitalize 
            replacements = {
              '!REPLACE_ME_FILE!' => application,
              '!REPLACE_STYLE!' => package
            }  
            copy_with_replace(  use_base_worker  ? (TEMPLATE_DIR+"TemplateBaseAbstractWorker.java") :    (TEMPLATE_DIR+"TemplateWorker.java") , 
                "#{WORKSPACE}/#{package}/src/com/l5m/#{package}/engine/worker/#{application}Worker.java"  , replacements ) 
            copy_with_replace( TEMPLATE_DIR+"TemplateServicerImpl.java" , 
                    "#{WORKSPACE}/#{package}/src/com/l5m/#{package}/engine/servicer/#{application}ServicerImpl.java"  , replacements ) 

            copy_with_replace( TEMPLATE_DIR+"TemplateViewer.java" , 
                    "#{WORKSPACE}/#{package}/src/com/l5m/#{package}/engine/exporter/#{application}Viewer.java"  , replacements ) 

            if File.exist?( TEMPLATE_DIR+"#{package}.jsp")
                copy_with_replace( TEMPLATE_DIR+"#{package}.jsp" ,
                    "#{WORKSPACE}/#{package}/src/jsp/#{application}.jsp" , replacements ) 
            else 
                copy_with_replace( TEMPLATE_DIR+"Template.jsp" , 
                    "#{WORKSPACE}/#{package}/src/jsp/#{application}.jsp" , replacements ) 
            end            
            block.call(Time.now, package, application, use_base_worker) if block_given?
        end
    end
end
