package main.ManageWindows;

import main.style.StyleFont;
import main.tools.Mysql;
import main.tools.Table;
import main.tools.Tools;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;





public class CollegeMajor extends JPanel {

    int WIDTH;
    int HEIGHT;



    public CollegeMajor(int x, int y, int width, int height) {
        //set axis height and width

        this.WIDTH=width;
        this.HEIGHT=height;
        this.setBounds(x, y, width, height);
        init();



    }

    void init() {
        this.setBackground(new Color(255,255,255));
        this.setLayout(new FlowLayout(FlowLayout.LEFT,20,15));
        Box boxH=Box.createVerticalBox();
        Box boxOneBox=Box.createHorizontalBox();//define the first line
        boxH.add(boxOneBox);


        //single box

        ButtonGroup g = new ButtonGroup();
        JRadioButton box1 = new JRadioButton("College ID",true);
        JRadioButton box2 = new JRadioButton("College Name",false);

        box1.setOpaque(false);
        box2.setOpaque(false);
        boxOneBox.add(box1);
        boxOneBox.add(box2);
        g.add(box1);
        g.add(box2);






        boxOneBox.add(Box.createHorizontalStrut(10));
        JTextField jTextField=new JTextField(6);
        boxOneBox.add(jTextField);
        //jTextField.setFont(StyleFont.Item);

        JButton jButton=new JButton("Search College");
        boxOneBox.add(Box.createHorizontalStrut(10));
        boxOneBox.add(jButton);


        JButton jButton2=new JButton("Delete College");
        boxOneBox.add(Box.createHorizontalStrut(10));
        boxOneBox.add(jButton2);


        JButton jButton3=new JButton("Change College");
        boxOneBox.add(Box.createHorizontalStrut(10));
        boxOneBox.add(jButton3);
        //Add a college
        boxH.add(Box.createVerticalStrut(20));



        boxOneBox.add(Box.createHorizontalStrut(10));

        JLabel jLabel1=new JLabel("College Name");
        jLabel1.setFont(StyleFont.Item);
        boxOneBox.add(jLabel1);
        boxOneBox.add(Box.createHorizontalStrut(10));
        JTextField jTextField1=new JTextField(6);
        boxOneBox.add(jTextField1);
        //jTextField1.setFont(StyleFont.Item);



        JButton jButton1=new JButton("Add College");
        boxOneBox.add(Box.createHorizontalStrut(6));
        boxOneBox.add(jButton1);



        //write table




        this.add(boxH);

        //________________________________________________________
        Object columns[] ={"Serial Number","College ID","College Name"};
        Table t1Table=new Table(columns);
        JTable table = t1Table.getTables();
        JScrollPane JS = t1Table.getJScrollPane();
        DefaultTableModel model = t1Table.getModel();
        JS.setPreferredSize(new Dimension(WIDTH-40,180));



        this.add(JS);
        //__________________________________________________________________

        JLabel jLabel2 =new JLabel ("____________________________________________________________________________________________________________________");
        this.add(jLabel2);


        Box boxH1=Box.createVerticalBox();
        Box boxOneBox1=Box.createHorizontalBox();

        boxH1.add(boxOneBox1);
        this.add(boxH1);

        JLabel jLabel3 =new JLabel("Search Major by College");
        jLabel3.setFont(StyleFont.Item);
        boxOneBox1.add(jLabel3);
        boxOneBox1.add(Box.createHorizontalStrut(10));

        JTextField jTextField2=new JTextField(6);
        //jTextField2.setFont(StyleFont.Item);
        boxOneBox1.add(jTextField2);

        JButton jButton4=new JButton("Search College Major");
        boxOneBox1.add(Box.createHorizontalStrut(10));
        boxOneBox1.add(jButton4);

        boxOneBox1.add(Box.createHorizontalStrut(10));
        JLabel jLabel4 =new JLabel("Search Major by Major Name");
        jLabel4.setFont(StyleFont.Item);
        boxOneBox1.add(jLabel4);
        boxOneBox1.add(Box.createHorizontalStrut(10));

        JTextField jTextField3=new JTextField(6);
        //jTextField3.setFont(StyleFont.Item);
        boxOneBox1.add(jTextField3);

        JButton jButton5=new JButton("Search Major");
        boxOneBox1.add(Box.createHorizontalStrut(10));
        boxOneBox1.add(jButton5);


        boxOneBox1.add(Box.createHorizontalStrut(10));


        JButton jButton7=new JButton("Change Major");
        boxOneBox1.add(Box.createHorizontalStrut(10));
        boxOneBox1.add(jButton7);

        //jTextField6.setFont(StyleFont.Item);




        //add  delete   update
        Box boxTwoBox=Box.createHorizontalBox();
        boxH1.add(Box.createVerticalStrut(20));
        boxH1.add(boxTwoBox);

        JLabel jLabel5=new JLabel("College Name");
        jLabel5.setFont(StyleFont.Item);
        boxTwoBox.add(jLabel5);

        boxTwoBox.add(Box.createHorizontalStrut(10));
        JComboBox jComboBox =new JComboBox();
        jComboBox.addItem("--Please Select College--");
        boxTwoBox.add(jComboBox);

        boxTwoBox.add(Box.createHorizontalStrut(10));
        JLabel jLabel6 =new JLabel("[Change-Add-Del]Major Name");
        jLabel6.setFont(StyleFont.Item);
        boxTwoBox.add(jLabel6);
        boxTwoBox.add(Box.createHorizontalStrut(10));

        JTextField jTextField4=new JTextField(8);
        //jTextField4.setFont(StyleFont.Item);
        boxTwoBox.add(jTextField4);


        JButton jButton6=new JButton("Add Major");
        boxTwoBox.add(Box.createHorizontalStrut(10));
        boxTwoBox.add(jButton6);



        JButton jButton8=new JButton("Delete Major");
        boxTwoBox.add(Box.createHorizontalStrut(10));
        boxTwoBox.add(jButton8);



        //________________________________________________________
        Object A[] ={"Serial Number","Major ID","College Name","Major Name"};
        Table B=new Table(A);
        JTable C = B.getTables();
        JScrollPane D = B.getJScrollPane();
        D.setPreferredSize(new Dimension(WIDTH-40,200));
        DefaultTableModel model1 = B.getModel();
        this.add(D);
        //__________________________________________________________________

        //load program
        Tools.upDateComboBox("select * from college", jComboBox,"Please Select College","college");

        //___________________________________________________________________

        jButton1.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String str=jTextField1.getText();
                if(str.equals("")) {
                    Tools.messageWindows("Please Enter College Name");
                }else {
                    String data[]=new String [1];
                    data[0]=str;
                    String sqlString="insert into college (college) values (?)";
                    int num=Mysql.upDate(sqlString, data);
                    if(num==-1) {
                        Tools.messageWindows("Add College Fails，Please Check Name!");
                    }else {

                        //jComboBox


                        Tools.upDateComboBox("select * from college", jComboBox,"Please Select College","college");


                        String strsqlString = "SELECT * from college where college=?";
                        String data1[]=new String[1];
                        data1[0]=str;
                        ResultSet rs = Mysql.QueryData(strsqlString,data1);

                        int count=Tools.addDataTableNum(rs,model, 2);
                        Tools.setTableSize(table, WIDTH, count);



                        Tools.messageWindows("Add College Succeeds");
                    }

                }


            }
        });



        jButton.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String id=jTextField.getText();//college ID

                String strsqlString;
                if(id.equals("")) {

                    strsqlString="select * from college";
                    ResultSet rs = Mysql.QueryData(strsqlString, null);

                    int count=Tools.addDataTableNum(rs,model, 2);
                    Tools.setTableSize(table, WIDTH, count);

                }else {
                    if(box1.isSelected()) {
                        strsqlString="SELECT * from college where ID=?";
                        String data[]=new String[1];
                        data[0]=id;
                        ResultSet rs = Mysql.QueryData(strsqlString,data);

                        int count=Tools.addDataTableNum(rs,model, 2);
                        Tools.setTableSize(table, WIDTH, count);

                    }else {
                        strsqlString="SELECT * from college where college=?";
                        String data[]=new String[1];
                        data[0]=id;
                        ResultSet rs = Mysql.QueryData(strsqlString,data);

                        int count=Tools.addDataTableNum(rs,model, 2);
                        Tools.setTableSize(table, WIDTH, count);

                    }
                }


            }
        });

        //Delete button
        jButton2.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String id=jTextField.getText();//college ID
                if(!id.equals("")) {

                    if(box1.isSelected()) {
                        String strsqlString = "DELETE FROM college where id=?";
                        String data[]=new String[1];
                        data[0]=id;
                        int num=Mysql.upDate(strsqlString, data);
                        if(num==-1) {
                            Tools.messageWindows("Please Enter Correct College ID");
                        }else if(num==0){
                            Tools.messageWindows("College You Enter Does Not Exist");

                        }else{


                            String id1=jTextField.getText();//college ID
                            jTextField.setText("");
                            jButton.doClick();
                            jTextField.setText(id1);

                            Tools.upDateComboBox("select * from college", jComboBox,"Please Select College","college");
                            Tools.messageWindows("Delete succeeds");


                        }

                    }else {

                        String strsqlString = "DELETE FROM college where college=?";
                        String data[]=new String[1];
                        data[0]=id;
                        int num=Mysql.upDate(strsqlString, data);
                        if(num==-1) {
                            Tools.messageWindows("Please Enter Correct College Name");
                        }else if(num==0){
                            Tools.messageWindows("College You Enter Does Not Exist");

                        }else {


                            String id1=jTextField.getText();//college ID
                            jTextField.setText("");
                            jButton.doClick();
                            jTextField.setText(id1);

                            Tools.upDateComboBox("select * from college", jComboBox,"请选择学院","college");
                            Tools.messageWindows("Delete Succeeds");

                        }

                    }
                }else {

                    Tools.messageWindows("Delete Content Cannot Be Empty，Please See If the Radio Button On the Left Corresponds To the Input");

                }
            }
        });


        jButton3.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub

                String id=jTextField.getText();//college ID
                if(box1.isSelected()) {
                    if(id.equals("")) {
                        Tools.messageWindows("Changes Cannot Be Empty，Please See If the Radio Button On the Left Corresponds To the Input");
                    }else {

                        String string="update college set college=?  where id=?";

                        String data[]= {jTextField1.getText(),id};

                        int sta=Mysql.upDate(string, data);
                        if(sta==-1) {
                            Tools.messageWindows("Please Enter College ID In Correct Format");
                        }
                        if(sta==0) {
                            Tools.messageWindows("Please Enter Correct College ID");
                        }
                        if(sta==1) {
                            String strsqlString="SELECT * from college where ID=?";
                            String data1[]=new String[1];
                            data1[0]=id;
                            ResultSet rs = Mysql.QueryData(strsqlString,data1);

                            int count=Tools.addDataTableNum(rs,model, 2);
                            Tools.setTableSize(table, WIDTH, count);


                            Tools.upDateComboBox("select * from college", jComboBox,"Please Select College","college");
                            Tools.messageWindows("Change succeeds");
                        }

                    }

                }else {
                    if(id.equals("")) {
                        Tools.messageWindows("Changes Cannot Be Empty，Please See If the Radio Button On the Left Corresponds To the Input");
                    }else {

                        String string="update college set college=?  where college=?";
                        String data[]= {jTextField1.getText(),id};

                        int sta=Mysql.upDate(string, data);
                        if(sta==-1) {
                            Tools.messageWindows("Please Check the Input Format");
                        }
                        if(sta==0) {
                            Tools.messageWindows("Please enter Correct College Name");
                        }
                        if(sta==1) {
                            String strsqlString="SELECT * from college where college=?";
                            String data1[]=new String[1];
                            data1[0]=jTextField1.getText();

                            ResultSet rs = Mysql.QueryData(strsqlString,data1);

                            int count=Tools.addDataTableNum(rs,model, 2);
                            Tools.setTableSize(table, WIDTH, count);;


                            Tools.upDateComboBox("select * from college", jComboBox,"Please Select College","college");
                            Tools.messageWindows("Change Succeeds");
                        }
                    }
                }






            }
        });
