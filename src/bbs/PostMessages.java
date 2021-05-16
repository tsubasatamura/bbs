package bbs;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.InitialContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 * Servlet implementation class PostMessages
 */
@WebServlet("/PostMessages")
public class PostMessages extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostMessages() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("error.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String reqTitle=request.getParameter("title");
		String reqName=request.getParameter("name");
		String reqMessages=request.getParameter("messages");
		if(reqMessages!=null){
		reqMessages=reqMessages.replace("<", "&lt;");
		reqMessages=reqMessages.replace(">", "&gt;");
		reqMessages=reqMessages.replace("\"", "&quot;");
		}
		String reqPass=request.getParameter("pass");
		reqPass=reqPass.replace("\"", "&quot;");

		int num=0;
		if(request.getParameter("num")!=null){
			num=Integer.parseInt(request.getParameter("num"));
		}
		int mode=Integer.parseInt(request.getParameter("mode"));

		if(reqMessages!=null){
			reqMessages=reqMessages.replace(System.lineSeparator(), "<br/>");
		}

		InitialContext ic=null;
		DataSource ds=null;
		Connection con=null;
		PreparedStatement pst=null;
		String sql=null;

		switch(mode){
		  case 1:
			  try{
				  	ic=new InitialContext();
					ds=(DataSource)ic.lookup("java:comp/env/mysql");
					con=ds.getConnection();
					reqTitle=reqTitle.replace("<", "&lt;");
					reqTitle=reqTitle.replace(">", "&gt;");
					reqTitle=reqTitle.replace("\"", "&quot;");
					reqName=reqName.replace("<", "&lt;");
					reqName=reqName.replace(">", "&gt;");
					reqName=reqName.replace("\"", "&quot;");

					sql="INSERT INTO bbs(bbs_name,bbs_title,bbs_text,bbs_pw) VALUES(?,?,?,?)";
					pst=con.prepareStatement(sql);
					pst.setString(1,reqName);
					pst.setString(2,reqTitle);
					pst.setString(3,reqMessages);
					pst.setString(4,reqPass);

					pst.executeUpdate();
			  }catch(Exception e){

			  }finally{
				  try{
					  pst.close();
					  con.close();
				  }catch(Exception e){

				  }
			  }
			  break;

		  case 2:
			  try{
				  	ic=new InitialContext();
					ds=(DataSource)ic.lookup("java:comp/env/mysql");
					con=ds.getConnection();

					sql="DELETE FROM bbs WHERE bbs_id=?";
					pst=con.prepareStatement(sql);
					pst.setInt(1,num);

					pst.executeUpdate();
			  }catch(Exception e){

			  }finally{
				  try{
					  pst.close();
					  con.close();
				  }catch(Exception e){

				  }
			  }
			  break;

		  case 3:
			  try{
				  	ic=new InitialContext();
					ds=(DataSource)ic.lookup("java:comp/env/mysql");
					con=ds.getConnection();
					String reqNewPass=request.getParameter("newpass");
					reqNewPass=reqNewPass.replace("\"", "&quot;");
					reqTitle=reqTitle.replace("<", "&lt;");
					reqTitle=reqTitle.replace(">", "&gt;");
					reqTitle=reqTitle.replace("\"", "&quot;");
					reqName=reqName.replace("<", "&lt;");
					reqName=reqName.replace(">", "&gt;");
					reqName=reqName.replace("\"", "&quot;");

					sql="UPDATE bbs SET bbs_name=?,bbs_title=?,bbs_text=?,bbs_pw=? WHERE bbs_id=?";
					pst=con.prepareStatement(sql);
					pst.setString(1,reqName);
					pst.setString(2,reqTitle);
					pst.setString(3,reqMessages);
					pst.setString(4,reqNewPass);
					pst.setInt(5,num);

					pst.executeUpdate();
			  }catch(Exception e){

			  }finally{
				  try{
					  pst.close();
					  con.close();
				  }catch(Exception e){

				  }
			  }
			  break;
		}

		RequestDispatcher rd=request.getRequestDispatcher("/bbs.jsp");
		rd.forward(request, response);
	}

}
