package main.until;


import java.sql.Connection;
import java.sql.DriverManager;


public class ConnectionDB {

    //定义一个可以调用连接
    public static Connection con = null;


    //连接数据库
    //账号  密码  数据库 名字
    public ConnectionDB(String account, String password, String dbName) {//数据库的账号，数据库的密码 ，数据库的名字

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Loaded driver successfully");

        } catch (Exception e) {
            // TODO: handle exception
            System.out.println("Failed to load driver");
            e.printStackTrace();
        }

        String url = "jdbc:mysql://localhost:3306/" + dbName + "?characterEncoding=utf-8&useSSL=false&serverTimezone=GMT";

        //连接数据库
        try {
            con = DriverManager.getConnection(url, account, password);
            System.out.println("Connected to the database successfully");

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            System.out.println("Failed to connect to the database");
        }
    }

}
