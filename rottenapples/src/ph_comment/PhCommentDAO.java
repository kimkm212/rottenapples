package ph_comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class PhCommentDAO {

	private Connection getConnection () throws Exception{
		Context init = new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/rottenapples");
		Connection con=ds.getConnection();
		return con;
	}
	
	public void insertComment(PhCommentBean pc){
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
			
		try{
			con = getConnection();
			sql="insert into ph_comment(code_name, nick_name, content, isLike, date) values(?,?,?,?,?)";	
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pc.getCode_name());
			pstmt.setString(2, pc.getNick_name());
			pstmt.setString(3, pc.getContent());
			pstmt.setInt(4, pc.getIsLike());
			pstmt.setTimestamp(5, pc.getDate());
			pstmt.executeUpdate();		
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
	}
	
	public int getComCount(String code_name){
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs =null;
		int count = 0;
		try{
			con=getConnection();
			sql="select count(*) from ph_comment where code_name=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, code_name);
			rs=pstmt.executeQuery();
			if(rs.next()){
				count=rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return count;
	}
	
	public ArrayList<PhCommentBean> getCommentList(String code_name, int page, int count){
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs =null;
		ArrayList<PhCommentBean> commentList = new ArrayList<PhCommentBean>();
		
		try{
			con=getConnection();
			sql="select * from ph_comment where code_name=? order by num desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, code_name);
			pstmt.setInt(2, count*(page-1));
			pstmt.setInt(3, count);
			rs=pstmt.executeQuery();
			while(rs.next()){
				PhCommentBean pb = new PhCommentBean();
				pb.setNum(rs.getInt("num"));
				pb.setNick_name(rs.getString("nick_name"));
				pb.setContent(rs.getString("content"));
				pb.setIsLike(rs.getInt("isLike"));
				pb.setDate(rs.getTimestamp("date"));
				commentList.add(pb);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return commentList;
	}
	
	public void deleteComment(int num){
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		
		try{
			con=getConnection();
			sql="delete from ph_comment where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeQuery();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
	}
	
	public int getRottenApples(String code_name){
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs =null;
		int rottenApples=0;
		
		try{
			con=getConnection();
			sql="select round((select count(isLike) from ph_comment where isLike=1 and code_name=?)"
					+ "/count(isLike)*100) from ph_comment where code_name=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, code_name);
			pstmt.setString(2, code_name);
			rs=pstmt.executeQuery();
			if(rs.next()){
				rottenApples=rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return rottenApples;
	}
	
	
}
