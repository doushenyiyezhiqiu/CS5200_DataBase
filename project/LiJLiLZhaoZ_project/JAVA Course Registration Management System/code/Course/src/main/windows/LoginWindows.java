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

    JFrame jFrame = new JFrame();


    public LoginWindows() {


        init();
        jFrame.setResizable(false);
        jFrame.setVisible(true);
        jFrame.setDefaultCloseOperation(jFrame.DISPOSE_ON_CLOSE);
        jFrame.validate();


    }

    void init() {



        Tools.setWindowPos(WIDTH, HEIGHT, jFrame);
        EasyCode.setTileIcon(jFrame);

        jFrame.setLayout(null);

        ImageIcon img = new ImageIcon("code/Course/src/img/LoginImg.jpg");
        JLabel bgImg = new JLabel(img);
        bgImg.setBounds(0, 0, WIDTH, HEIGHT);

        JPanel loginPanel = new JPanel();
        loginPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 0, HEIGHT / 3 / 2 - 36));
        loginPanel.setOpaque(false);
        loginPanel.setBounds(0, 0, WIDTH, HEIGHT / 3);
        JLabel content = new JLabel("Course Registration Management System");
        loginPanel.add(content);
        content.setFont(StyleFont.titleFont);
        content.setForeground(Color.ORANGE);


        JPanel actAndPwsPanel = new JPanel();
        actAndPwsPanel.setLayout(new FlowLayout(FlowLayout.CENTER));
        actAndPwsPanel.setBounds(0, HEIGHT / 3, WIDTH, HEIGHT / 3 - 15);
        actAndPwsPanel.setBackground(new Color(235, 229, 209));
        Box boxH;
        Box boxOne, boxTwo;
        boxH = Box.createHorizontalBox();
        boxOne = Box.createVerticalBox();
        boxTwo = Box.createVerticalBox();


        //______________________________________________________
        ImageIcon img1 = new ImageIcon("code/Course/src/WindowsIcon/zhanghao.png");
        JLabel bgImg1 = new JLabel(img1);

        //jPanel2.add(bgImg1);


        JTextField tfUsername = new JTextField(14);
        // jPanel2.add(jTextField);

        ImageIcon img2 = new ImageIcon("code/Course/src/WindowsIcon/mima54.png");
        JLabel bgImg2 = new JLabel(img2);
        // jPanel2.add(bgImg2);


        JPasswordField pfPasswords = new JPasswordField(14);
        //  jPanel2.add(pfPasswords);




        JPanel jPanel3 = new JPanel();
        jPanel3.setLayout(new FlowLayout(FlowLayout.CENTER));
        jPanel3.setBounds(0, HEIGHT / 3 * 2 - 15, WIDTH, HEIGHT / 3 + 10);
        jPanel3.setBackground(Color.PINK);
        JButton btnLogin = new JButton("Login");
        jPanel3.add(btnLogin);
        btnLogin.setPreferredSize(new Dimension(175, 27));
        btnLogin.setBackground(new Color(255, 255, 255));
        btnLogin.setForeground(new Color(3, 3, 3));
        btnLogin.setFont(StyleFont.loginFont);


        boxOne.add(bgImg1);
        boxOne.add(bgImg2);
        boxTwo.add(tfUsername);
        boxTwo.add(pfPasswords);

        boxH.add(boxOne);
        boxH.add(Box.createHorizontalStrut(10));
        boxH.add(boxTwo);
        actAndPwsPanel.add(boxH);

        //______________________________________________________

        jFrame.add(jPanel3);
        jFrame.add(actAndPwsPanel);
        jFrame.add(loginPanel);
        jFrame.add(bgImg);


        btnLogin.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub


                String accountString = tfUsername.getText();
                String password = Tools.getPassword(pfPasswords);

                if (accountString.equals("")) {
                    Tools.messageWindows("Account Cannot Be Empty");

                } else if (password.equals("")) {
                    Tools.messageWindows("Password Cannot Be Empty");
                } else {
                    String[] data = new String[2];
                    data[0] = accountString;
                    data[1] = password;
                    String sqlString = "select * from users where account=? and password=?";
                    ResultSet rs = Mysql.QueryData(sqlString, data);
                    try {

                        if (rs.next()) {
                            String poString = rs.getString("pow");

                            if (poString.equals("1")) {

                                ManageWindows Windows = new ManageWindows();
                                jFrame.dispose();


                            }

                            if (poString.equals("2")) {
                                TeacherWindows Windows = new TeacherWindows(accountString);
                                jFrame.dispose();
                            }

                            if (poString.equals("3")) {
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
