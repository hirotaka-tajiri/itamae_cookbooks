[
    "apache-commons-collections",
    "apache-commons-daemon",
    "apache-commons-dbcp",
    "apache-commons-logging",
    "apache-commons-pool",
    "avalon-framework",
    "avalon-logkit",
    "copy-jdk-configs",
    "ecj",
    "fontconfig",
    "fontpackages-filesystem",
    "geronimo-jms",
    "geronimo-jta",
    "giflib",
    "java-1.8.0-openjdk",
    "java-1.8.0-openjdk-headless",
    "javamail",
    "javapackages-tools",
    "libICE",
    "libSM",
    "libX11",
    "libX11-common",
    "libXau",
    "libXcomposite",
    "libXext",
    "libXfont",
    "libXi",
    "libXrender",
    "libXtst",
    "libfontenc",
    "libjpeg-turbo",
    "libpng",
    "libxcb",
    "libxslt",
    "lksctp-tools",
    "log4j",
    "python-javapackages",
    "python-lxml",
    "ttmkfdir",
    "tzdata-java",
    "xalan-j2",
    "xerces-j2",
    "xml-commons-apis",
    "xml-commons-resolver",
    "xorg-x11-font-utils",
    "xorg-x11-fonts-Type1",
    "tomcat",
    "tomcat-el-2.2-api",
    "tomcat-jsp-2.2-api",
    "tomcat-lib",
    "tomcat-servlet-3.0-api",
].each{| pkg |
    package pkg do
        action :install
    end
}

[
    ["/etc/tomcat/tomcat-users.xml",          "files/tomcat-users.xml", "root",   "tomcat", "0640"],
].each{| file_ary |
    template "#{file_ary[0]}" do
        action :create
        source "#{file_ary[1]}"
        owner  "#{file_ary[2]}"
        group  "#{file_ary[3]}"
        mode   "#{file_ary[4]}"
    end
}

[ 
    ["/var/lib/tomcat/webapps/gitbucket.war", "files/gitbucket.war",    "tomcat", "tomcat", "0644"],
].each{| file_ary |
    remote_file "#{file_ary[0]}" do
        action :create
        source "#{file_ary[1]}"
        owner  "#{file_ary[2]}"
        group  "#{file_ary[3]}"
        mode   "#{file_ary[4]}"
    end
}

service "tomcat" do
    action [:enable, :restart]
end
