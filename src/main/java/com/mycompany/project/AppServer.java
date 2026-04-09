package com.mycompany.project;
import org.apache.catalina.Context;
import org.apache.catalina.connector.Connector;
import org.apache.catalina.startup.Tomcat;
import org.apache.tomcat.util.net.SSLHostConfig;
import org.apache.tomcat.util.net.SSLHostConfigCertificate;
import java.io.*;
import java.net.URI;
import java.util.Enumeration;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

public class AppServer {
    public static void main(String[] args) throws Exception {
        Tomcat tomcat = new Tomcat();

        // Cấu hình HTTPS connector
        Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
        connector.setPort(8080);
        connector.setScheme("https");
        connector.setSecure(true);
        connector.setProperty("SSLEnabled", "true");

        SSLHostConfig sslHostConfig = new SSLHostConfig();
        SSLHostConfigCertificate cert = new SSLHostConfigCertificate(
            sslHostConfig, SSLHostConfigCertificate.Type.RSA
        );

        // Trỏ đến file .p12 trong thư mục conf/ (cùng cấp với thư mục chạy)
        String keystorePath = new File("conf/localhost-rsa.p12").getAbsolutePath();
        cert.setCertificateKeystoreFile(keystorePath);
        cert.setCertificateKeystorePassword("123456a@");
        cert.setCertificateKeystoreType("PKCS12");

        sslHostConfig.addCertificate(cert);
        connector.addSslHostConfig(sslHostConfig);

        tomcat.setConnector(connector);

        File webappDir = extractWebapp();
        Context ctx = tomcat.addWebapp("", webappDir.getAbsolutePath());
        ctx.setParentClassLoader(AppServer.class.getClassLoader());

        System.out.println("Running Application at: https://localhost:8080/home");
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