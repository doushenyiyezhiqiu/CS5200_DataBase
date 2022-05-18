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
import java.util.Timer;
import java.util.TimerTask;

public class CourseArrangement extends JPanel{


    int WIDTH;
    int HEIGHT;
    public static int onfont=0;
    public  CourseArrangement(int x,int y,int width,int height) {
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
        Box boxTwoBox=Box.createHorizontalBox();//定义的是第一行
        boxH.add(boxOneBox);

        boxH.add( Box.createVerticalStrut(20));
        boxH.add(boxTwoBox);
        this.add(boxH);


        initJL("College",boxOneBox);
        JComboBox cmb=new JComboBox();
        cmb.addItem("--Select College--");
        boxOneBox.add(cmb);
        Tools.upDateComboBox("select * from college", cmb,"Select College","college");




        boxOneBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔
        initJL("Teacher",boxOneBox);
        JComboBox cmb1=new JComboBox();
        cmb1.addItem("--Select Teacher--");
        boxOneBox.add(cmb1);

        boxOneBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔
        initJL("Course Name",boxOneBox);
        JComboBox cmb2=new JComboBox();
        cmb2.addItem("--Select Course--");
        boxOneBox.add(cmb2);

        boxOneBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔
        initJL("Class Time",boxOneBox);
        JComboBox cmb3=new JComboBox();
        cmb3.addItem("--Select Time--");
        boxOneBox.add(cmb3);

        JComboBox cmbttBox=new JComboBox();

        //this.add(cmbttBox);
        cmb.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                JComboBox cmbT = (JComboBox)e.getSource();//调用的局部

                if(cmbT.getSelectedIndex()!=0) {
                    String string=(String)cmbT.getSelectedItem();


                    string=	"select * from teacher where oncollege="+"'"+string+"'";
                    Tools.upDateComboBox(string, cmb1,"Select Teacher","name");

                    String data[]=new String [cmb1.getItemCount()-1];
                    for(int i=0;i<cmb1.getItemCount()-1;i++) {


                        String string2=	Integer.toString(i+1)+"."+cmb1.getItemAt(i+1);

                        data[i]=string2;

                    }
                    Tools.upDateComboBox(data, cmb1, "Select Teacher");


                    Tools.upDateComboBox(string, cmbttBox,"Select Teacher","id");


                }
            }
        });





        cmb1.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                JComboBox cmbT = (JComboBox)e.getSource();//调用的局部

                if(cmbT.getSelectedIndex()!=0) {



                    String college=(String)cmb.getSelectedItem();//学院
                    String string=(String)cmbT.getSelectedItem();//老师的姓名

                    String ID=(String)cmbttBox.getItemAt(cmbT.getSelectedIndex());



                    string=	"select * from course where colleges='"+college+"' and id='"+ID+"'and star ='1'";

                    Tools.upDateComboBox(string, cmb2,"Select Name","cname");
                }
            }
        });



        String data[]= {"morning","noon","afternoon","evening"};
        Tools.upDateComboBox( data, cmb3, "Select Time");




        //________________________________________________________
        Object columns[] ={"Course Registration Number","College","Teacher","Course Name","Class Time","Student Number"};
        Table t1Table=new Table(columns);
        JTable table = t1Table.getTables();
        JScrollPane JS = t1Table.getJScrollPane();
        DefaultTableModel model = t1Table.getModel();
        JS.setPreferredSize(new Dimension(WIDTH-40,475));//设置整个滚动条窗口的大小

        this.add(JS);
        //__________________________________________________________________








        boxOneBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔
        initJL("Course Registration Number", boxTwoBox);
        JTextField jTextField = initJT(8,  boxTwoBox);

        JButton jButton=new JButton("Registration canceled");
        boxTwoBox.add(jButton);

        boxTwoBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔
        JButton jButton1=new JButton("Open Registration");
        boxTwoBox.add(jButton1);


        boxTwoBox.add(Box.createHorizontalStrut(10));//设置组件之间间隔
        JButton jButton3=new JButton("Search Registration Course");
        boxTwoBox.add(jButton3);
        boxTwoBox.add(Box.createHorizontalStrut(280));//设置组件之间间隔
        //Registration canceled
        jButton.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                if(jTextField.getText().equals("")) {
                    Tools.messageWindows("Please EnterCourse Registration Number");
                }else {


                    String data1[]= {jTextField.getText()};

                    int rs1 = Mysql.upDate("delete from optcous where id=?", data1);
                    Tools.setTableSize(table, WIDTH, rs1);
                    if(rs1==0) {
                        Tools.messageWindows("Current Course does not exist");
                    }
                    if(rs1==-1) {
                        Tools.messageWindows("Please enter correct Course Registration Number");
                    }
                    if(rs1==1) {
                        Tools.messageWindows("Course selection cancelled successfully");
                    }


                }



            }
        });




        //Open Registration

        jButton1.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub


                if(cmb.getSelectedIndex()==0) {
                    Tools.messageWindows("Please Select College!");
                }else if(cmb1.getSelectedIndex()==0) {
                    Tools.messageWindows("Please select teacher!");
                }else if(cmb2.getSelectedIndex()==0) {
                    Tools.messageWindows("Please select course!");
                }else if(cmb3.getSelectedIndex()==0) {
                    Tools.messageWindows("Please select time!");
                }else {
                    String A=	(String)cmb.getSelectedItem();//学院
                    String B=	(String)cmbttBox.getItemAt(cmb1.getSelectedIndex());

                    System.out.println( B);
                    String C=	(String)cmb2.getSelectedItem();//课程
                    String D=	(String)cmb3.getSelectedItem();//时间

                    String data1[]= {A,B,C};


                    //查询当前内容是有
                    String strsqlString="select * from optcous where college=? and teacher=(select name from teacher where id=?) and coursname=?";
                    boolean star = Tools.isHasData(Mysql.QueryData(strsqlString, data1));
                    if(star==true) {
                        Tools.messageWindows("The Current Course Has Been Added");
                    }else {
                        String data[]= {A,B,C,D,B};
                        String string="insert into optcous (college,teacher,coursname,clstime,teanum) values(?,(select name from teacher where id=?),?,?,?)";
                        Mysql.upDate(string, data);
                        Tools.messageWindows("Course Selection Added Successfully");
                        jButton3.doClick();

                    }





                }


            }
        });
        //查找数据
        jButton3.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                if(jTextField.getText().equals("")) {
                    ResultSet rs1 = Mysql.QueryData("select * from optcous", null);
                    int num=Tools.addDataTable( rs1 , model, 6);
                    Tools.setTableSize(table, WIDTH, num);
                    if (num==0) {
                        Tools.messageWindows("There Is Currently No Course Data");
                    }

                }else {
                    //查询一个

                    String st=jTextField.getText();
                    String data[]= {st};
                    ResultSet rs1 = Mysql.QueryData("select * from optcous where id=?", data);

                    int num=Tools.addDataTable( rs1 , model, 6);
                    Tools.setTableSize(table, WIDTH, num);
                    if (num==0) {
                        Tools.messageWindows("Please Enter the Course Registration Number In the Correct Format！");
                    }
                    if (num==-1) {
                        Tools.messageWindows("Please Enter the Course Registration Number In the Correct Format");
                    }

                }
            }
        });




















        //____________________________________________________________________
        new Timer().schedule(new TimerTask() {
            int a=0;
            @Override
            public void run() {
                try {
                    //根据不同

                    if(a==0) {
                        if(ManageWindows.jLabel7!=null&& ManageWindows.jLabel7.getForeground().equals(new Color(30,144,255))) {
                            Tools.upDateComboBox("select * from college", cmb,"Please Select College","college");
                            a=1;
                        }
                    }else {
                        if(ManageWindows.jLabel7!=null&& ManageWindows.jLabel7.getForeground().equals(new Color(30,144,255))) {


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
