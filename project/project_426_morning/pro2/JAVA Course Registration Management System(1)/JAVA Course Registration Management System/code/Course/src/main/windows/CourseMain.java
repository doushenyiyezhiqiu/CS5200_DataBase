package main.windows;

import main.until.ConnectionDB;

public class CourseMain {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
        LoginWindows loginWindows = new LoginWindows();
        ConnectionDB db = new ConnectionDB("root", "Alijuncen@123", "initial");//数据库的账号 ，和数据的密码 和数据对的名字
    }

}
