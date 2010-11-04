import java.sql.*;
public class student {
  private String name;
  private String password;
  private String id;
  private String jiguan;
  private String sex;
  private String dep;
  
  public void setDep(String s){dep=s;}
  public String getDep(){return dep;}
  public void setSex(String s){sex=s;}
  public String getSex(){return sex;}	                                                                    
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getPassword() {
    return password;
  }
  public void setPassword(String password) {
    this.password = password;
  }

  public String getJiguan() {
    return jiguan;
  }
  public void setJiguan(String jiguan) {
    this.jiguan = jiguan;
  }
  
  
  public boolean hasLogin(String id){   //检查该学生是否已经注册
  	boolean f=true;
   String sql="select id from student where id ='"+id+"'";
  	sqlBean db =new sqlBean();
  	try{
  	ResultSet rs=db.executeQuery(sql);
  	if(rs.next()){ f=false;}
  	else{ f=true;}
  	}catch(Exception e){ e.getMessage();}
  	return f;
  	                       }
  	                       
  public ResultSet  getStudent(){
		String sql="select * from student   ";
		sqlBean db= new sqlBean();
		ResultSet rs = db.executeQuery(sql);
		 return rs;
		                         } 
		                         
		                         
	    public void updateStudent(){
    	
      String sql="update student "+
                 " set name='"+name+"',sex='"+sex+"',department='"+dep+"',	 "+
                 "password='"+password+"',jiguan='"+jiguan+"'  "+
                 " where id='"+id+"' ";
                 sqlBean db= new sqlBean();
                 db.executeInsert(sql);
                 
    	}	    
  			                         		                                                 	                       	                       
   public void deleteStudent(){
    
    	String sql="delete  from student where id ='"+id+"' ";
    	sqlBean db= new sqlBean();
    	db.executeDelete(sql);
    	}                       
  	       
  public int deleteStudent(String id){
    	int num=0;
    	String sql="delete  from student where id ='"+id+"' ";
    	sqlBean db= new sqlBean();
    	num=db.executeDelete(sql);
    	return num;
    	}                        	                       
  public void addStudent()  {
    String sql="insert into student(name,password,id,sex,department,jiguan)  "+	
            "VALUES('"+name+"','"+password+"','"+id+"','"+sex+"','"+dep+"','"+jiguan+"')";
            sqlBean db =new sqlBean();
          
               db.executeInsert(sql);
        }
                           
                         	
}