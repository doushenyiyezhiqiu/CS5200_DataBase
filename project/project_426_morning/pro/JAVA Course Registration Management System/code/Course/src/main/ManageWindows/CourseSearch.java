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
import java.util.Timer;
import java.util.TimerTask;

public class CourseSearch extends JPanel{
    int WIDTH;
    int HEIGHT;

    public CourseSearch(int x,int y,int width,int height) {
        //set axis, height, width

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
        this.add(boxH);

        initJL("College",boxOneBox);
        JComboBox cmb=new JComboBox();
        cmb.addItem("--Select College--");
        boxOneBox.add(cmb);
        Tools.upDateComboBox("select * from college", cmb,"Select College","college");




        boxOneBox.add(Box.createHorizontalStrut(10));
        initJL("Teacher",boxOneBox);
        JComboBox cmb1=new JComboBox();
        cmb1.addItem("--Select Teacher--");
        boxOneBox.add(cmb1);

        boxOneBox.add(Box.createHorizontalStrut(10));
        initJL("Course Name",boxOneBox);
        JComboBox cmb2=new JComboBox();
        cmb2.addItem("--Select Course--");
        boxOneBox.add(cmb2);

        boxOneBox.add(Box.createHorizontalStrut(10));
        initJL("Class Time",boxOneBox);
        JComboBox cmb3=new JComboBox();
        cmb3.addItem("--Select Time--");
        boxOneBox.add(cmb3);
        JComboBox cmbttBox=new JComboBox();

        cmb.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                JComboBox cmbT = (JComboBox)e.getSource();

                if(cmbT.getSelectedIndex()!=0) {
                    String string=(String)cmbT.getSelectedItem();

                    string=	"select * from teacher where oncollege="+"'"+string+"'";
                    Tools.upDateComboBox(string, cmbttBox,"Select Teacher","id");
                    Tools.upDateComboBox(string, cmb1,"Select Teacher","name");

                    //? and teachname=? and cname=? and star ='1'
                    String data[]=new String [cmb1.getItemCount()-1];
                    for(int i=0;i<cmb1.getItemCount()-1;i++) {


                        String string2=	Integer.toString(i+1)+"."+cmb1.getItemAt(i+1);

                        data[i]=string2;

                    }
                    Tools.upDateComboBox(data, cmb1, "Select Teacher");


                }
            }
        });

        cmb1.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                JComboBox cmbT = (JComboBox)e.getSource();

                if(cmbT.getSelectedIndex()!=0) {



                    String college=(String)cmb.getSelectedItem();
                    String string=(String)cmbT.getSelectedItem();
                    String ID=(String)cmbttBox.getItemAt(cmbT.getSelectedIndex());




                    string=	"select * from course where colleges='"+college+"' and id='"+ID+"'and star ='1'";

                    Tools.upDateComboBox(string, cmb2,"Select Course","cname");
                }
            }
        });
        JButton jButton=new JButton("Search Course");
        this.add(jButton);

        Object columns[] ={"Course Registration Number","College","Teacher ID","Teacher","Course Name","Class Time","Student Number"};
        Table t1Table=new Table(columns);
        JTable table = t1Table.getTables();
        JScrollPane JS = t1Table.getJScrollPane();
        DefaultTableModel model = t1Table.getModel();
        JS.setPreferredSize(new Dimension(WIDTH-40,475));

        this.add(JS);
        //__________________________________________________________________


        String data[]= {"morning","noon","afternoon","evening"};
        Tools.upDateComboBox( data, cmb3, "Select Course");



        jButton.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                if(cmb.getSelectedIndex()==0) {



                    Tools.setTableSize(table, WIDTH, Tools.addDataTable(Mysql.QueryData("select * from optcous", null),model,7));
                }else {


                    if(cmb1.getSelectedIndex()==0) {
                        String data[]= {(String)cmb.getSelectedItem()};
                        Tools.setTableSize(table, WIDTH, Tools.addDataTable(Mysql.QueryData("select * from optcous where college=?", data),model,7));
                    }else {


                        if(cmb2.getSelectedIndex()==0) {
                            String data[]= {(String)cmb.getSelectedItem(),(String)cmbttBox.getItemAt(cmb1.getSelectedIndex())};

                            Tools.setTableSize(table, WIDTH, Tools.addDataTable(Mysql.QueryData("select * from optcous where college=? and id=?", data),model,7));
                        }else {


                            if(cmb3.getSelectedIndex()==0) {
                                String data[]= {(String)cmb.getSelectedItem(),(String)cmbttBox.getItemAt(cmb1.getSelectedIndex()),(String)cmb2.getSelectedItem()};
                                Tools.setTableSize(table, WIDTH, Tools.addDataTable(Mysql.QueryData("select * from optcous where college=? and id=? and coursname=?", data),model,7));

                            }else {



                                String data[]= {(String)cmb.getSelectedItem(),(String)cmbttBox.getItemAt(cmb1.getSelectedIndex()),(String)cmb2.getSelectedItem(),(String)cmb3.getSelectedItem()};
                                Tools.setTableSize(table, WIDTH, Tools.addDataTable(Mysql.QueryData("select * from optcous where college=? and id=? and coursname=? and clstime=?", data),model,7));
                            }

                        }

                    }






                }

            }
        });


        //________________________________________________________


        //____________________________________________________________________
        new Timer().schedule(new TimerTask() {
            int a=0;
            @Override
            public void run() {
                try {


                    if(a==0) {
                        if(ManageWindows.jLabel7!=null&& ManageWindows.jLabel7.getForeground().equals(new Color(30,144,255))) {
                            Tools.upDateComboBox("select * from college", cmb,"Please Select Course","college");
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


    String []conNect(String data[],String str){

        String data1[]=new String[ data.length+1];
        int i=0;
        for(;i<data.length;i++) {
            data1[i]=data[i];
        }
        data1[i]=str;
        return data1;

    }


    String [] getSqlData(ResultSet rs,int count) {
        String temp[] = null;
        int index=0;
        try {


            String data[]=new String [count];
            while(rs.next()) {

                for(int i=0;i<count;i++) {
                    data[i]=rs.getString(i+1);
                }

            }
            rs.close();
            return data;





        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return temp;


    }


    void initJL(String text,Box boxH) {
        JLabel jLabel=new JLabel(text);
        jLabel.setFont(StyleFont.Item);
        boxH.add(jLabel);
        boxH.add(Box.createHorizontalStrut(10));

    }
    JTextField initJT(int num,Box boxH) {
        JTextField jTextField =new JTextField(num);
        boxH.add(jTextField);
        boxH.add(Box.createHorizontalStrut(10));
        return jTextField ;
    }


}