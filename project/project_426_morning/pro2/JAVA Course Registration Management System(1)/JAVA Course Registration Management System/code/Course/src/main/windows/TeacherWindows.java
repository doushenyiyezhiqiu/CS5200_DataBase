package main.windows;

import main.listen.ItemListenMouse;
import main.style.StyleFont;
import main.teacher.CouseMan;
import main.teacher.GetSoure;
import main.tools.EasyCode;
import main.tools.Tools;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class TeacherWindows {
    final int WIDTH = 1350;
    final int HEIGHT = 750;
    //定义一个界面
    JFrame jFrame = new JFrame();
    JLayeredPane jPanel3;
    Object[] obj;
    String teacher;


    public TeacherWindows(String teacher) {

        this.teacher = teacher;
        init();
        jFrame.setResizable(false);//窗口是否可变
        jFrame.setVisible(true);//窗口是否可见
        jFrame.setDefaultCloseOperation(jFrame.DISPOSE_ON_CLOSE);//设置默认关闭方式
        jFrame.validate();//让组件生效
        jFrame.setTitle("Course Management System-Teacher");

    }

    void init() {

        //设置窗口在屏幕中间  并设置大小
        Tools.setWindowPos(WIDTH, HEIGHT, jFrame);
        EasyCode.setTileIcon(jFrame);//设置标题和图标
        jFrame.setLayout(null);
        jFrame.setBackground(Color.blue);

        JPanel jPanel = new JPanel();
        jPanel.setBackground(new Color(66, 99, 116));
        jPanel.setLayout(null);
        jPanel.setBounds(0, 0, WIDTH, HEIGHT);


        //定义第一个盘子
        JPanel jPanel2 = new JPanel();
        jPanel2.setBackground(new Color(255, 255, 255));
        jPanel2.setLayout(new FlowLayout(FlowLayout.LEFT));
        jPanel2.setBounds(10, 10, 200, HEIGHT - 55 - 20);
        jPanel.add(jPanel2);


        Box boxOne;//用于存储图标
        boxOne = Box.createVerticalBox();
        jPanel2.add(boxOne);
        //______________________________________________



        //___________________________________________________
        //将各个盘子进行分层
        JLayeredPane jPanel3 = new JLayeredPane();//定义一个千层饼
        jPanel3.setBounds(215, 10, WIDTH - 215 - 25, HEIGHT - 50 - 25);

        //添加学院管理
        CouseMan cousman = new CouseMan(0, 0, WIDTH - 215 - 25, HEIGHT - 55, teacher);
        jPanel3.add(cousman, JLayeredPane.PALETTE_LAYER);


        //成绩下发
        //下发成绩
        GetSoure divcouse = new GetSoure(0, 0, WIDTH - 215 - 25, HEIGHT - 55, teacher);
        jPanel3.add(divcouse, JLayeredPane.PALETTE_LAYER);


        Object[] obj = {cousman, divcouse};
        this.obj = obj;


        jPanel.add(jPanel3);

        JLabel jLabel = new JLabel("Course Management");
        jLabel.setForeground(new Color(150, 150, 150));
        boxOne.add(jLabel);


        JLabel jLabel2 = new JLabel("Course Application");
        //jLabel2.setForeground(new Color(51,51,51));
        jLabel2.setFont(StyleFont.Item);
        jLabel2.setIcon(new ImageIcon("code/Course/src/WindowsIcon/TIT1.png"));
        jLabel2.setForeground(new Color(30, 144, 255));
        boxOne.add(jLabel2);

        JLabel jLabel3 = new JLabel("Score Management");
        //jLabel2.setForeground(new Color(51,51,51));
        jLabel3.setFont(StyleFont.Item);
        jLabel3.setIcon(new ImageIcon("code/Course/src/WindowsIcon/TIT2.png"));
        //jLabel3.setForeground(new Color(30,144,255));
        boxOne.add(jLabel3);

        jFrame.add(jPanel);

        //测试输出


        this.jPanel3 = jPanel3;
        addItemListen(boxOne);
        ItemListenMouse.oldJLabel = jLabel2;//将老的标签存入

        JMenuBar menubar = new JMenuBar();//创建一个菜单条
        JMenu menu = new JMenu("Account");
        menu.setIcon(new ImageIcon("code/Course/src/WindowsIcon/ITIT2.png"));
        JMenuItem item2_2 = new JMenuItem("Logout", new ImageIcon("code/Course/src/WindowsIcon/ITIT.png"));
        JMenuItem item2_3 = new JMenuItem("Quit", new ImageIcon("code/Course/src/WindowsIcon/ITIT1.png"));
        menu.add(item2_2);
        menu.add(item2_3);
        menubar.add(menu);
        jFrame.setJMenuBar(menubar);


        item2_2.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                jFrame.dispose();
                LoginWindows loginWindows = new LoginWindows();

            }
        });

        //退出
        item2_3.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                jFrame.dispose();


            }
        });

    }

    void addItemListen(Box boxOne) {

        Component[] JLS = boxOne.getComponents();
        int j = 0;
        for (int i = 0; i < JLS.length; i++) {


            JLabel jLabel = (JLabel) JLS[i];
            Color color = new Color(150, 150, 150);

            if (!(jLabel.getForeground().equals(color))) {
                jLabel.addMouseListener(new ItemListenMouse(jPanel3, obj[j]));

                j++;
            }
        }

    }
    //刷新


}
