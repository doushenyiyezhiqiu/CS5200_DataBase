package main.teacher;

import main.style.StyleFont;
import main.tools.DataOther;
import main.tools.Mysql;
import main.tools.Table;
import main.tools.Tools;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;
import java.util.Timer;
import java.util.TimerTask;

public class CourseApplication extends JPanel {
    int WIDTH;
    int HEIGHT;
    String TeaName;

    public CourseApplication(int x, int y, int width, int height, String TeaName) {
        //set axis,height,width
        this.TeaName = TeaName;
        this.WIDTH = width;
        this.HEIGHT = height;
        this.setBounds(x, y, width, height);
        init();
    }

    void init() {

        this.setBackground(new Color(255, 255, 255));
        this.setLayout(new FlowLayout(FlowLayout.LEFT, 20, 15));
        Box boxH = Box.createVerticalBox();
        Box boxOneBox = Box.createHorizontalBox();//define the first line
        boxH.add(boxOneBox);
        this.add(boxH);

        initJL("Course Name", boxOneBox);
        JTextField jTextField = initJT(8, boxOneBox);

        boxOneBox.add(Box.createHorizontalStrut(10));
        JButton jButton = new JButton("Submit Application");
        boxOneBox.add(jButton);

        boxOneBox.add(Box.createHorizontalStrut(10));
        JButton jButton1 = new JButton("Withdraw Application");
        boxOneBox.add(jButton1);

        boxOneBox.add(Box.createHorizontalStrut(10));
        JButton jButton2 = new JButton("Check the Status of Course Application");
        boxOneBox.add(jButton2);


        //____________________________________________________________________
        Object[] columns = {"Serial Number", "Course Name", "Application Status"};
        Table t1Table = new Table(columns);
        JTable table = t1Table.getTables();
        JScrollPane JS = t1Table.getJScrollPane();
        DefaultTableModel model = t1Table.getModel();
        JS.setPreferredSize(new Dimension(WIDTH - 40, 540));
        this.add(JS);

        //__________________________________________________________________________________

        jButton.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String str = jTextField.getText();
                if (str.equals("")) {
                    Tools.messageWindows("Please Enter the Course Name");

                } else {


                    String[] data1 = {TeaName, TeaName, TeaName, str};


                    ResultSet rs = Mysql.QueryData("select * from course where colleges=(select oncollege from teacher where id=?) and  teachname=(select name from teacher where id=?) and cname=? and id=?", data1);
                    boolean sta = Tools.isHasData(rs);

                    if (sta) {
                        Tools.messageWindows("Do Not Duplicate Applications");
                    } else {
                        String[] data11 = {TeaName, TeaName, TeaName, str};
                        int num = Mysql.upDate("insert into course (id,colleges,teachname,cname) values(?,(select oncollege from teacher where id=?),(select name from teacher where id=?),?)", data11);
                        if (num != -1) {
                            Tools.messageWindows("Submit the Application, Waiting for the Administrator to Review");
                            jButton2.doClick();
                        }

                    }
                }
            }
        });

        jButton1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String str = jTextField.getText();
                if (str.equals("")) {
                    Tools.messageWindows("Please Enter the Course Name");

                } else {

                    String[] data1 = {TeaName, str};
                    ResultSet rs = Mysql.QueryData("select * from course where teachname=(select name from teacher where id=?) and cname=?", data1);
                    boolean sta = Tools.isHasData(rs);
                    if (sta) {

                        String sta1 = DataOther.showCoursSta("select * from course where  teachname=(select name from teacher where id=?) and cname=?", data1);

                        if (sta1.equals("0")) {
                            String[] data11 = {"3", TeaName, str};
                            DataOther.setCoursSta("update course set star=? where  teachname=(select name from teacher where id=?) and cname=?", data11);

                            String[] data = {TeaName, str};
                            String strsqlString = "select cname, if(star=0,\"Application in Processing\",if(star=1,\"Application Approved\",if(star=2,\"Application Rejected\",\"Application Withdrawal\"))) from course where teachname=(select name from teacher where id=?) and cname=?";
                            ResultSet rs1 = Mysql.QueryData(strsqlString, data);
                            int num = Tools.addDataTableNum(rs1, model, 2);
                            Tools.setTableSize(table, WIDTH, num);

                        } else if (sta1.equals("")) {

                            Tools.messageWindows("Application List Does Not Have This Course");

                        } else {

                            Tools.messageWindows("Current Course Status Cannot Be Withdrawn");
                        }

                    } else {

                        Tools.messageWindows("Please Enter the Correct Course Name");


                    }
                }
            }
        });

        //search
        jButton2.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String str = jTextField.getText();
                if (str.equals("")) {

                    String[] data = {TeaName};
                    String strsqlString = "select cname, if(star=0,\"Application in Processing\",if(star=1,\"Application Approved\",if(star=2,\"Application Rejected\",\"Application Withdrawal\"))) from course where teachname=(select name from teacher where id=?)";
                    ResultSet rs = Mysql.QueryData(strsqlString, data);
                    int num = Tools.addDataTableNum(rs, model, 2);
                    Tools.setTableSize(table, WIDTH, num);

                } else {
                    String[] data = {TeaName, str};
                    String strsqlString = "select cname, if(star=0,\"Application in Processing\",if(star=1,\"Application Approved\",if(star=2,\"Application Rejected\",\"Application Withdrawal\"))) from course where teachname=(select name from teacher where id=?) and cname=?";
                    ResultSet rs = Mysql.QueryData(strsqlString, data);
                    int num = Tools.addDataTableNum(rs, model, 2);
                    Tools.setTableSize(table, WIDTH, num);

                }
            }

        });

        //____________________________________________________________________
        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                try {

                    if (table.getRowCount() > 1) {
                        String[] data = {TeaName};
                        String strsqlString = "select cname, if(star=0,\"Application in Processing\",if(star=1,\"Application Approved\",if(star=2,\"Application Rejected\",\"Application Withdrawal\"))) from course where teachname=(select name from teacher where id=?)";
                        ResultSet rs = Mysql.QueryData(strsqlString, data);
                        int num = Tools.addDataTableNum(rs, model, 2);
                        Tools.setTableSize(table, WIDTH, num);
                    }


                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }, 0, 10000);

        //___________________________________________________________________________

    }


    void initJL(String text, Box boxH) {
        JLabel jLabel = new JLabel(text);
        jLabel.setFont(StyleFont.Item);
        boxH.add(jLabel);
        boxH.add(Box.createHorizontalStrut(10));

    }


    JTextField initJT(int num, Box boxH) {
        JTextField jTextField = new JTextField(num);
        boxH.add(jTextField);
        boxH.add(Box.createHorizontalStrut(10));
        return jTextField;
    }


}
