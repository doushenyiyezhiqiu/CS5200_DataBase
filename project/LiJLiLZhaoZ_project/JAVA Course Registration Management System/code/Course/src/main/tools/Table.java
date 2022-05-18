package main.tools;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class Table {

    JTable tableL = null;
    JScrollPane jscrollpane;
    DefaultTableModel model = null;

    public Table(Object[] columns) {
        Table(columns);
    }


    void Table(Object[] columns) {
        tableL = getTable(columns);
        jscrollpane = new JScrollPane(tableL);
        jscrollpane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
    }

    JTable getTable(Object[] columns) {
        if (tableL == null) {
            tableL = new JTable();//
            model = new DefaultTableModel() {
                public boolean isCellEditable(int row, int column) {
                    return false;
                }

            };
            model.setColumnIdentifiers(columns);
            tableL.setModel(model);
            tableL.getTableHeader().setReorderingAllowed(false);
            tableL.getTableHeader().setResizingAllowed(false);
        }

        return tableL;
    }


    public JTable getTables() {
        return tableL;
    }

    public JScrollPane getJScrollPane() {
        return jscrollpane;
    }

    public DefaultTableModel getModel() {
        return model;
    }
}
