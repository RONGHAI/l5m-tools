#!/bin/sh
alias svn.log='svn.tool log'
alias svn.status='svn.tool status'
alias svn.update='svn.tool update'
alias update.root='rm -rf $CATALINA_HOME/webapps/ROOT && rm -rf $CATALINA_HOME/webapps/ROOT.war && scp $DEV_HOST:/home/l5m/mytc/webapps/ROOT.war $CATALINA_HOME/webapps'
export JAVA_HOME="C:/Program Files/Java/jdk1.5.0_14"
function update.28(){
    ssh 28 "cd ~/project && ./make_wars.sh $@ && ./deploy_on_28.sh $@"
}
export WEBAPPS='$CATALINA_HOME/webapps' 
#export CLASS_PATH=$(find C:/eclipse/plugins/org.junit4_4.3.1/ "C:/Program Files/Java/jdk1.5.0_14/jre/lib/" "C:/Program Files/Java/jdk1.5.0_14/jre/lib/ext/" C:/Tomcat5.5/common/lib/  C:/Tomcat5.5/common/lib/ C:/Tomcat5.5/shared/lib/ C:/Tomcat5.5/shared/lib/ C:/Tomcat5.5/common/i18n/ -regex ".*\.\(jar\|zip\)"  | xargs echo  |tr ' ' ';')
#export CLASSPATH=$CLASS_PATH
function sync.package(){
    svn.tool.rb status  $1 | awk '{print $2}' | sed '/^$/d' | sed -e 's/\\/\//g' | while read fi ; do echo $fi && cp $WORKSPACE/$1/src/$fi $WORKSPACE/$2/src/$fi; done
}
for d in $ECLIPSE_HOME/plugins/org.junit4_4.3.1/ $JAVA_HOME/jre/lib/ JAVA_HOME/jre/lib/ext/ $CATALINA_HOME/common/lib/  $CATALINA_HOME/common/lib/ $CATALINA_HOME/shared/lib/ $CATALINA_HOME/shared/lib/ $CATALINA_HOME/common/i18n/
do
    export CLASS_PATH = $CLASS_PATH;$(find $i -regex ".*\.\(jar\|zip\)"  | xargs echo  |tr ' ' ';')
done

export CLASSPATH=$CLASS_PATH
