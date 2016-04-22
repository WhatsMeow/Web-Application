package com.group14;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloWorld2
 */
@WebServlet("/HelloWorld2")
public class web extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public web() {
        // TODO Auto-generated constructor stub
        
        
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    @SuppressWarnings("deprecation")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        PrintWriter out = response.getWriter();
        //out.print("helloWorld");
        
        //String outPut=request.getParameter("input");
        out.print(request);
        System.out.println(request);
        
        String c = request.getParameter("color");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("Beer Selection Advice<br>");
        String c = request.getParameter("color");
        out.println("<br> Got beer color"+c);
        
        System.out.println(c);
        
        
    }

}
