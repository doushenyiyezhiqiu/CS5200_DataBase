package main.teacher;

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
import java.sql.SQLException;

public class ScoreManagement extends JPanel {
    int WIDTH;
    int HEIGHT;
    String TeaName;

    public ScoreManagement(int x, int y, int width, int height, String TeaName) {
        //set axis,height, width
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

        ResultSet rs = Mysql.QueryData("select  name,oncollege from teacher where id='" + TeaName + "'", null);

        String[] data = getSqlData(rs, 2);

        JComboBox cmb = new JComboBox();
        cmb.addItem("--Course Selection--");
        String tempString = "select * from optcous where   teacher='" + data[0] + "'and college='" + data[1] + "'";
        Tools.upDateComboBox(tempString, cmb, "Course Selection", "coursname");

        boxOneBox.add(cmb);
        boxOneBox.add(Box.createHorizontalStrut(10));

        JCheckBox jCheckBox = new JCheckBox("Grades Issued");
        boxOneBox.add(jCheckBox);
        jCheckBox.setOpaque(false);
        boxOneBox.add(Box.createHorizontalStrut(10));

        JCheckBox jCheckBox1 = new JCheckBox("Not Issued");
        boxOneBox.add(jCheckBox1);
        boxOneBox.add(Box.createHorizontalStrut(10));
        jCheckBox1.setOpaque(false);

        JButton jButton = new JButton("Search Student");
        boxOneBox.add(jButton);


        //____________________________________________________________________
        Object[] columns = {"Serial Number", "College", "Major", "Course Name", "Scores", "Student ID"};
        Table t1Table = new Table(columns);
        JTable table = t1Table.getTables();
        JScrollPane JS = t1Table.getJScrollPane();
        DefaultTableModel model = t1Table.getModel();
        JS.setPreferredSize(new Dimension(WIDTH - 40, 540));
        this.add(JS);


        //Tools.addDataTableNum(Mysqld.QueryData("select college,pro,optcouse,IF(ISNULL(count)=1,'',count),stunum from studengcours where ", null), model, 5);

        jButton.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub
                if (cmb.getSelectedIndex() == 0) {
                    Tools.messageWindows("Please Select a Course");


                } else {


                    ResultSet rs = Mysql.QueryData("select  name,oncollege from teacher where id='" + TeaName + "'", null);

                    String[] data = getSqlData(rs, 2);


                    String string = (String) cmb.getSelectedItem();//Course Name
                    data = conNect(data, string);
                    if (jCheckBox.isSelected() == false && jCheckBox1.isSelected() == false) {
                        jCheckBox.setSelected(true);
                    }

                    //


                    rs = Mysql.QueryData("select id from optcous where teacher=? and college=? and coursname=?", data);
                    data = getSqlData(rs, 1);

                    //	for(int i=0;i<data.length;i++) {

                    //System.out.print(data[i]+"\t\n");
                    //	}
                    if (jCheckBox.isSelected() == true && jCheckBox1.isSelected() == false) {

                        rs = Mysql.QueryData("select college,pro,optcouse,IF(ISNULL(count)=1,'',count),stunum from studengcours where    cousid=? and ISNULL(count)=0", data);
                    } else if (jCheckBox.isSelected() == false && jCheckBox1.isSelected() == true) {
                        rs = Mysql.QueryData("select college,pro,optcouse,IF(ISNULL(count)=1,'',count),stunum from studengcours where    cousid=? and ISNULL(count)=1", data);
                    } else if (jCheckBox.isSelected() == true && jCheckBox1.isSelected() == true) {
                        rs = Mysql.QueryData("select college,pro,optcouse,IF(ISNULL(count)=1,'',count),stunum from studengcours where    cousid=? ", data);
                    }


                    Tools.setTableSize(table, WIDTH, Tools.addDataTableNum(rs, model, 5));


                }


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
                String inputValue = JOptionPane.showInputDialog("Please Enter Student Grades");
                String numString = (String) table.getValueAt(table.getSelectedRow(), 5);//Student ID


                ResultSet rs = Mysql.QueryData("select  name,oncollege from teacher where id='" + TeaName + "'", null);
                String[] data = getSqlData(rs, 2);
                String string = (String) table.getValueAt(table.getSelectedRow(), 3);
                data = conNect(data, string);


                rs = Mysql.QueryData("select id from optcous where teacher=? and college=? and coursname=? ", data);
                data = getSqlData(rs, 1);

                string = (String) table.getValueAt(table.getSelectedRow(), 5);

                String strsqlString = "update studengcours set count='" + inputValue + "'where cousid='" + data[0] + "'and stunum='" + string + "'";

                Mysql.upDate(strsqlString, null);


                jButton.doClick();

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
        cmb.addMouseListener(new MouseListener() {

            @Override
            public void mouseReleased(MouseEvent e) {
                // TODO Auto-generated method stub


            }

            @Override
            public void mousePressed(MouseEvent e) {
                // TODO Auto-generated method stub
                JComboBox cmbcm = (JComboBox) e.getSource();

                ResultSet rs = Mysql.QueryData("select  name,oncollege from teacher where id='" + TeaName + "'", null);

                String[] data = getSqlData(rs, 2);
                JComboBox cmb = new JComboBox();
                cmb.addItem("--Course Selection--");
                String tempString = "select * from optcous where   teacher='" + data[0] + "'and college='" + data[1] + "'";

                Tools.upDateComboBox(tempString, cmbcm, "Course Selection", "coursname");


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
                JComboBox cmbcm = (JComboBox) e.getSource();
                ResultSet rs = Mysql.QueryData("select  name,oncollege from teacher where id='" + TeaName + "'", null);

                String[] data = getSqlData(rs, 2);

                JComboBox cmb = new JComboBox();
                cmb.addItem("--Course Selection--");
                String tempString = "select * from optcous where   teacher='" + data[0] + "'and college='" + data[1] + "'";

                Tools.upDateComboBox(tempString, cmbcm, "Course Selection", "coursname");


            }
        });




    }


    String[] conNect(String[] data, String str) {

        String[] data1 = new String[data.length + 1];
        int i = 0;
        for (; i < data.length; i++) {
            data1[i] = data[i];
        }
        data1[i] = str;
        return data1;

    }


    String[] getSqlData(ResultSet rs, int count) {
        String[] temp = null;
        int index = 0;
        try {


            String[] data = new String[count];
            while (rs.next()) {

                for (int i = 0; i < count; i++) {
                    data[i] = rs.getString(i + 1);
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
