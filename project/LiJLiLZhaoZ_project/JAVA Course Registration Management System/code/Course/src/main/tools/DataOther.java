package main.tools;

import java.sql.ResultSet;
import java.sql.SQLException;

public class DataOther {

    public static void setCoursSta(String sql, String[] data) {
        int num = Mysql.upDate(sql, data);
        if (num == 0) {
            Tools.messageWindows("Please Check the Course Name");
        } else {
            Tools.messageWindows("Successfully Withdrawn");
        }
    }

    public static String showCoursSta(String sql, String[] data) {
        ResultSet rs = Mysql.QueryData(sql, data);
        try {
            while (rs.next()) {
                return rs.getString("star");
            }
            return "";
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return "";
        }
    }

}
