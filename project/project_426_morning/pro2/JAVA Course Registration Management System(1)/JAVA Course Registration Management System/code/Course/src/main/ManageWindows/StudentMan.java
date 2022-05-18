package main.ManageWindows;

import main.style.StyleFont;
import main.tools.Mysql;
import main.tools.Table;
import main.tools.Tools;
import main.windows.ManageWindows;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Timer;
import java.util.TimerTask;

public class StudentMan extends JPanel{

    int WIDTH;
    int HEIGHT;

    public StudentMan(int x,int y,int width,int height) {
        //设置坐标和  宽高

        this.WIDTH=width;
        this.HEIGHT=height;
        this.setBounds(x, y, width, height);
        init();
    }

    void init() {
        this.setBackground(new Color(255,255,255));
        this.setLayout(new FlowLayout(FlowLayout.LEFT,20,15));

        Box boxH=Box.createVerticalBox();
        Box boxOneBox=Box.createHorizontalBox();//定义的是第一行
        boxH.add(boxOneBox);
        this.add(boxH);

        initJL("Student Name",boxOneBox);
        JTextField jTextField=initJT(8, boxOneBox);



        initJL("Student Sex",boxOneBox);

        ButtonGroup g = new ButtonGroup();//建立一个组
        JRadioButton box1 = new JRadioButton("Male",true);
        JRadioButton box2 = new JRadioButton("Female",false);
        box1.setFont(StyleFont.Item);
        box2.setFont(StyleFont.Item);
        box1.setOpaque(false);
        box2.setOpaque(false);
        boxOneBox.add(box1);
        boxOneBox.add(box2);
        g.add(box1);
        g.add(box2);

        boxOneBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔
        initJL("College Name",boxOneBox);
        JComboBox cmb=new JComboBox();
        boxOneBox.add(cmb);
        Tools.upDateComboBox("select * from college", cmb,"Please Select College","college");
        boxOneBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔


        initJL("Major Name",boxOneBox);
        JComboBox cmb1=new JComboBox();
        boxOneBox.add(cmb1);
        cmb1.addItem("--Please Select Major--");


        //5按钮  编号
        Box boxTwoBox=Box.createHorizontalBox();
        boxH.add(Box.createVerticalStrut(20));
        boxH.add(boxTwoBox);


        initJL("Student ID",boxTwoBox);
        JTextField jTextField2=initJT(8, boxTwoBox);
        boxTwoBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔

        JButton jButton=new JButton("Search Student");
        boxTwoBox.add(jButton);
        boxTwoBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔

        JButton jButton1=new JButton("Add Student");
        boxTwoBox.add(jButton1);
        boxTwoBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔

        JButton jButton2=new JButton("Delete Student");
        boxTwoBox.add(jButton2);
        boxTwoBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔

        JButton jButton3=new JButton("Change Student");
        boxTwoBox.add(jButton3);
        boxTwoBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔




        //____________________________________________________________________
        Object columns[] ={"Serial Number","Student ID","Student Name","College","Major","Sex","InYear"};
        Table t1Table=new Table(columns);
        JTable table = t1Table.getTables();
        JScrollPane JS = t1Table.getJScrollPane();
        DefaultTableModel model = t1Table.getModel();
        JS.setPreferredSize(new Dimension(WIDTH-40,475));//设置整个滚动条窗口的大小
        this.add(JS);

        //_______________________________________________________________________
        //根据选择更新下拉框
        cmb.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                JComboBox Temp =(JComboBox) e.getSource();

                if(Temp.getSelectedIndex()!=0) {
                    String t = (String)Temp.getSelectedItem();
                    Tools.upDateComboBox("select * from major where college='"+t+"'", cmb1,"Please Select Major","proname");
                }
            }
        });

        //添加学生
        jButton1.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String name=jTextField.getText();
                String sexString;
                if(box1.isSelected()) {
                    sexString="Male";
                }else {
                    sexString="Female";
                }
                if(name.equals("")) {
                    Tools.messageWindows("Please Enter Student Name");
                }else if(cmb.getSelectedIndex()==0){
                    Tools.messageWindows("Please Select College");
                }else if(cmb1.getSelectedIndex()==0){
                    Tools.messageWindows("Please Select Major");
                }else {

                    String collegeString=(String)cmb.getSelectedItem();
                    String edu=(String)cmb1.getSelectedItem();
                    String string="insert into student (id,name,oncollege,peojob,sex,inyear) values  (?,?,?,?,?,CONCAT(year(now()),'年'))";

                    String  num = null;//工号是主健
                    int i=1;
                    while(true) {
                        Calendar cal = Calendar.getInstance();
                        int year = cal.get(Calendar.YEAR);
                        String s = String.valueOf(year);
                        //21   学院编号

                        String data1[]= {collegeString};
                        ResultSet rs1 = Mysql.QueryData("select * from  college where college=?", data1);
                        String coid="0";
                        try {
                            rs1.next();
                            coid=rs1.getString("id");//是学员编号



                        } catch (SQLException e1) {
                            // TODO Auto-generated catch block
                            e1.printStackTrace();
                        }
                        String ss = String.valueOf(i);//是序号
                        //20215 1
                        //  0
                        num=s+coid+ss;

                        String data2[]= {s+coid+"%"};
                        String strsqlString=" select * from student where id like ? ORDER BY id asc";
                        ResultSet rs2 = Mysql.QueryData(strsqlString, data2);
                        try {
                            while(rs2.next()) {

                                i++;

                            }
                            num= String.valueOf(i);//是序号  //把当前学号这个学院的教师 全部取出来
                            num=s+coid+num;

                            rs2.close();

                            num=String.valueOf(Integer.parseInt(num)+1);

                        } catch (SQLException e1) {
                            // TODO Auto-generated catch block
                            e1.printStackTrace();
                        }


                        String data[]= {num,name,collegeString,edu,sexString};
                        int rs = Mysql.upDate(string, data);

                        String data4[]= {num,num,"3"};
                        Mysql.upDate("insert into users (account,password,pow) values(?,?,?)", data4);

                        if(rs!=-1) {
                            String data11[]= {num};
                            ResultSet rs_1=Mysql.QueryData("select * from student where id=?",data11);
                            int num_s=Tools.addDataTableNum(rs_1, model, 6);
                            Tools.setTableSize(	table, WIDTH,num_s );

                            //Tools.messageWindows("添加成功");
                            break;
                        }


                    }




                }


            }
        });

        //查询功能
        jButton.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String numString=	jTextField2.getText();

                if(numString.equals("")) {

                    ResultSet rs = Mysql.QueryData("select * from student", null);



                    int num=Tools.addDataTableNum(rs, model, 6);
                    Tools.setTableSize(table, WIDTH, num);
                    if(num==0) {
                        Tools.messageWindows("Data Result Is Empty");
                    }



                }else {
                    String data[]= {jTextField2.getText()};
                    ResultSet rs = Mysql.QueryData("select * from student where id=?", data);

                    int num=Tools.addDataTableNum(rs, model, 6);
                    Tools.setTableSize(table, WIDTH, num);
                    if(num==0) {
                        Tools.messageWindows("Data Result Is Empty");
                    }



                    rs = Mysql.QueryData("select * from student where id=?", data);

                    try {
                        while(rs.next()) {

                            jTextField.setText(rs.getString("name"));
                            if(rs.getString("sex").equals("Male")) {
                                box1.setSelected(true);

                            }else {
                                box2.setSelected(true);
                            }


                            for(int i=0;i<cmb.getItemCount();i++) {
                                if(rs.getString("oncollege").equals(cmb.getItemAt(i))) {
                                    cmb.setSelectedIndex(i);
                                }
                            }

                            for(int i=0;i<cmb1.getItemCount();i++) {
                                if(rs.getString("peojob").equals(cmb1.getItemAt(i))) {
                                    cmb1.setSelectedIndex(i);
                                }
                            }
                        }
                    } catch (SQLException e1) {
                        // TODO Auto-generated catch block
                        e1.printStackTrace();
                    }


                }
            }
        });

        //删除功能
        jButton2.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String numString=	jTextField2.getText();
                if(numString.equals("")) {
                    Tools.messageWindows("Please Enter Student Id");
                }else {

                    String data[]= {numString};

                    int sta=Mysql.upDate("DELETE from student where id =?", data);
                    if(sta==0) {
                        Tools.messageWindows("Detele Student Fails,Please Check Student Id");
                    }
                    if(sta==-1) {
                        Tools.messageWindows("Please Check the Input Format");
                    }
                    if(sta>=1) {

                        ResultSet rs = Mysql.QueryData("select * from student", null);
                        int num=Tools.addDataTableNum(rs, model, 6);
                        Tools.setTableSize(table, WIDTH, num);

                        //将表当中的删除
                        String data1[]= {numString};
                        Mysql.upDate("delete from users where account=?", data1);

                        Tools.messageWindows("Delete Student Succeeds");
                    }
                }
            }
        });

        //更改的功能
        jButton3.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String name=jTextField.getText();
                String sexString;
                if(box1.isSelected()) {
                    sexString="Male";
                }else {
                    sexString="Female";
                }
                if(name.equals("")) {
                    Tools.messageWindows("Please Enter Student Name");
                }else if(cmb.getSelectedIndex()==0){
                    Tools.messageWindows("Please Select College");
                }else if(cmb1.getSelectedIndex()==0){
                    Tools.messageWindows("Please Select Major");
                }else {

                    String collegeString=(String)cmb.getSelectedItem();
                    String edu=(String)cmb1.getSelectedItem();
                    String data[]= {name,collegeString,edu,sexString,jTextField2.getText()};
                    String string="update student set  name=?,oncollege=?, peojob=? ,sex=? where id=?";
                    int num=Mysql.upDate(string, data);
                    if(num==0) {
                        Tools.messageWindows("Please Check If the Student ID Is Correct");

                    }
                    if(num==-1) {
                        Tools.messageWindows("Please Check If the Student ID Format Is Correct！");

                    }
                    if(num==1) {
                        Tools.messageWindows("Student Information Changed Successfully");

                    }
                }
            }});

        //____________________________________________________________________
        new Timer().schedule(new TimerTask() {
            int a=0;
            @Override
            public void run() {
                try {
                    //根据不同

                    if(a==0) {
                        if(ManageWindows.jLabel4!=null&& ManageWindows.jLabel4.getForeground().equals(new Color(30,144,255))) {
                            Tools.upDateComboBox("select * from college", cmb,"Please Select College","college");
                            a=1;


                        }
                    }else {
                        if(ManageWindows.jLabel4!=null&& ManageWindows.jLabel4.getForeground().equals(new Color(30,144,255))) {


                        }else {
                            a=0;
                        }
                    }



                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }, 0, 1000);

        //___________________________________________________________________________

    }
    //初始化标签
    void initJL(String text,Box boxH) {
        JLabel jLabel=new JLabel(text);
        jLabel.setFont(StyleFont.Item);
        boxH.add(jLabel);
        boxH.add(Box.createHorizontalStrut(10));//设置组件之间间隔

    }
    //初始化文本框
    JTextField initJT(int num,Box boxH) {
        JTextField jTextField =new JTextField(num);
        boxH.add(jTextField);
        boxH.add(Box.createHorizontalStrut(10));//设置组件之间间隔
        return jTextField ;
    }





}
