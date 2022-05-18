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
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.sql.ResultSet;

public class CourseApplication extends JPanel{
    int WIDTH;
    int HEIGHT;
    public static int onfont=0;
    public CourseApplication(int x,int y,int width,int height) {
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
        Box boxOneBox=Box.createHorizontalBox();// define the first line
        boxH.add(boxOneBox);
        this.add(boxH);

        initJL("Application Status",boxOneBox);

        JCheckBox checkbox1=new JCheckBox("Application");
        JCheckBox checkbox2=new JCheckBox("Rejected");
        JCheckBox checkbox3=new JCheckBox("Approved");

        boxH.add(Box.createHorizontalStrut(10));
        boxOneBox.add(checkbox1);
        boxH.add(Box.createHorizontalStrut(10));
        boxOneBox.add(checkbox2);
        boxH.add(Box.createHorizontalStrut(10));
        boxOneBox.add(checkbox3);


        checkbox1.setOpaque(false);
        checkbox2.setOpaque(false);
        checkbox3.setOpaque(false);

        //if Application approved
        boxH.add(Box.createHorizontalStrut(10));
        JButton jButton=new JButton("Check Application Status");
        boxOneBox.add(jButton);



        //________________________________________________________
        Object columns[] ={"Serial Number","Teacher","Course Name","Application Status"};
        Table t1Table=new Table(columns);
        JTable table = t1Table.getTables();
        JScrollPane JS = t1Table.getJScrollPane();
        DefaultTableModel model = t1Table.getModel();
        JS.setPreferredSize(new Dimension(WIDTH-40,540));


        this.add(JS);
        //__________________________________________________________________

        jButton.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                boolean A = checkbox1.isSelected();
                boolean B=	checkbox2.isSelected();
                boolean C=	checkbox3.isSelected();

                if(A==false && B==false && C==false) {
                    checkbox1.setSelected(true);
                    A=true;
                }

                String sqlA="";
                String sqlB="";
                String sqlC="";


                int learn=0;
                if(A==true) {
                    if(learn==0) {
                        sqlA="  star='0'  ";
                    }else {
                        sqlA="  or star='0'  ";
                    }

                    learn++;

                }

                if(B==true) {
                    if(learn==0) {
                        sqlB="  star='2'  ";
                    }else {
                        sqlB="  or star='2'  ";
                    }
                    learn++;
                }

                if(C==true) {
                    if(learn==0) {
                        sqlC="  star='1'  ";
                    }else {
                        sqlC="  or star='1'  ";
                    }
                    learn++;
                }


                String strsqlString="select teachname, cname, if(star=0,'Application is processing',if(star=1,'Application approved',if(star=2,'Application rejected','Application canceled'))) from course  where "+sqlA+sqlB+sqlC;




                ResultSet rs = Mysql.QueryData(strsqlString, null);

                int num=Tools.addDataTableNum(rs, model,3);
                Tools.setTableSize(table, WIDTH, num);
                if(num==0) {
                    Tools.messageWindows("Nothing Found");
                }

                Tools.setTableSize(table, WIDTH, num);

            }
        });


        table.addMouseListener(new MouseListener() {

            @Override
            public void mouseReleased(MouseEvent e) {
                // TODO Auto-generated method stub

            }

            @Override
            public void mousePressed(MouseEvent e) {
                // TODO Auto-generated method stub
                JTable tab = (JTable)e.getSource();

                int x=tab.getMousePosition().x;
                int y=tab.getMousePosition().y;
                int cellPosx=x/(tab.getWidth()/tab.getColumnCount());
                int cellPosy=y/(tab.getHeight()/tab.getRowCount());
                int row=tab.getSelectedRow();
                int colunme=tab.getSelectedColumn();




                if(tab.getValueAt(row,3).equals("Application is processing")) {
                    Object[] options ={ "Application approved", "Application rejected" };
                    int m=Tools.isMessage(options, "Application Message", "Whether To Agree To the Course Application？");
                    if (m==0) {
                        //Application approved
                        String data[]= {(String) tab.getValueAt(row,1),(String) tab.getValueAt(row,2)};
                        Mysql.upDate("update course set star='1' where teachname=? and cname=?", data);
                        checkbox1.setSelected(false);
                        checkbox2.setSelected(false);
                        checkbox3.setSelected(true);
                        jButton.doClick();


                    }else if(m==1) {
                        String data[]= {(String) tab.getValueAt(row,1),(String) tab.getValueAt(row,2)};
                        Mysql.upDate("update course set star='2' where teachname=? and cname=?", data);
                        checkbox1.setSelected(false);
                        checkbox2.setSelected(true);
                        checkbox3.setSelected(false);
                        jButton.doClick();
                    }
                }

            }

            @Override
            public void mouseExited(MouseEvent e) {
                // TODO Auto-generated method stub

            }

            @Override
            public void mouseEntered(MouseEvent e) {
                // TODO Auto-generated method stub

            }

            @Override
            public void mouseClicked(MouseEvent e) {
                // TODO Auto-generated method stub

            }
        });














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
