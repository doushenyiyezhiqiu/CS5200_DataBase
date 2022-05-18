package main.listen;

import javax.swing.*;
import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

public class ItemListenMouse implements MouseListener {

    public static JLabel oldJLabel;//record new click
    Object obj;
    JLayeredPane jPanel3;
    boolean sta;

    public ItemListenMouse(JLayeredPane jPanel3, Object obj) {
        this.obj = obj;
        this.jPanel3 = jPanel3;
    }

    @Override
    public void mouseClicked(MouseEvent e) {
        // TODO Auto-generated method stub

    }

    @Override
    public void mousePressed(MouseEvent e) {
        // TODO Auto-generated method stub

        JLabel jLabel = (JLabel) e.getSource();
        sta = (jLabel == oldJLabel);

        if (sta != true) {
            jPanel3.moveToFront((Component) obj);//put plate in the first floor
            jLabel.setForeground(new Color(30, 144, 255));
            oldJLabel.setForeground(new Color(51, 51, 51));
            oldJLabel = jLabel;


        }


    }

    @Override
    public void mouseReleased(MouseEvent e) {
        // TODO Auto-generated method stub
    }


    @Override
    public void mouseEntered(MouseEvent e) {
        // TODO Auto-generated method stub
        JLabel jLabel = (JLabel) e.getSource();


        sta = (jLabel == oldJLabel);
        if (sta != true) {
            jLabel.setForeground(new Color(30, 144, 255));
        }

    }

    @Override
    public void mouseExited(MouseEvent e) {
        // TODO Auto-generated method stub
        JLabel jLabel = (JLabel) e.getSource();

        sta = (jLabel == oldJLabel);
        if (sta != true) {
            jLabel.setForeground(new Color(51, 51, 51));
        }


    }

}
