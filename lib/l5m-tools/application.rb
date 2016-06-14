require 'l5m-tools/env'
require 'pathname'

module L5MTools    
    TEMPLATE_DIR = Pathname.new(__FILE__).parent + 'template'    
    class Application
        require 'l5m-tools/tools'
        include Tools

        #that is svn remove
        def rm(file, options)
            #FileUtils.rm(file, :force => true)
            # remove file from svn
            package = file[(WORKSPACE.length+1)..(-1)]
            svnfile = package[(package.index(/[\/\\]/) + 1)..(-1)]
            package = package[0...(package.index(/[\/\\]/))]
            require 'l5m-tools/l5m-tools-module'
            L5MTools.svn.delete([package], {}, [ "--force", svnfile])
        end


        def search_files(package, application)
            Dir.glob("#{WORKSPACE}/#{package}/{src,WebContent}/**/#{application}*.*", File::FNM_CASEFOLD).each{|line|  
                bn = File.basename(line, ".*")
                unless(bn[application.length] =~ /[a-z0-9]/)
                    yield line if block_given?
                end              
            }
        end

        def read_files(csvfile)
            File.open(csvfile, "r") do |infile|
                while (line = infile.gets)
                    line = line.chomp.strip
                    if line.length > 0 && line[0] != '#'
                        yield line if block_given?
                    end
                end
            end
        end

        def duplicate_app(*args)
            delete = args.delete('-d')
            replacements  = {args[1] => args[2]}
            p = ->(line){
                rm(line, :force => true) if duplicate_and_replace( line.chomp ,  replacements )[1] != line && delete
            }
            if File.exist?(args[0])
                read_files(args[0], &p)
            else
                search_files(args[0], args[1], &p)
            end
        end

       
        def del(*args)
            p = ->(file){
                rm(file, :force => true)
                puts file
            }
            if File.exist?(args[0])
                read_files(args[0], &p)
            else
                search_files(args[0], args[1], &p)
            end
        end
        def make_app(package, application, use_base_worker, &block)
            application[0] = application[0].capitalize 
            replacements = {
              '!REPLACE_ME_FILE!' => application,
              '!REPLACE_STYLE!' => package
            }
            [ 
              #worker
              ["#{TEMPLATE_DIR}/"<<( use_base_worker ? "TemplateBaseAbstractWorker.java" : "TemplateWorker.java") , "#{WORKSPACE}/#{package}/src/com/l5m/#{package}/engine/worker/#{application}Worker.java"],
              #servicer
              ["#{TEMPLATE_DIR}/TemplateServicerImpl.java", "#{WORKSPACE}/#{package}/src/com/l5m/#{package}/engine/servicer/#{application}ServicerImpl.java" ],
              #Viewer
              ["#{TEMPLATE_DIR}/TemplateViewer.java", "#{WORKSPACE}/#{package}/src/com/l5m/#{package}/engine/exporter/#{application}Viewer.java"  ],
              #jsp
              [File.exist?( TEMPLATE_DIR+"#{package}.jsp") ? TEMPLATE_DIR+"#{package}.jsp" : TEMPLATE_DIR+"Template.jsp",  "#{WORKSPACE}/#{package}/src/jsp/#{application}.jsp"]
            ].each{ |(a, b)|
                copy_with_replace(a, b, replacements)
            }
            block.call(Time.now, package, application, use_base_worker) if block_given?
        end

        def version
            file = Pathname.new(__FILE__).parent.parent.parent.to_s + "/VERSION"
            puts(File.exist?(file) ? File.read(file) : "") 
        end
        def help
            puts <<-EOF
                Please go to https://github.com/RONGHAI/l5m-tools
            EOF
        end
    end
end
