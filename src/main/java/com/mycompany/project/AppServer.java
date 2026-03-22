package com.mycompany.project;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;
import java.io.*;
import java.net.URI;
import java.util.Enumeration;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

public class AppServer {
    public static void main(String[] args) throws Exception {
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);
        tomcat.getConnector();

        File webappDir = extractWebapp();

        Context ctx = tomcat.addWebapp("", webappDir.getAbsolutePath());
        ctx.setParentClassLoader(AppServer.class.getClassLoader());

        System.out.println("🚀 Running Application at: http://localhost:8080/home");
        tomcat.start();
        tomcat.getServer().await();
    }

    private static File extractWebapp() throws Exception {
        URI jarUri = AppServer.class.getProtectionDomain().getCodeSource().getLocation().toURI();
        File jarFile = new File(jarUri);

        if (jarFile.isFile()) {
            // Chạy từ JAR → extract webapp ra thư mục temp
            File tempDir = new File(System.getProperty("java.io.tmpdir"), "webapp-embedded");
            if (tempDir.exists()) deleteDir(tempDir);
            tempDir.mkdirs();

            try (JarFile jar = new JarFile(jarFile)) {
                Enumeration<JarEntry> entries = jar.entries();
                while (entries.hasMoreElements()) {
                    JarEntry entry = entries.nextElement();
                    String name = entry.getName();
                    if (!name.startsWith("webapp/")) continue;

                    String relativePath = name.substring("webapp/".length());
                    if (relativePath.isEmpty()) continue;

                    File outFile = new File(tempDir, relativePath);
                    if (entry.isDirectory()) {
                        outFile.mkdirs();
                    } else {
                        outFile.getParentFile().mkdirs();
                        try (InputStream in = jar.getInputStream(entry);
                             FileOutputStream out = new FileOutputStream(outFile)) {
                            byte[] buf = new byte[4096];
                            int len;
                            while ((len = in.read(buf)) != -1) out.write(buf, 0, len);
                        }
                    }
                }
            }
            System.out.println("📦 Webapp extracted to: " + tempDir.getAbsolutePath());
            return tempDir;
        } else {
            // Chạy trong IDE → dùng trực tiếp
            return new File("src/main/webapp").getAbsoluteFile();
        }
    }

    private static void deleteDir(File dir) {
        if (dir.isDirectory()) {
            for (File f : dir.listFiles()) deleteDir(f);
        }
        dir.delete();
    }
}