module L5MTools
    raise "no WORKSPACE env " unless WORKSPACE = ENV["WORKSPACE"] || ENV["workspace"]   
    raise "no CATALINA_HOME env" unless CATALINA_HOME = ENV["CATALINA_HOME"]    
    raise "no SVN_USER env" unless SVN_USER = ENV["SVN_USER"]
    raise "no SENDER_EMAIL env" unless SENDER_EMAIL = ENV["SENDER_EMAIL"]
    PACKAGES = ENV["PACKAGES"].split(/[,;:]/) if ENV["PACKAGES"]
    DEV_HOST = ENV["DEV_HOST"]
end