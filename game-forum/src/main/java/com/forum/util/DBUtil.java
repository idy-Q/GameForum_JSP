package com.forum.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {
    // 使用 Properties 对象存储配置
    private static final Properties PROPERTIES = new Properties();

    static {
        // 尝试加载 db.properties 文件
        try (InputStream is = DBUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (is == null) {
                throw new RuntimeException("无法找到 db.properties 文件！");
            }
            PROPERTIES.load(is);

            // 尝试加载驱动
            Class.forName(PROPERTIES.getProperty("db.driver"));
        } catch (IOException e) {
            System.err.println("加载 db.properties 文件失败。");
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            System.err.println("数据库驱动加载失败。");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        String url = PROPERTIES.getProperty("db.url");
        String username = PROPERTIES.getProperty("db.username");
        String password = PROPERTIES.getProperty("db.password");

        return DriverManager.getConnection(url, username, password);
    }

}