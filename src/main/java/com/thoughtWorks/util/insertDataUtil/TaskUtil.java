package com.thoughtWorks.util.insertDataUtil;

import org.junit.Test;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

public class TaskUtil {
    private Connection conn = null;
    private Statement state = null;

    @Test
    public void test() throws Exception {
        try {
            conn = Dao.getDao();
            state = conn.createStatement();
            File file = new File("/home/ubuntu/IDEA/demo/ssm/demo/sql/s_tudent.sql");
            if (file.isFile() && file.exists()) {
                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file), "GBK");
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt;
                while ((lineTxt = bufferedReader.readLine()) != null) {
                    state.executeUpdate(lineTxt);
                }
                bufferedReader.close();
                read.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            Dao.close(state, conn);
        }
    }

    public void insertUser() {
        synchronized (TaskUtil.class) {
            long time = new Date().getTime();
            System.out.println("start:" + time);
            String studentsSql = "SELECT no,name,idcard FROM t_student_ex";

            try {
                conn = Dao.getDao();
                state = conn.createStatement();

                ArrayList<String> studentNos = allUserNos();

                ResultSet result = state.executeQuery(studentsSql);
                while (result.next()) {
                    if (!studentNos.contains(result.getString(1))) {
                        insert(result);
                    }
                }
                System.out.println("end:" + (new Date().getTime() - time));
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                Dao.close(state, conn);
            }

        }
    }

    private ArrayList<String> allUserNos() throws Exception {
        String studentsNosSql = "SELECT username FROM t_user";
        ArrayList<String> studentNos = new ArrayList<>();
        ResultSet nos = state.executeQuery(studentsNosSql);

        while (nos.next()) {
            studentNos.add(nos.getString(1));
        }

        return studentNos;
    }

    private void insert(ResultSet result) throws SQLException {
        String no = result.getString(1);
        String pwd = result.getString(3).substring(result.getString(3).length() - 6);
        String name = result.getString(2);
        StringBuffer sql = new StringBuffer("insert into t_user values(");
        sql.append(no).append(",'");
        sql.append(pwd).append("',3,1,'");
        sql.append(name).append("','学生')");
        conn.prepareStatement(sql.toString()).executeUpdate();
    }

    public void updateNewUser() {
        String studentsSql = "UPDATE t_user SET staff='学生' where roleId=3";
        try {
            conn = Dao.getDao();
            state = conn.createStatement();
            state.executeQuery(studentsSql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            Dao.close(state, conn);
        }

    }

}