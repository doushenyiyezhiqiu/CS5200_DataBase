package main.tools;

import main.until.ConnectionDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Mysql {


    static Connection con = ConnectionDB.con;

    public static int upDate(String sqlStr, String[] data) {

        PreparedStatement preSql;
        int num;
        try {

            preSql = con.prepareStatement(sqlStr);
            if (data == null) {
                num = preSql.executeUpdate();
            } else {


                for (int i = 0; i < data.length; i++) {
                    preSql.setString(i + 1, data[i]);

                }

                num = preSql.executeUpdate();

            }


            return num;


        } catch (SQLException e) {
            // TODO: handle exception
            //	e.printStackTrace();
            return -1;
        }


    }


    public static ResultSet QueryData(String sqlStr, String[] data) {

        ResultSet rs = null;
        PreparedStatement preSql;
        try {

            preSql = con.prepareStatement(sqlStr);

            if (data != null) {
                for (int i = 0; i < data.length; i++) {

                    preSql.setString(i + 1, data[i]);
                }


            }


            //System.out.println(preSql);
            rs = preSql.executeQuery();

            return rs;


        } catch (SQLException e) {
            // TODO: handle exception
            //e.printStackTrace();
            return rs;
        }

    }


}
