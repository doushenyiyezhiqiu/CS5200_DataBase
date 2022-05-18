package main.until;


import java.sql.Connection;
import java.sql.DriverManager;


public class ConnectionDB {

    public static Connection con = null;


    public ConnectionDB(String account, String password, String dbName) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Loaded driver successfully");

        } catch (Exception e) {
            // TODO: handle exception
            System.out.println("Failed to load driver");
            e.printStackTrace();
        }

        String url = "jdbc:mysql://localhost:3306/" + dbName + "?characterEncoding=utf-8&useSSL=false&serverTimezone=GMT";

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
