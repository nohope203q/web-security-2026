package com.mycompany.project;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;
import java.io.File;

public class AppServer {
    public static void main(String[] args) throws Exception {
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);
        tomcat.getConnector(); 
        String webappDirLocation = "src/main/webapp/";
        File webappDir = new File(webappDirLocation);
        Context ctx = tomcat.addWebapp("", webappDir.getAbsolutePath());
        ctx.setParentClassLoader(AppServer.class.getClassLoader());

        System.out.println("🚀 Running Application at: http://localhost:8080/home");
        
        tomcat.start();
        tomcat.getServer().await();
    }
}