import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class StudentSvlt extends HttpServlet{
	
public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
    	
    String stu_id =req.getParameter("id");
    int success = 0;
    String action = action = req.getParameter("action");
    student stu = null;
    String message="";
   
    if ("new".equalsIgnoreCase(action)) {
      stu = doNew(req,res);
      
      sendBean(req, res, stu, "/getStudent.jsp");
    }  
    
    if ("update".equalsIgnoreCase(action)) {
    	try{		
     	stu = doUpdate(req,res, stu_id);
     	sendBean(req,res,stu,"/getStudent.jsp");
     	   }
     	  catch(SQLException e){} 
    }
			   
    if ("delete".equalsIgnoreCase(action)) {
    	try{			
      	success = doDelete(stu_id);	
      	    }
      	    catch(SQLException e){}				
    	if (success != 1) {
    		doError(req, res, "StudentSvlt: Delete unsuccessful. Rows affected: " + success);
    	} else {
    		res.sendRedirect("http://localhost:8080/test/getStudent.jsp");
    	}
   
    }
    }
    

 public student doNew(HttpServletRequest req,HttpServletResponse res )
                           throws ServletException,IOException{
      student stu= new student();                     	
      String stu_id=req.getParameter("id");
      String name=new String(req.getParameter("name").getBytes("ISO8859_1"));
      String password= req.getParameter("password");
      String dep=new String (req.getParameter("dep").getBytes("ISO8859_1"));
      String sex = new String(req.getParameter("sex").getBytes("ISO8859_1"));
      String jiguan = new String(req.getParameter("jiguan").getBytes("ISO8859_1"));
      if(isTrue(req,res,stu_id,name,password) && hasLogin(req,res,stu_id)){
      
      stu.setId(stu_id);
      stu.setName(name);
      stu.setPassword(password);
      stu.setDep(dep);
      stu.setSex(sex);
      stu.setJiguan(jiguan);
      stu.addStudent(); }  
      return stu;                	
                           	
                           	}

 public student doUpdate(HttpServletRequest req,HttpServletResponse res , String id)
                           throws ServletException,IOException,SQLException {                      	
    student stu = new student();   
    String name=new String(req.getParameter("name").getBytes("ISO8859_1"));  
                 
    String password = req.getParameter("password");
    String dep = new String(req.getParameter("dep").getBytes("ISO8859_1"));
    String sex = new String(req.getParameter("sex").getBytes("ISO8859_1"));
    String jiguan = new String(req.getParameter("jiguan").getBytes("ISO8859_1"));
    if(isTrue(req,res,id,name,password)){
    stu.setId(id);
    stu.setName(name);
    stu.setPassword(password);
    stu.setDep(dep);
    stu.setSex(sex);
    stu.setJiguan(jiguan);
    stu.updateStudent();}
		return stu;
  }

  public int doDelete(String id) throws SQLException {
  	int num=0;
    student stu=new student();
    num=stu.deleteStudent(id);
    return num;
  }
	
public void sendBean(HttpServletRequest req, HttpServletResponse res,
                       student stu, String target)
                       throws ServletException, IOException {
    req.setAttribute("stu", stu);
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
  	String message="�Բ��𣬸�ѧ�����Ѿ���ע�����!";
  	student stu= new student();
  	f= stu.hasLogin(id);
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
   	message="����ѧ���Ų���Ϊ�գ�";
   	doError(req,res,message);	}
   
   if(name==null || name.equals(""))  {
   	f=false;
   	message="ѧ����������Ϊ�գ���������д��";
   	doError(req,res,message);	}
  	
       
   if(password==null || password.equals(""))  {
   	f=false;
   	message="���벻��Ϊ�գ���������д��";
   	doError(req,res,message);	}  

     return f;
     
  }
  
  public void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

    doGet(req, res);

  }
	
	
}