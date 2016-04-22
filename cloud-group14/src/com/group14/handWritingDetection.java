package com.group14;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.sql.Time;

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
		 	response.setContentType("text/html");
		 	getServletContext().log(data);
		 	try{
		 		byte[] k = base64.decode(data.substring("data:image/png;base64,".length()));
		 		InputStream is = new ByteArrayInputStream(k);
		 		BufferedImage image = ImageIO.read(is);
		 		double ratio = 1.0; 
		 		String serverPath = request.getSession().getServletContext().getRealPath("/");  
		 		int newWidth = (int) (image.getWidth() * ratio);  
		 		int newHeight = (int) (image.getHeight() * ratio);  
		 		Image newimage = image.getScaledInstance(newWidth, newHeight,Image.SCALE_SMOOTH);  
		 		out.println(serverPath);
		 		
		 	}catch(Exception e){
		 		out.println ("error"+e.getMessage());
		 	} 	
	        
	    }


}
