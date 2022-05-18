package main.tools;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Tools {

    public static void setWindowPos(int WIDTH, int HEIGHT, JFrame jframe) {
        Toolkit kit = Toolkit.getDefaultToolkit();
        Dimension screenSize = kit.getScreenSize();
        int width = screenSize.width;
        int height = screenSize.height;
        int x = (width - WIDTH) / 2;
        int y = (height - HEIGHT) / 2;
        jframe.setBounds(x, y, WIDTH, HEIGHT);
    }

    public static String getPassword(JPasswordField jp) {
        String password = new String(jp.getPassword());
        return password;
    }

    public static void messageWindows(String msg, String title) {
        JOptionPane.showMessageDialog(null, msg, title, JOptionPane.WARNING_MESSAGE);
    }

    public static void messageWindows(String msg) {
        JOptionPane.showMessageDialog(null, msg, "Information", JOptionPane.WARNING_MESSAGE);
    }
//__________________________________________________________________________________________

    public static boolean isHasData(ResultSet rs) {
        int num = 0;
        try {

            while (rs.next()) {
                num++;
            }
            if (num == 0) {
                rs.close();
                return false;
            } else {
                rs.close();
                return true;
            }


        } catch (SQLException e) {
            // TODO Auto-generated catch block

            return false;


        }
    }

    public static void upDateComboBox(String strsql, JComboBox jComboBox, String str, String prams) {

        ResultSet rs = Mysql.QueryData(strsql, null);
        jComboBox.removeAllItems();
        jComboBox.addItem("--" + str + "--");
        try {
            int j = 0;
            while (rs.next()) {
                String name = rs.getString(prams);
                jComboBox.addItem(name);
            }
            rs.first();
            if (rs == null) {
                jComboBox.addItem("--" + str + "--");
            }
            rs.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    public static void upDateComboBox(String[] strs, JComboBox jComboBox, String str) {


        jComboBox.removeAllItems();
        jComboBox.addItem("--" + str + "--");

        for (int i = 0; i < strs.length; i++) {
            jComboBox.addItem(strs[i]);

        }


    }

    public static int addDataTable(ResultSet rs, DefaultTableModel model, int index) {
        int count = 0;
        model.setNumRows(0);
        String[] data = new String[index];
        try {
            while (rs.next()) {
                count++;
                for (int i = 0; i < data.length; i++) {
                    data[i] = rs.getString(i + 1);

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

    public static int addDataTableNum(ResultSet rs, DefaultTableModel model, int index) {
        int count = 0;
        model.setNumRows(0);
        String[] data = new String[index + 1];
        try {
            if (rs == null) {
                return 0;
            }
            while (rs.next()) {
                count++;
                data[0] = String.valueOf(count);
                for (int i = 1; i < data.length; i++) {

                    data[i] = rs.getString(i);

                }
                model.addRow(data);

            }
            rs.close();
            return count;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            //e.printStackTrace();
            return count;
        }
    }

    public static void setTableSize(JTable table, int WIDTH, int num) {

        int h = 0;
        for (int i = 1; i <= num; i++) {
            h = h + 16;
        }
        table.setPreferredSize(new Dimension(WIDTH - 30, h));
    }

    public static int getPosJT(Component[] JLS, Color color) {

        for (int i = 0; i < JLS.length; i++) {
            if (JLS[i].getForeground().equals(color)) {
                return i;
            }
        }

        return 1;


    }

    public static int isMessage(Object[] options, String title, String content) {

        int m = JOptionPane.showOptionDialog(null,
                content,
                title,
                JOptionPane.YES_NO_OPTION,
                JOptionPane.QUESTION_MESSAGE,
                null,
                options,
                options[0]);
        return m;
    }

}
