import java.io.*;
import java.sql.ResultSet;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class StudentLoginSvlt extends HttpServlet{
	
public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
    	
    String stu_id =req.getParameter("id");
    String cour_id=req.getParameter("cour_id");
    String class_id=req.getParameter("class_id");
    String prepare=req.getParameter("prepare");
    String pw1=null;
    String pw2=null;
    String e_mail=null;
    String tel=null;
    String  action = req.getParameter("action");

    ResultSet rs=null;      

	if ("update".equalsIgnoreCase(action)) {

	 stu_id =req.getParameter("id");
     pw1=req.getParameter("password1");
     pw2=req.getParameter("password2");
     if(pw1.equals("") || pw2.equals("") || pw1==null || pw2==null)
     doError(req,res,"密码不能为空！");
     e_mail=req.getParameter("e_mail");
     tel=req.getParameter("tel");
     doUpdate(req,res,pw1,pw2,e_mail,tel,stu_id);
     res.sendRedirect("/test/student.jsp");
       }
	
			   
    if ("checkmark".equalsIgnoreCase(action)) {
     rs=getScore(stu_id)   ;
     sendResultSet(req,res,rs,"/checkmark.jsp");
   }
    
    if("enrol".equalsIgnoreCase(action)){
    	
    doEnrol(req,res,stu_id,cour_id,class_id,prepare);	
    res.sendRedirect("/test/DisplayCourse.jsp");}

    }
    
    
    public void doEnrol(HttpServletRequest req, HttpServletResponse res,
    String stu_id,String cour_id,String class_id,String prepare)
                           
                           throws ServletException, IOException {
                  	       
        int num=0;                   	 
        checkEnrol check=new checkEnrol();  
              
        if(prepare.equals("0")  ) 		
         {  num= check.enrol(class_id,stu_id);  }
        else   {
        	        	
            	if( check.hasPassPrepare(prepare))                              
               {num= check.enrol(class_id,stu_id);}
                else doError(req,res,"清先完成预修课");
                                                               
                }
        
         if(num==0){
         doError(req,res,"注册课程失败！！");
         }
                          	
                           	}
   
  	 public void doUpdate(HttpServletRequest req, HttpServletResponse res,
  	 String pw1,String pw2,String e_mail,String tel,String id)
  	 throws ServletException, IOException{
  	 	int num=0;
  	 	if(!pw1.equals(pw2))
  	 	doError(req,res,"密码不一致，请重输！");
  	 	checkEnrol check=new checkEnrol(); 
  	 	sqlBean db = new sqlBean();
        num= check.updatestu(pw1,id,e_mail,tel);
  	    if(num==0) doError(req,res,"更新失败");
  	 	}
  	 
  	 
  	                          
  public ResultSet getScore(String stu_id){
     String	sql="select enrol.score , course.name ,course.mark "+
 	         "from enrol ,course ,classes "+
		     "where stu_id='"+stu_id+"' "+
		     "and enrol.class_id=classes.id "+
			 "and classes.cour_id=course.id ";
		sqlBean db = new sqlBean();
		ResultSet rs= db.executeQuery(sql);	 
		return rs;
    	                       }  
    
      public void doError(HttpServletRequest req,
                      HttpServletResponse res,
                      String str)
                      throws ServletException, IOException {


    req.setAttribute("problem", str);
    RequestDispatcher rd = getServletContext().getRequestDispatcher("/errorpage.jsp");
    rd.forward(req, res);
  }	                       
    	                           	                                          
  public void sendResultSet(HttpServletRequest req, HttpServletResponse res,
                      java.sql.ResultSet rs, String target)
                       throws ServletException, IOException {              	
    req.setAttribute("rs", rs);
    RequestDispatcher rd = getServletContext().getRequestDispatcher(target);
    rd.forward(req, res);
  }
  
      public void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

    doGet(req, res);

  } 
  

                       
    	
    	}
    	
    	
    	