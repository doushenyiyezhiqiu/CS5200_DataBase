package main.windows;

import main.listen.ItemListenMouse;
import main.student.RegisterCourse;
import main.style.StyleFont;
import main.tools.EasyCode;
import main.tools.Tools;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class StudentWindows {
    final int WIDTH = 1350;
    final int HEIGHT = 750;

    JFrame jFrame = new JFrame();
    JLayeredPane jPanel3;
    Object[] obj;
    String student;


    public StudentWindows(String student) {

        this.student = student;
        init();
        jFrame.setResizable(false);
        jFrame.setVisible(true);
        jFrame.setDefaultCloseOperation(jFrame.DISPOSE_ON_CLOSE);
        jFrame.validate();
        jFrame.setTitle("Course Management System-Student");
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



        JPanel jPanel2 = new JPanel();
        jPanel2.setBackground(new Color(255, 255, 255));
        jPanel2.setLayout(new FlowLayout(FlowLayout.LEFT));
        jPanel2.setBounds(10, 10, 200, HEIGHT - 55 - 20);
        jPanel.add(jPanel2);


        Box boxOne;
        boxOne = Box.createVerticalBox();
        jPanel2.add(boxOne);
        //______________________________________________
        //JLayeredPane jpanel2 = new JLayeredPane();
        //InStockPan inpan=new InStockPan(0, 0, 665+50, HEIGHT-10);
        //jpanel2.add(inpan, (Integer) (JLayeredPane.PALETTE_LAYER));
        //jpanel2.moveToFront(inpan);


        //___________________________________________________

        JLayeredPane jPanel3 = new JLayeredPane();
        jPanel3.setBounds(215, 10, WIDTH - 215 - 25, HEIGHT - 50 - 25);


        RegisterCourse optcouse = new RegisterCourse(0, 0, WIDTH - 215 - 25, HEIGHT - 55, student);
        jPanel3.add(optcouse.getJP(), JLayeredPane.PALETTE_LAYER);


        JMenuBar menubar = new JMenuBar();
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


        item2_3.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                jFrame.dispose();


            }
        });


        Object[] obj = {optcouse.getJP()};
        this.obj = obj;


        jPanel.add(jPanel3);

        JLabel jLabel = new JLabel("Course Management");
        jLabel.setForeground(new Color(150, 150, 150));
        boxOne.add(jLabel);


        JLabel jLabel2 = new JLabel("Register Course");
        //jLabel2.setForeground(new Color(51,51,51));
        jLabel2.setFont(StyleFont.Item);
        jLabel2.setIcon(new ImageIcon("code/Course/src/WindowsIcon/TIT1.png"));
        jLabel2.setForeground(new Color(30, 144, 255));
        boxOne.add(jLabel2);


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



}
