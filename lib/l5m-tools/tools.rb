module L5MTools
    module Tools
        def send_mail to, subject="", body=""
            require 'win32ole'
            outlook = WIN32OLE.new('Outlook.Application') 
            mapi = outlook.GetNameSpace('MAPI')
            message = outlook.CreateItem(0) 
            message.Subject =   subject
            message.Body = body
            message.To = to
            message.Save
            message.Send
            mapi.SyncObjects
        end
        
        require "fileutils"
        include FileUtils
        require 'pathname'
        
        def replace(in_file, replacements)
            contents = IO.read(in_file)
            changed = false
            replacements.each do | key, value |
                if(contents.gsub!(key, value))
                    changed = true;
                end
            end
            File.open(in_file, 'w') { | io | io.puts(contents) } 
            return changed
        end
        def copy_silently(from, to, replacements)
            copy(from, to)
            replace(to, replacements)
        end
        def change_directory(dir, &operation)
            return Dir::chdir(dir, &operation) if File.exists? dir
        end        
        def ask(default_answer, *question_lines)
            puts question_lines
            print "[#{default_answer}] => "
            answer = STDIN.readline.strip       
            answer == '' ? default_answer.to_s : answer.to_s
        end


        def to_file(file, replacements = {}) 
            dirname =  File.dirname(file)
            basename = File.basename(file)
            replacements.each do | key, value |
                basename.gsub!(key, value)
            end
            dirname + File::SEPARATOR + basename; 
        end

        def duplicate_and_replace(file, replacements = {})
            to = to_file(file, replacements)
            yield to if block_given?
            copy_silently(file, to, replacements)           
        end
        
        
        def user_home
            require 'etc'
            Etc.getpwuid.dir
        end
        
        #module_function :send_mail, :replace, :copy_silently, :change_directory, :ask    
    end
end
