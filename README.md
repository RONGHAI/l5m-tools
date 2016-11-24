### l5m-tools

* This is a tool set for Lake 5 Media and Qinghe Tech Programmer.  
* It includes make-app for creating a new app.

### Usage
* first please install svn and git
* please add the following sys env variables
    * WORKSPACE
    * CATALINA_HOME
    * SVN_USER
    * SENDER_EMAIL
    * PAKAGES #common;qhtcommon;customtags;rem
    * DEV_HOST 
* `$l5m make` or `$make-app`# to create a new app
* `$l5m dup file.csv original new` or `$duplicate-app file.csv original new`  #duplicate a app with the files in file.csv, and use new to replace original
* `$l5m dup package original new` #duplicate an application from special package, no file.csv required.
* `$l5m svn status` #ls all uncommitted files
* `$l5m svn log` #ls all today's commits
* `$l5m svn update packs` #update all packges.


### Copyright

Copyright (c) 2013 RONGHAI WEI. See LICENSE.txt for further details.

