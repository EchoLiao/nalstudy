import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class login_confirm extends HttpServlet{

	
 public void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {	
        
   String message=null; 
   String id=null;
   id=req.getParameter("id");
   HttpSession session=req.getSession(true);
   session.setAttribute("id",String.valueOf(id));
   String password=null;
   password= req.getParameter("password");
 
   String kind =null;
   kind=req.getParameter("kind");
   String temp =getPassword(req,res,id,kind);
   if( password.equals(temp))
   goo(req,res,kind);
   else {
   message="用户名或密码有误！";
   doError(req,res,message)	;
 	}
 	} 
  
public void goo(HttpServletRequest req, HttpServletResponse res,String kind)
throws ServletException,IOException
{

	if(kind.equals("student")) {	
	RequestDispatcher rd = getServletContext().getRequestDispatcher("/student.jsp");
    rd.forward(req, res);}
    if(kind.equals("teacher")){
    	RequestDispatcher rd = getServletContext().getRequestDispatcher("/teacher.jsp");
    rd.forward(req, res);}
    if(kind.equals("admin")){
    	RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin.jsp");
    rd.forward(req, res);}
	}
	

  
     
  public String getPassword(HttpServletRequest req, HttpServletResponse res,
                        String id,String kind)
                        throws ServletException, IOException {
   sqlBean db= new sqlBean();                  	
   String pw="";                     	                     	
   String sql="select password from "+kind+" where id='"+id+"'";
   try{
   ResultSet rs=db.executeQuery(sql); 	
   if(rs.next() ){
     pw= rs.getString("password");
   	}
   	} 
   	catch(Exception e)
{ System.out.print(e.toString());}   	    
    return pw; 
                            }
     
     	
      
     public void doError(HttpServletRequest req,
                      HttpServletResponse res,
                      String str)
                      throws ServletException, IOException {

    req.setAttribute("problem", str);
    RequestDispatcher rd = getServletContext().getRequestDispatcher("/errorpage.jsp");
    rd.forward(req, res);
  }
  
  
  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
    	 String action = action = req.getParameter("action");
      if ("logout".equalsIgnoreCase(action)) {
      HttpSession session=req.getSession(true);
        session.invalidate();
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
        rd.forward(req, res);
    } }
  
}



	