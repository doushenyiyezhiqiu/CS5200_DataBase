package main.tools;

import java.sql.ResultSet;
import java.sql.SQLException;

public class DataOther {
    //用于设置课程数据状态
    public static void setCoursSta(String sql, String[] data) {
        int num = Mysql.upDate(sql, data);
        if (num == 0) {
            Tools.messageWindows("Please Check the Course Name");
        } else {
            Tools.messageWindows("Successfully Withdrawn");
        }
    }

    //查询课程状态
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
