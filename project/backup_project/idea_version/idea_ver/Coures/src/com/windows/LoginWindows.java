package com.windows;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;
import java.util.Timer;
import java.util.TimerTask;

import javax.swing.Box;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import com.style.StyleFont;

import com.tools.EasyCode;
import com.tools.Mysqld;
import com.tools.Tools;

public class LoginWindows {

	//定义一个界面
	JFrame jFrame=new JFrame();
	
	final int WIDTH=450;
	final int HEIGHT=230;
	//登录界面
	public LoginWindows() {
		
		
		init();	
		jFrame.setResizable(false);//窗口是否可变
		jFrame.setVisible(true);//窗口是否可见
		jFrame.setDefaultCloseOperation(jFrame.DISPOSE_ON_CLOSE);//设置默认关闭方式
		jFrame.validate();//让组件生效
        //这种写法 可以避免打包成exe文件或者jar时候文件丢失的问题
        //jframe.setIconImage(new ImageIcon(Login.class.getResource("/ImageIcon/windowsIcon.png")).getImage());//设置图标
        
   
		
		
	}
	
	void init() {
		
		
		//设置窗口在屏幕中间  并设置大小
		Tools.setWindowPos(WIDTH, HEIGHT, jFrame);
		EasyCode.setTileIcon(jFrame);//设置标题和图标
		
		jFrame.setLayout(null);//设置为恐怖剧
		
		//设置背景图片
		 //jframe.setLayout(new GridLayout());
		ImageIcon img=new ImageIcon("src/img/LoginImg.jpg");//加载图片
		
        JLabel bgimg = new JLabel(img);//定义一个标签用于存放图片
        bgimg.setBounds(0,0,WIDTH,HEIGHT);//设置标签大小
        
        JPanel jPanel=new JPanel();//定义一个盘子装标题
        jPanel.setLayout(new FlowLayout(FlowLayout.CENTER,0,HEIGHT/3/2-36));
        jPanel.setOpaque(false);
        jPanel.setBounds(0, 0, WIDTH, HEIGHT/3);
        
        JLabel jLabel=new JLabel("Course Registration System");
        jPanel.add(jLabel);
        jLabel.setFont(StyleFont.titleFont);
        jLabel.setForeground(Color.ORANGE);
        
        JPanel jPanel2=new JPanel();//存放账号和密码
        jPanel2.setLayout(new FlowLayout(FlowLayout.CENTER));//设置居中对齐
        jPanel2.setBounds(0, HEIGHT/3, WIDTH, HEIGHT/3-15);
        //jPanel2.setOpaque(false);
        jPanel2.setBackground(new Color(235, 229, 209));
        Box boxH;
        Box boxOne,boxTwo;
        boxH=Box.createHorizontalBox();
        boxOne=Box.createVerticalBox();
        boxTwo=Box.createVerticalBox();
        
       
        //______________________________________________________
        ImageIcon img1=new ImageIcon("src/WindowsIcon/zhanghao.png");//加载图片
        JLabel bgimg1 = new JLabel(img1);//定义一个标签用于存放图片
    
        //jPanel2.add(bgimg1);
        
    
        JTextField jTextField=new JTextField(14);
       // jPanel2.add(jTextField);
        
        ImageIcon img2=new ImageIcon("src/WindowsIcon/mima54.png");//加载图片
        JLabel bgimg2 = new JLabel(img2);//定义一个标签用于存放图片
       // jPanel2.add(bgimg2);
        
        
        JPasswordField jTextField2=new JPasswordField(14);
      //  jPanel2.add(jTextField2);
        
        
        
        
        //定义盘子3装  登录按钮 和 找回密码
        
        JPanel jPanel3=new JPanel();
        jPanel3.setLayout(new FlowLayout(FlowLayout.CENTER));
        jPanel3.setBounds(0, HEIGHT/3*2-15, WIDTH, HEIGHT/3+10);
        jPanel3.setBackground(Color.PINK);
        JButton jButton=new JButton("Log In");
        jPanel3.add(jButton);
        jButton.setPreferredSize(new Dimension(175,27));
        jButton.setBackground(new Color(   91,192,222));
        jButton.setForeground(new Color(  228,243,248));
        jButton.setFont(StyleFont.loginFont);
        
        
        boxOne.add(bgimg1);
        boxOne.add(bgimg2);
        boxTwo.add(jTextField);
        boxTwo.add(jTextField2);
        
        boxH.add(boxOne);
        boxH.add(boxH.createHorizontalStrut(10));//设置组件之间间隔
        boxH.add(boxTwo);
        jPanel2.add(boxH);
        
        //______________________________________________________
  
       jFrame.add(jPanel3);
       jFrame.add(jPanel2);
       jFrame.add(jPanel);
       jFrame.add(bgimg);
       
       
       //对事件处理
   		jButton.addActionListener(new ActionListener() {
		
		@Override
		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
		
			
			String accountString=jTextField.getText();
			String password=Tools.getPassword(jTextField2);
			
			if(accountString.equals("")) {
				Tools.messageWindows("账号不能为空");
				//账号不能为空
			}else if(password.equals("")) {
				//密码不能为空
				Tools.messageWindows("密码不能为空");
			}else {
				String data[]=new String [2];//初始化一个数组
				data[0]=accountString;
				data[1]=password;
				String sqlString="select * from users where account=? and password=?";
				ResultSet rs = Mysqld.QueryData(sqlString, data);
				try {
					
					if(rs.next()) {
						String poString=rs.getString("pow");
						
						if(poString.equals("1")) {
							//登录管理员界面
							ManageWindows manageWindowss=new ManageWindows();
							jFrame.dispose();
							
							
						}
						
						if(poString.equals("2")) {
							//登录老师界面
							TeacherWindows manageWindows=new TeacherWindows(accountString);
							jFrame.dispose();
						}
						
						if(poString.equals("3")) {
							//登录学生界面
							StudentWindows manageWindowss=new StudentWindows(accountString);
							jFrame.dispose();
							
						}
						rs.close();
					}else {
						Tools.messageWindows("账号或者密码错误");
					}
					
					
				} catch (Exception e2) {
					// TODO: handle exception
				}
				
			}
			
			
			
			
		}
	});
   		
   //写一些刷新的东西
  
   		
   		
        
	}
	


	
	
	
	
}
