package com.tools;

import javax.swing.ImageIcon;
import javax.swing.JFrame;

public class EasyCode {

	public static void setTileIcon(JFrame jFrame) {
		
		jFrame.setTitle("Course Registration");
		jFrame.setIconImage(new ImageIcon("src/WindowsIcon/windowsIcon.png").getImage());//设置图标
	}
}
