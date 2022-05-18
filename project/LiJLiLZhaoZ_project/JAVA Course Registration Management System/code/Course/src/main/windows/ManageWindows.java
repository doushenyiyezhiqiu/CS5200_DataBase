package main.windows;

import main.ManageWindows.*;
import main.listen.ItemListenMouse;
import main.style.StyleFont;
import main.tools.EasyCode;
import main.tools.Tools;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ManageWindows {
    //menu detail label
    public static JLabel jLabel1;
    public static JLabel jLabel2;
    public static JLabel jLabel3;
    public static JLabel jLabel4;
    public static JLabel jLabel6;
    public static JLabel jLabel7;
    final int WIDTH = 1420;
    final int HEIGHT = 750;

    JFrame jFrame = new JFrame();
    JLayeredPane jPanel3;
    Object[] obj;

    public ManageWindows() {

        init();
        jFrame.setResizable(false);
        jFrame.setVisible(true);
        jFrame.setDefaultCloseOperation(jFrame.DISPOSE_ON_CLOSE);
        jFrame.validate();
        jFrame.setTitle("Course Management System-Administrator");
    }

    void init() {

        Tools.setWindowPos(WIDTH, HEIGHT, jFrame);
        EasyCode.setTileIcon(jFrame);
        jFrame.setLayout(null);
        jFrame.setBackground(Color.blue);


        JPanel jPanel = new JPanel();
        jPanel.setBackground(new Color(66, 99, 116));
        jPanel.setLayout(null);
        jPanel.setBounds(0, 0, WIDTH, HEIGHT);



        JPanel menuPnl = new JPanel();
        menuPnl.setBackground(new Color(255, 255, 255));
        menuPnl.setLayout(new FlowLayout(FlowLayout.LEFT));
        menuPnl.setBounds(10, 10, 200, HEIGHT - 75);
        jPanel.add(menuPnl);


        Box boxOne;
        boxOne = Box.createVerticalBox();
        menuPnl.add(boxOne);


        JMenuBar bar = new JMenuBar();
        JMenu actMenu = new JMenu("Account");
        actMenu.setIcon(new ImageIcon("code/Course/src/WindowsIcon/ITIT2.png"));
        JMenuItem actItem1 = new JMenuItem("Logout", new ImageIcon("code/Course/src/WindowsIcon/ITIT.png"));
        JMenuItem actItem2 = new JMenuItem("Quit", new ImageIcon("code/Course/src/WindowsIcon/ITIT1.png"));
        actMenu.add(actItem1);
        actMenu.add(actItem2);
        bar.add(actMenu);
        jFrame.setJMenuBar(bar);


        actItem1.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                jFrame.dispose();
                LoginWindows loginWindows = new LoginWindows();

            }
        });


        actItem2.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                jFrame.dispose();


            }
        });


        //___________________________________________________

        JLayeredPane jPanel3 = new JLayeredPane();
        jPanel3.setBounds(215, 10, WIDTH - 215 - 25, HEIGHT - 50 - 25);


        CollegeMajor collegeman = new CollegeMajor(0, 0, WIDTH - 215 - 25, HEIGHT - 55);
        jPanel3.add(collegeman, JLayeredPane.PALETTE_LAYER);


        TeacherManagement teacher = new TeacherManagement(0, 0, WIDTH - 215 - 25, HEIGHT - 55);
        jPanel3.add(teacher, JLayeredPane.PALETTE_LAYER);



        StudentManagement student = new StudentManagement(0, 0, WIDTH - 215 - 25, HEIGHT - 55);
        jPanel3.add(student, JLayeredPane.PALETTE_LAYER);



        CourseApplication course = new CourseApplication(0, 0, WIDTH - 215 - 25, HEIGHT - 55);
        jPanel3.add(course, JLayeredPane.PALETTE_LAYER);



        CourseArrangement drivate = new CourseArrangement(0, 0, WIDTH - 215 - 25, HEIGHT - 55);
        jPanel3.add(drivate, JLayeredPane.PALETTE_LAYER);


        CourseSearch courseS = new CourseSearch(0, 0, WIDTH - 215 - 25, HEIGHT - 55);
        jPanel3.add(courseS, JLayeredPane.PALETTE_LAYER);


        Object[] obj = {collegeman, teacher, student, course, drivate, courseS};
        this.obj = obj;


        jPanel.add(jPanel3);

        jLabel1 = new JLabel("College Management");
        jLabel1.setForeground(new Color(150, 150, 150));
        boxOne.add(jLabel1);


        jLabel2 = new JLabel("College and Major");
        jLabel2.setFont(StyleFont.Item);
        jLabel2.setIcon(new ImageIcon("code/Course/src/WindowsIcon/IT1.png"));
        jLabel2.setForeground(new Color(30, 144, 255));
        boxOne.add(jLabel2);
        jLabel2 = jLabel2;

        JLabel jLabel1 = new JLabel("Account Management");
        jLabel1.setForeground(new Color(150, 150, 150));
        boxOne.add(jLabel1);

        JLabel jLabel3 = new JLabel("Teacher Account");
        jLabel3.setForeground(new Color(51, 51, 51));
        jLabel3.setFont(StyleFont.Item);
        jLabel3.setIcon(new ImageIcon("code/Course/src/WindowsIcon/IT2.png"));
        boxOne.add(jLabel3);
        ManageWindows.jLabel3 = jLabel3;

        JLabel jLabel4 = new JLabel("Student Account");
        jLabel4.setForeground(new Color(51, 51, 51));
        jLabel4.setFont(StyleFont.Item);
        jLabel4.setIcon(new ImageIcon("code/Course/src/WindowsIcon/IT3.png"));
        boxOne.add(jLabel4);
        ManageWindows.jLabel4 = jLabel4;


        JLabel jLabel5 = new JLabel("Course Management");
        jLabel5.setForeground(new Color(150, 150, 150));
        boxOne.add(jLabel5);

        JLabel jLabel6 = new JLabel("Course Application");
        jLabel6.setForeground(new Color(51, 51, 51));
        jLabel6.setFont(StyleFont.Item);
        jLabel6.setIcon(new ImageIcon("code/Course/src/WindowsIcon/TIT1.png"));
        boxOne.add(jLabel6);
        ManageWindows.jLabel6 = jLabel6;


        JLabel jLabel7 = new JLabel("Course Arrangement");
        jLabel7.setForeground(new Color(51, 51, 51));
        jLabel7.setFont(StyleFont.Item);
        jLabel7.setIcon(new ImageIcon("code/Course/src/WindowsIcon/IT4.png"));
        boxOne.add(jLabel7);
        ManageWindows.jLabel7 = jLabel7;


        JLabel jLabel8 = new JLabel("Course Search");
        jLabel8.setForeground(new Color(51, 51, 51));
        jLabel8.setFont(StyleFont.Item);
        jLabel8.setIcon(new ImageIcon("code/Course/src/WindowsIcon/TIT3.png"));
        boxOne.add(jLabel8);


        jFrame.add(jPanel);



        this.jPanel3 = jPanel3;
        addItemListen(boxOne);
        ItemListenMouse.oldJLabel = jLabel2;


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
    //
}
