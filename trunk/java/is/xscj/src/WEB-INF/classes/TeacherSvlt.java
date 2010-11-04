import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class TeacherSvlt extends HttpServlet{
	
public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
          	
    String tea_id =req.getParameter("id");
    int success = 0;
    String action = action = req.getParameter("action");
    teacher tea = null;
    String message="";
    
    
       if ("new".equalsIgnoreCase(action)) {
      tea = doNew(req,res);
      
      sendBean(req, res, tea, "/getteacher.jsp");
    }  
    
    if ("update".equalsIgnoreCase(action)) {
    	try{		
     	tea = doUpdate(req,res, tea_id);
     	sendBean(req,res,tea,"/getteacher.jsp");
     	   }
     	  catch(SQLException e){} 
    }
			   
    if ("delete".equalsIgnoreCase(action)) {
    	try{			
      	success = doDelete(tea_id);	
      	    }
      	    catch(SQLException e){}				
    	if (success != 1) {
    		doError(req, res, "TeacherSvlt: Delete unsuccessful. Rows affected: " + success);
    	} else {
    		res.sendRedirect("http://localhost:8080/test/getteacher.jsp");
    	}  
    }}
    
    
     public teacher doNew(HttpServletRequest req,HttpServletResponse res )
                           throws ServletException,IOException{
      teacher tea= new teacher();                     	
      String tea_id=req.getParameter("id");
      String name=new String(req.getParameter("name").getBytes("ISO8859_1"));
      String password= req.getParameter("password");
      String title=new String (req.getParameter("title").getBytes("ISO8859_1"));
      
      if(isTrue(req,res,tea_id,name,password) && hasLogin(req,res,tea_id)){
      
      tea.setId(tea_id);
      tea.setName(name);
      tea.setPassword(password);
      tea.setTitle(title);
      tea.addTeacher();
       }  
      return tea;                	
                           	
                           	}
                           	
                           	
      public teacher doUpdate(HttpServletRequest req,HttpServletResponse res , String id)
                           throws ServletException,IOException,SQLException {                      	
    teacher tea = new teacher(); 
      
    String name=new String(req.getParameter("name").getBytes("ISO8859_1"));                   
    String password = req.getParameter("password");
    String title = new String(req.getParameter("title").getBytes("ISO8859_1"));
        if(isTrue(req,res,id,name,password)){
    tea.setId(id);
    tea.setName(name);
    tea.setPassword(password);
    tea.setTitle(title);  
    tea.update();
           }
		return tea;
  }
  
    public int doDelete(String id) throws SQLException {
  	int num=0;
    teacher tea=new teacher();
    num=tea.delete(id);
    return num;
  }
  
  public void sendBean(HttpServletRequest req, HttpServletResponse res,
                       teacher tea, String target)
                       throws ServletException, IOException {
    req.setAttribute("tea", tea);
    RequestDispatcher rd = getServletContext().getRequestDispatcher(target);
    rd.forward(req, res);
  }
  
  
    public void doError(HttpServletRequest req,
                      HttpServletResponse res,
                      String str)
                      throws ServletException, IOException {
                      	
    req.setAttribute("problem", str);
    RequestDispatcher rd = getServletContext().getRequestDispatcher("/errorpage.jsp");
    rd.forward(req, res);
  }
  
                       	
     public boolean hasLogin(HttpServletRequest req, HttpServletResponse res,String id)
  throws ServletException, IOException{
  	boolean f=true;
  	String message="对不起，该教师号已经被注册过了!";
  	teacher tea= new teacher();
  	f= tea.hasLogin(id);
  	if(f==false){
  	doError(req,res,message);	
  		}
  		return f;
  	}
  	
  	
  	  public boolean isTrue(HttpServletRequest req, HttpServletResponse res,
                        String id,String name,String password)
                        throws ServletException, IOException {
   boolean f=true;                     	
   String message ="";
   if(id==null || id.equals(""))  {
   	f=false;
   	message="错误，教师号不能为空！";
   	doError(req,res,message);	}
   
   if(name==null || name.equals(""))  {
   	f=false;
   	message="教师姓名不能为空，请重新填写！";
   	doError(req,res,message);	}
  	
       
   if(password==null || password.equals(""))  {
   	f=false;
   	message="密码不能为空，请重新填写！";
   	doError(req,res,message);	}  

     return f;
     
  }
  
    public void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

    doGet(req, res);

  }
   
   
   } 	