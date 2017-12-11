package com.thoughtWorks.util.insertDataUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Dao {
    private static String user = "root";
    private static String password = "root";
    private static String url = "jdbc:mysql://localhost:3306/stuInfo?useUnicode=true&characterEncoding=GBK";

    public static Connection getDao() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection(url, user, password);
    }

    public static void close(Statement state, Connection conn){
        if(null != state){
            try {
                state.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(null != conn){
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}