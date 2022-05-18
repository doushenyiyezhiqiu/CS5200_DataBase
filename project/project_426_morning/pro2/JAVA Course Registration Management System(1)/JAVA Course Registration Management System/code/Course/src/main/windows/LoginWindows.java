package main.windows;

import main.style.StyleFont;
import main.tools.EasyCode;
import main.tools.Mysql;
import main.tools.Tools;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;

public class LoginWindows {

    final int WIDTH = 550;
    final int HEIGHT = 350;
    //定义一个界面
    JFrame jFrame = new JFrame();

    //登录界面
    public LoginWindows() {


        init();
        jFrame.setResizable(false);//窗口是否可变
        jFrame.setVisible(true);//窗口是否可见
        jFrame.setDefaultCloseOperation(jFrame.DISPOSE_ON_CLOSE);//设置默认关闭方式
        jFrame.validate();//让组件生效
        //这种写法 可以避免打包成exe文件或者jar时候文件丢失的问题

    }

    void init() {


        //设置窗口在屏幕中间  并设置大小
        Tools.setWindowPos(WIDTH, HEIGHT, jFrame);
        EasyCode.setTileIcon(jFrame);//设置标题和图标

        jFrame.setLayout(null);

        //设置背景图片
        ImageIcon img = new ImageIcon("code/Course/src/img/LoginImg.jpg");//加载图片
        JLabel bgImg = new JLabel(img);//定义一个标签用于存放图片
        bgImg.setBounds(0, 0, WIDTH, HEIGHT);//设置标签大小

        JPanel loginPanel = new JPanel();//定义一个盘子装标题
        loginPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 0, HEIGHT / 3 / 2 - 36));
        loginPanel.setOpaque(false);
        loginPanel.setBounds(0, 0, WIDTH, HEIGHT / 3);
        JLabel content = new JLabel("Course Registration Management System");
        loginPanel.add(content);
        content.setFont(StyleFont.titleFont);
        content.setForeground(Color.ORANGE);


        JPanel actAndPwsPanel = new JPanel();//存放账号和密码
        actAndPwsPanel.setLayout(new FlowLayout(FlowLayout.CENTER));//设置居中对齐
        actAndPwsPanel.setBounds(0, HEIGHT / 3, WIDTH, HEIGHT / 3 - 15);
        actAndPwsPanel.setBackground(new Color(235, 229, 209));
        Box boxH;
        Box boxOne, boxTwo;
        boxH = Box.createHorizontalBox();
        boxOne = Box.createVerticalBox();
        boxTwo = Box.createVerticalBox();


        //______________________________________________________
        ImageIcon img1 = new ImageIcon("code/Course/src/WindowsIcon/zhanghao.png");//加载图片
        JLabel bgImg1 = new JLabel(img1);//定义一个标签用于存放图片

        //jPanel2.add(bgImg1);


        JTextField tfUsername = new JTextField(14);
        // jPanel2.add(jTextField);

        ImageIcon img2 = new ImageIcon("code/Course/src/WindowsIcon/mima54.png");//加载图片
        JLabel bgImg2 = new JLabel(img2);//定义一个标签用于存放图片
        // jPanel2.add(bgImg2);


        JPasswordField pfPasswords = new JPasswordField(14);
        //  jPanel2.add(pfPasswords);


        //定义盘子3装  登录按钮 和 找回密码

        JPanel jPanel3 = new JPanel();
        jPanel3.setLayout(new FlowLayout(FlowLayout.CENTER));
        jPanel3.setBounds(0, HEIGHT / 3 * 2 - 15, WIDTH, HEIGHT / 3 + 10);
        jPanel3.setBackground(Color.PINK);
        JButton btnLogin = new JButton("Login");
        jPanel3.add(btnLogin);
        btnLogin.setPreferredSize(new Dimension(175, 27));
        btnLogin.setBackground(new Color(5, 4, 4));
        btnLogin.setForeground(new Color(3, 3, 3));
        btnLogin.setFont(StyleFont.loginFont);


        boxOne.add(bgImg1);
        boxOne.add(bgImg2);
        boxTwo.add(tfUsername);
        boxTwo.add(pfPasswords);

        boxH.add(boxOne);
        boxH.add(Box.createHorizontalStrut(10));//设置组件之间间隔
        boxH.add(boxTwo);
        actAndPwsPanel.add(boxH);

        //______________________________________________________

        jFrame.add(jPanel3);
        jFrame.add(actAndPwsPanel);
        jFrame.add(loginPanel);
        jFrame.add(bgImg);


        //对事件处理
        btnLogin.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub


                String accountString = tfUsername.getText();
                String password = Tools.getPassword(pfPasswords);

                if (accountString.equals("")) {
                    Tools.messageWindows("Account Cannot Be Empty");
                    //账号不能为空
                } else if (password.equals("")) {
                    //密码不能为空
                    Tools.messageWindows("Password Cannot Be Empty");
                } else {
                    String[] data = new String[2];//初始化一个数组
                    data[0] = accountString;
                    data[1] = password;
                    String sqlString = "select * from users where account=? and password=?";
                    ResultSet rs = Mysql.QueryData(sqlString, data);
                    try {

                        if (rs.next()) {
                            String poString = rs.getString("pow");

                            if (poString.equals("1")) {
                                //登录管理员界面
                                ManageWindows Windows = new ManageWindows();
                                jFrame.dispose();


                            }

                            if (poString.equals("2")) {
                                //登录老师界面
                                TeacherWindows Windows = new TeacherWindows(accountString);
                                jFrame.dispose();
                            }

                            if (poString.equals("3")) {
                                //登录学生界面
                                StudentWindows Windows = new StudentWindows(accountString);
                                jFrame.dispose();

                            }
                            rs.close();
                        } else {
                            Tools.messageWindows("Wrong Account or Password");
                        }


                    } catch (Exception e2) {
                        // TODO: handle exception
                    }

                }


            }
        });

    }

}
