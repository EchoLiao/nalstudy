import java.sql.*;

public class teacher {
  
 String id;
 String name;
 String password;
 String title;
 
 public void setPassword(String s){password = s;}
 public String getPassword(){return password;}
 public void setName(String s){name=s;}
 public String getName(){return name;}
 public void setTitle(String  s){title=s;}
 public String getTitle(){return title;}
 public String  getId(){return id;}	                    
 public void setId(String id){this.id=id;} 	                     

 public ResultSet getCourse( ){
 	String sql="select course.name "+
          "from classes,course "+
           "where classes.tea_id='"+id+"' "+
          "and course.id=classes.cour_id";
	  sqlBean  sqlbean = new sqlBean();
  	  ResultSet rs = sqlbean.executeQuery(sql);
  	  return rs;
	}
	
	
	public boolean hasLogin(String id){   //检查该教师是否已经注册
  	boolean f=true;
   String sql="select id from teacher where id ='"+id+"'";
  	sqlBean db =new sqlBean();
  	try{
  	ResultSet rs=db.executeQuery(sql);
  	if(rs.next()){ f=false;}
  	else{ f=true;}
  	}catch(Exception e){ e.getMessage();}
  	return f;
  	                       }
	
	
	public void addTeacher(){
		
		String sql="insert into teacher(id,name,title,password)  "+
		           "values('"+id+"','"+name+"','"+title+"','"+password+"') ";
		 sqlBean db =new sqlBean();
		 db.executeInsert(sql);          
		                    }
		                    
	public ResultSet getAll(){
		
		String sql="select * from teacher";
		sqlBean db =new sqlBean();
		ResultSet rs = db.executeQuery(sql);
		return rs;
		}
		
    public  void update()	{
    	
    	String sql= "update teacher set name='"+name+"', "+
    	             "title='"+title+"' ,password='"+password+"' "+
    	             "where id='"+id+"' ";
    	
    	            sqlBean db =new sqlBean();
    	           db.executeInsert(sql); 
    	           
    	}
    	
    	
    public int delete(String id){
    	int num=0;
    	String sql="delete  from teacher where id ='"+id+"' ";
    	sqlBean db= new sqlBean();
    	num=db.executeDelete(sql);
    	return num;
    	}			                    
		                    
}
