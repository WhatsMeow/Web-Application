package com.group14;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.sql.Time;
import java.util.Arrays;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.codec.binary.Base64;

@WebServlet("/handWritingDetection")
public class handWritingDetection extends HttpServlet{
	 private static final long serialVersionUID = 1L;

	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // TODO Auto-generated method stub
		 	Base64 base64 = new Base64();
		 	String data = request.getParameter("picture");
		 	PrintWriter out = response.getWriter();
		 	int newWidth = 28;  
	 		int newHeight = 28;
		 	double[] input = new double[newWidth*newHeight];
		 	response.setContentType("text/html");
		 	String serverPath = request.getSession().getServletContext().getRealPath("/");   
		 	try{
		 		byte[] k = base64.decode(data.substring("data:image/png;base64,".length()));
		 		InputStream is = new ByteArrayInputStream(k);
		 		BufferedImage image = ImageIO.read(is);
		 		//BufferedImage image= ImageIO.read(new File(serverPath+"/images/t1.jpg"));
		 		ImageIO.write(image,"JPEG",new File(serverPath+"/images/t2.JPG"));
		 		//double ratio = double(28)/image.getHeight(); 
		 		//Image newimage = image.getScaledInstance(newWidth, newHeight,Image.SCALE_SMOOTH); 
	
		 		BufferedImage tag = new BufferedImage(newWidth,newHeight,BufferedImage.TYPE_INT_ARGB);
		 		Graphics2D g = tag.createGraphics();
		 		g.drawImage(image,0,0,newWidth,newHeight,null);
		 		g.dispose();
		 		

		 		ImageIO.write(tag,"PNG",new File(serverPath+"/images/test2.png"));
		 		//BufferedImage grayImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_USHORT_GRAY);//重点，技巧在这个参数BufferedImage.TYPE_BYTE_BINARY  
		 		for(int i= 0 ; i < newWidth ; i++){  
		 			for(int j = 0 ; j < newHeight; j++){  
		 				int rgb = tag.getRGB(j, i);  
		 				/*System.out.println(rgb);
		 				System.out.println((rgb & 0xff0000)>>16);
		 				System.out.println((rgb & 0xff00)>>8);
		 				System.out.println((rgb & 0xff));*/
		 		
		 				if( Math.abs(rgb) > 0)
		 				//grayImage.setRGB(i, j, rgb);  
		 					input[i*newWidth+j] = 1.0;
		 				else
		 					input[i*newWidth+j] = 0.0;
		 			}  
		 		}  

		 		//getServletContext().log("new log");
		 		//getServletContext().log(grayImage.toString());
		 		out.println(Arrays.toString(input));
		 		
		 	}catch(Exception e){
		 		out.println ("error"+e.getMessage());
		 	} 	
	        
	    }


}
