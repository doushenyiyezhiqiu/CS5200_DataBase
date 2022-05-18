package main.student;

import main.tools.Mysql;
import main.tools.Table;
import main.tools.Tools;
import main.until.ConnectionDB;

import javax.swing.*;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterCourse {
    int WIDTH;
    int HEIGHT;
    JTable table;
    String stunmu;
    int star = 0;
    JPanel jPanel = new JPanel();
    DefaultTableModel model;
    int star_1 = 0;//0 1

    public RegisterCourse(int x, int y, int width, int height, String stunum) {
        //Set coordinates and width and height
        this.stunmu = stunum;
        this.WIDTH = width;
        this.HEIGHT = height;
        this.stunmu = stunum;
        jPanel.setBounds(x, y, width, height);
        init();
    }

    void init() {

        jPanel.setBackground(new Color(255, 255, 255));
        jPanel.setLayout(new FlowLayout(FlowLayout.LEFT, 20, 15));

        JButton jButton1 = new JButton("Refresh the Current Page");

        JButton jButton = new JButton();
        //____________________________________________________________________
        Object[] columns = {"Course ID", "College", "Teacher Name", "Course Name", "Time", "Current Student Number", "Register/Withdraw"};
        Table t1Table = new Table(columns);

        table = t1Table.getTables();
        this.table = table;
        JScrollPane JS = t1Table.getJScrollPane();
        model = t1Table.getModel();
        JS.setPreferredSize(new Dimension(WIDTH - 40, 240));
        jPanel.add(JS);

        ResultSet rs = Mysql.QueryData("select * from optcous", null);
        int num = addDataTable(rs, model, 6);


        Tools.setTableSize(table, WIDTH, num);

        table.setSelectionBackground(table.getBackground());
        table.setSelectionForeground(Color.MAGENTA);


        jButton1.addActionListener(new ActionListener() {


                                       @Override
                                       public void actionPerformed(ActionEvent e) {
                                           // TODO Auto-generated method stub
                                           ResultSet rs = Mysql.QueryData("select * from optcous", null);

                                           jPanel.remove(0);


                                           Object[] columns = {"Course ID", "College", "Teacher Name", "Course Name", "Time", "Current Student Number", "Register/Withdraw"};
                                           Table t1Table = new Table(columns);

                                           table = t1Table.getTables();
                                           JScrollPane JS = t1Table.getJScrollPane();
                                           model = t1Table.getModel();
                                           JS.setPreferredSize(new Dimension(WIDTH - 40, 240));//Set the size of the entire scrollbar window
                                           jPanel.add(JS, 0);
                                           SwingUtilities.updateComponentTreeUI(jPanel);

                                           ResultSet rs1 = Mysql.QueryData("select id,college,teacher,coursname,clstime,numpeo from optcous", null);
                                           int num = addDataTable(rs1, model, 6);
                                           Tools.setTableSize(table, WIDTH, num);

                                           table.setSelectionBackground(table.getBackground());
                                           table.setSelectionForeground(Color.MAGENTA);


                                           for (int i = 0; i < columns.length; i++) {
                                               TableColumn tableColumn = table.getColumn(columns[i]);

                                               tableColumn.setCellRenderer(new DefaultTableCellRenderer() {
                                                   public Component getTableCellRenderermainponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {


                                                       if (table.getValueAt(row, column).equals("Withdraw")) {
                                                           setForeground(Color.red);
                                                       }
                                                       if (table.getValueAt(row, column).equals("Register")) {
                                                           setForeground(Color.BLUE);
                                                       }


                                                       setHorizontalAlignment(SwingConstants.CENTER);
                                                       return super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
                                                   }

                                               });

                                           }


                                           table.addMouseListener(new MouseListener() {

                                                                      @Override
                                                                      public void mouseReleased(MouseEvent e) {
                                                                          // TODO Auto-generated method stub

                                                                      }

                                                                      @Override
                                                                      public void mousePressed(MouseEvent e) {
                                                                          // TODO Auto-generated method stub

                                                                          String valString = (String) table.getValueAt(table.getSelectedRow(), table.getSelectedColumn());
                                                                          String courString = (String) table.getValueAt(table.getSelectedRow(), 3);
                                                                          String[] data11 = setDa(courString, stunmu);
                                                                          Object[] data = {"Yes", "No"};
                                                                          String[] data_ne = new String[data11.length + 1];
                                                                          int j_s = 0;
                                                                          for (int i = 0; i < data11.length; i++) {
                                                                              data_ne[i] = data11[i];
                                                                              j_s = i;
                                                                          }
                                                                          data_ne[j_s + 1] = (String) table.getValueAt(table.getSelectedRow(), 0);


                                                                          int x = table.getMousePosition().x;
                                                                          int y = table.getMousePosition().y;


                                                                          if (valString.equals("Register")) {
                                                                              int num = Tools.isMessage(data, "Course Info", "Whether to Confirm Course Selection");


                                                                              if (star == 2) {
                                                                                  Tools.messageWindows("The Maximum Number of Courses You Can Take Is Two!");

                                                                              } else if (num == 0) {
                                                                                  star++;


                                                                                  int a = Mysql.upDate("insert into studengcours  (college,pro,optcouse,stunum,cousid) VALUES (?,?,?,?,?)", data_ne);

                                                                                  String[] data_s = {(String) table.getValueAt(table.getSelectedRow(), 1),
                                                                                          (String) table.getValueAt(table.getSelectedRow(), 2),
                                                                                          (String) table.getValueAt(table.getSelectedRow(), 3),
                                                                                          (String) table.getValueAt(table.getSelectedRow(), 4)};
                                                                                  Mysql.upDate("update optcous set numpeo=numpeo+1 where college=? and teacher=? and coursname=?  and clstime=?", data_s);

                                                                                  TableColumn tableColumn = table.getColumn(columns[6]);
                                                                                  tableColumn.setCellRenderer(new DefaultTableCellRenderer() {
                                                                                      public Component getTableCellRenderermainponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {

                                                                                          String courString = (String) table.getValueAt(table.getSelectedRow(), 3);
                                                                                          int num = readHasOptCous(setDa(courString, stunmu));

                                                                                          if (column == 6 && num == 1 && row == table.getSelectedRow()) {

                                                                                              table.setValueAt("Withdraw", row, column);


                                                                                          }


                                                                                          if (table.getValueAt(row, column).equals("Withdraw")) {
                                                                                              setForeground(Color.red);
                                                                                          }
                                                                                          if (table.getValueAt(row, column).equals("Register")) {
                                                                                              setForeground(Color.BLUE);
                                                                                          }

                                                                                          setHorizontalAlignment(SwingConstants.CENTER);
                                                                                          return super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
                                                                                      }

                                                                                  });

                                                                                  jButton1.doClick();
                                                                                  jButton.doClick();
                                                                              }
                                                                          }


                                                                          if (valString.equals("Withdraw")) {
                                                                              int num = Tools.isMessage(data, "Course Info", "Whether to Confirm Course Withdrawal");
                                                                              if (num == 0) {
                                                                                  star--;

                                                                                  int num1 = Mysql.upDate("delete from studengcours where college=? and pro=? and optcouse=? and stunum=?", data11);
                                                                                  String[] data_s = {(String) table.getValueAt(table.getSelectedRow(), 1),
                                                                                          (String) table.getValueAt(table.getSelectedRow(), 2),
                                                                                          (String) table.getValueAt(table.getSelectedRow(), 3),
                                                                                          (String) table.getValueAt(table.getSelectedRow(), 4)};
                                                                                  Mysql.upDate("update optcous set numpeo=numpeo-1 where college=? and teacher=? and coursname=?  and clstime=?", data_s);

                                                                                  TableColumn tableColumn = table.getColumn(columns[6]);

                                                                                  tableColumn.setCellRenderer(new DefaultTableCellRenderer() {
                                                                                      public Component getTableCellRenderermainponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {

                                                                                          String courString = (String) table.getValueAt(table.getSelectedRow(), 3);
                                                                                          int num = readHasOptCous(setDa(courString, stunmu));
                                                                                          if (column == 6 && num == 0 && row == table.getSelectedRow()) {


                                                                                              table.setValueAt("Register", row, column);

                                                                                          }

                                                                                          if (table.getValueAt(row, column).equals("Withdraw")) {
                                                                                              setForeground(Color.red);
                                                                                          }
                                                                                          if (table.getValueAt(row, column).equals("Register")) {
                                                                                              setForeground(Color.BLUE);
                                                                                          }


                                                                                          setHorizontalAlignment(SwingConstants.CENTER);
                                                                                          return super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
                                                                                      }

                                                                                  });

                                                                                  jButton1.doClick();
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


                                                                  }


                                           );



                                       }

                                   }
        );


        //_______________________________________________________
        for (int i = 0; i < columns.length; i++) {

            TableColumn tableColumn = table.getColumn(columns[i]);

            tableColumn.setCellRenderer(new DefaultTableCellRenderer() {
                public Component getTableCellRenderermainponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {


                    if (table.getValueAt(row, column).equals("Withdraw")) {
                        setForeground(Color.red);


                    }
                    if (table.getValueAt(row, column).equals("Register")) {
                        setForeground(Color.BLUE);

                    }


                    setHorizontalAlignment(SwingConstants.CENTER);
                    return super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
                }

            });

        }

        table.addMouseListener(new MouseListener() {

            @Override
            public void mouseReleased(MouseEvent e) {
                // TODO Auto-generated method stub

            }

            @Override
            public void mousePressed(MouseEvent e) {
                // TODO Auto-generated method stub

                String valString = (String) table.getValueAt(table.getSelectedRow(), table.getSelectedColumn());
                String courString = (String) table.getValueAt(table.getSelectedRow(), 3);
                String[] data11 = setDa(courString, stunmu);
                Object[] data = {"Yes", "No"};
                String[] data_ne = new String[data11.length + 1];
                int j_s = 0;
                for (int i = 0; i < data11.length; i++) {
                    data_ne[i] = data11[i];
                    j_s = i;
                }
                data_ne[j_s + 1] = (String) table.getValueAt(table.getSelectedRow(), 0);


                int x = table.getMousePosition().x;
                int y = table.getMousePosition().y;


                if (valString.equals("Register")) {
                    int num = Tools.isMessage(data, "Course Info", "Whether to Confirm Course Selection");


                    if (star == 2) {
                        Tools.messageWindows("The Maximum Number of Courses You Can Take Is Two!");

                    } else if (num == 0) {

                        star++;


                        int a = Mysql.upDate("insert into studengcours  (college,pro,optcouse,stunum,cousid) VALUES (?,?,?,?,?)", data_ne);

                        String[] data_s = {(String) table.getValueAt(table.getSelectedRow(), 1),
                                (String) table.getValueAt(table.getSelectedRow(), 2),
                                (String) table.getValueAt(table.getSelectedRow(), 3),
                                (String) table.getValueAt(table.getSelectedRow(), 4)};
                        Mysql.upDate("update optcous set numpeo=numpeo+1 where college=? and teacher=? and coursname=?  and clstime=?", data_s);

                        TableColumn tableColumn = table.getColumn(columns[6]);
                        tableColumn.setCellRenderer(new DefaultTableCellRenderer() {
                            public Component getTableCellRenderermainponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {

                                String courString = (String) table.getValueAt(table.getSelectedRow(), 3);
                                int num = readHasOptCous(setDa(courString, stunmu));

                                if (column == 6 && num == 1 && row == table.getSelectedRow()) {

                                    table.setValueAt("Withdraw", row, column);


                                }


                                if (table.getValueAt(row, column).equals("Withdraw")) {
                                    setForeground(Color.red);


                                }
                                if (table.getValueAt(row, column).equals("Register")) {
                                    setForeground(Color.BLUE);


                                }

                                setHorizontalAlignment(SwingConstants.CENTER);
                                return super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
                            }

                        });

                        jButton1.doClick();
                        jButton.doClick();
                    }
                }


                if (valString.equals("Withdraw")) {
                    int num = Tools.isMessage(data, "Course Info", "Whether to Confirm Course Withdrawal");
                    if (num == 0) {
                        star--;


                        int num1 = Mysql.upDate("delete from studengcours where college=? and pro=? and optcouse=? and stunum=?", data11);
                        String[] data_s = {(String) table.getValueAt(table.getSelectedRow(), 1),
                                (String) table.getValueAt(table.getSelectedRow(), 2),
                                (String) table.getValueAt(table.getSelectedRow(), 3),
                                (String) table.getValueAt(table.getSelectedRow(), 4)};
                        Mysql.upDate("update optcous set numpeo=numpeo-1 where college=? and teacher=? and coursname=?  and clstime=?", data_s);

                        TableColumn tableColumn = table.getColumn(columns[6]);

                        tableColumn.setCellRenderer(new DefaultTableCellRenderer() {
                            public Component getTableCellRenderermainponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {

                                String courString = (String) table.getValueAt(table.getSelectedRow(), 3);
                                int num = readHasOptCous(setDa(courString, stunmu));
                                if (column == 6 && num == 0 && row == table.getSelectedRow()) {


                                    table.setValueAt("Register", row, column);

                                }

                                if (table.getValueAt(row, column).equals("Withdraw")) {
                                    setForeground(Color.red);
                                    table.setSelectionForeground(Color.red);
                                }
                                if (table.getValueAt(row, column).equals("Register")) {
                                    setForeground(Color.BLUE);
                                    table.setSelectionForeground(Color.BLUE);
                                }


                                setHorizontalAlignment(SwingConstants.CENTER);
                                return super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
                            }

                        });

                        jButton1.doClick();
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

        JLabel jLabel = new JLabel("◎ Selected Courses");
        jPanel.add(jLabel);
        jPanel.add(jButton1);
        jLabel.setForeground(new Color(102, 204, 255));
        jLabel.setFont(new Font("New Times Roman", Font.BOLD, 15));


        //________________________________________________________
        Object[] A = {"Course Name", "Teacher Name", "Time", "Grades", "Status"};
        Table B = new Table(A);
        JTable C = B.getTables();
        JScrollPane D = B.getJScrollPane();
        D.setPreferredSize(new Dimension(WIDTH - 40, 290));
        DefaultTableModel model1 = B.getModel();
        jPanel.add(D);
        //__________________________________________________________________


        //jPanel.add(jButton);
        jButton.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                // TODO Auto-generated method stub

                ResultSet rs = Mysql.QueryData("select cousid from studengcours where stunum='" + stunmu + "'", null);
                int count = 0;
                try {
                    model1.setRowCount(0);

                    while (rs.next()) {
                        String string = rs.getString("cousid");
                        String[] data = {string, string, stunmu};

                        String aString = "select optcouse,"
                                + "			(select teacher from optcous where id=?)  ,"
                                + "			(select clstime from optcous where id=?)  ,"
                                + "			if(ISNULL(count)=1,'0', count) ,"
                                + "			if(ISNULL(count)=1,'Not Issued','Grades Have Been Issued')"
                                + "			from studengcours where stunum=?";
                        ResultSet rs1 = Mysql.QueryData(aString, data);

                        String[] data1 = new String[5];
                        while (rs1.next()) {
                            count++;
                            for (int i = 0; i < data1.length; i++) {
                                data1[i] = rs1.getString(i + 1);

                            }

                            model1.addRow(data1);

                        }
                        rs1.close();
                    }
                    model1.setRowCount(2);

                    rs.close();
                } catch (SQLException e1) {
                    // TODO Auto-generated catch block
                    e1.printStackTrace();
                }

                //
                if (count == 4) {
                    Tools.setTableSize(C, WIDTH, 2);
                } else {
                    Tools.setTableSize(C, WIDTH, 1);
                }


                //_____________________________________________


            }
        });
        jButton.doClick();


    }

    public JPanel getJP() {
        return jPanel;
    }



    public int addDataTable(ResultSet rs, DefaultTableModel model, int index) {
        int count = 0;
        model.setNumRows(0);
        star = 0;
        String[] data = new String[index + 1];
        try {

            while (rs.next()) {
                count++;
                for (int i = 0; i < data.length - 1; i++) {
                    data[i] = rs.getString(i + 1);
                }


                String courString = data[3];

                int num = readHasOptCous(setDa(courString, stunmu));
                if (num == 0) {
                    data[index] = "Register";
                } else {
                    data[index] = "Withdraw";
                    star++;
                }

                model.addRow(data);


            }


            rs.close();
            return count;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return count;
        }
    }


    int readHasOptCous(String[] data) {

        String sqlStr = "select * from studengcours where college=? and pro=? and optcouse=? and stunum=?";
        PreparedStatement preSql;
        ResultSet rs;
        int num = 0;
        try {

            preSql = ConnectionDB.con.prepareStatement(sqlStr);

            for (int i = 0; i < data.length; i++) {
                preSql.setString(i + 1, data[i]);
            }

            rs = preSql.executeQuery();
            while (rs.next()) {
                num++;
            }
            rs.close();

            return num;


        } catch (SQLException e) {
            // TODO: handle exception
            e.printStackTrace();
            return -1;
        }


    }

    String[] setDa(String a, String b) {

        String[] data = new String[4];
        ResultSet rs = Mysql.QueryData("select oncollege,peojob,name from student where id='" + stunmu + "'", null);
        String A = "";
        String B = "";

        try {

            while (rs.next()) {
                data[0] = rs.getString(1);//college
                data[1] = rs.getString(2);//major

            }
            data[2] = a;
            data[3] = b;
            rs.close();
            return data;

        } catch (SQLException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
            return data;
        }

    }


}