//add major

        jButton6.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                if(jComboBox.getSelectedIndex()==0) {
                    Tools.messageWindows("Please Select College");
                }else {
                    String collegeString=(String) jComboBox.getSelectedItem();
                    String majoString= jTextField4.getText();

                    if(majoString.equals("")) {
                        Tools.messageWindows("Major Name Cannot Be Empty");
                    }else {
                        String sqlString="insert into major (college,proname )values (?,?)";
                        String data[]= {collegeString,majoString};
                        int sta=Mysql.upDate(sqlString, data);
                        if(sta==-1) {
                            Tools.messageWindows("Please Check For Professional Name Conflicts");
                        }
                        if(sta==1) {
                            String sqlString1="select * from major where proname=?";
                            String data1[]= {jTextField4.getText()};
                            ResultSet rs = Mysql.QueryData(sqlString1, data1);
                            int count=Tools.addDataTableNum(rs, model1, 3);
                            Tools.setTableSize(C, WIDTH, count);

                            Tools.messageWindows("Add Major Succeeds");
                        }

                    }


                }
            }
        });
        jButton4.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String college = jTextField2.getText();

                if( college.equals("")) {
                    String sqlString="select * from major";
                    ResultSet rs = Mysql.QueryData(sqlString, null);
                    int count=Tools.addDataTableNum(rs, model1, 3);
                    Tools.setTableSize(C, WIDTH, count);
                }else {
                    String sqlString="select * from major where college=?";
                    String data[]= {college};
                    ResultSet rs = Mysql.QueryData(sqlString, data);
                    int count=Tools.addDataTableNum(rs, model1, 3);
                    Tools.setTableSize(C, WIDTH, count);
                    if(count==0) {
                        Tools.messageWindows("["+college+"] Name Is Not Correct or College Does Not Have Such Major!");
                    }

                }


            }
        });
        jButton5.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                String major = jTextField3.getText();

                if( major.equals("")) {
                    String sqlString="select * from major";
                    ResultSet rs = Mysql.QueryData(sqlString, null);
                    int count=Tools.addDataTableNum(rs, model1, 3);
                    Tools.setTableSize(C, WIDTH, count);
                }else {
                    String sqlString="select * from major where proname=?";
                    String data[]= {major};
                    ResultSet rs = Mysql.QueryData(sqlString, data);
                    int count=Tools.addDataTableNum(rs, model1, 3);
                    Tools.setTableSize(C, WIDTH, count);
                    if(count==0) {
                        Tools.messageWindows("["+major+"] Name Is Not Correct");
                    }

                }
            }
        });


        jButton8.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                if(jComboBox.getSelectedIndex()==0) {
                    Tools.messageWindows("Please Select College");
                }else {
                    String collegeString=(String) jComboBox.getSelectedItem();
                    String majoString= jTextField4.getText();

                    if(majoString.equals("")) {
                        Tools.messageWindows("Major Name Cannot Be Empty");
                    }else {

                        String sqlString="DELETE from major where college=? and proname=?";
                        String data[]= {collegeString,majoString};
                        int sta=Mysql.upDate(sqlString, data);
                        if(sta==-1) {
                            Tools.messageWindows("Please Check If Major Name Is Correct");
                        }
                        if(sta==1) {
                            String sqlString1="select * from major";
                            ResultSet rs = Mysql.QueryData(sqlString1, null);
                            int count=Tools.addDataTableNum(rs, model1, 3);
                            Tools.setTableSize(C, WIDTH, count);


                            Tools.messageWindows("Delete Major Succeeds");
                        }

                    }


                }
            }
        });

        //update major
        jButton7.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                if(jComboBox.getSelectedIndex()==0) {
                    Tools.messageWindows("Please Select College");
                }else {
                    String collegeString=(String) jComboBox.getSelectedItem();
                    String majoString= jTextField3.getText();
                    String newMa= jTextField4.getText();
                    if(majoString.equals("")) {
                        Tools.messageWindows("Search Major by Major Name Cannot Be Empty");
                    }else {

                        if(newMa.equals("")) {
                            Tools.messageWindows("Major Name Cannot Be Empty");
                        }else {
                            String sqlString="update major set  proname=? where  college=? and proname=?";
                            String data[]= {newMa,collegeString,majoString};
                            int sta=Mysql.upDate(sqlString, data);
                            if(sta==-1) {
                                Tools.messageWindows("Please Check Major Name You Want To Change To Is Correct");
                            }
                            if(sta==1) {
                                String sqlString1="select * from major";
                                ResultSet rs = Mysql.QueryData(sqlString1, null);
                                int count=Tools.addDataTableNum(rs, model1, 3);
                                Tools.setTableSize(C, WIDTH, count);


                                Tools.messageWindows("Change Major Succeeds");
                            }

                            if(sta==0) {



                                Tools.messageWindows("Change Fails,Please Check If the College Name Corresponds");
                            }

                        }


                    }


                }
            }
        });


//___________________________________________________________________
    }


}
