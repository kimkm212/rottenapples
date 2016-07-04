package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	private Connection getConnection () throws Exception{
		//��񿬰� Ŀ�ؼ� Ǯ(Connection Pool)
		//��ī��ŸDBCP API
		//commons.apache.org
		
		Connection con=null;
		/*String url="jdbc:mysql://localhost:3306/jspdb";
		String dbUser="jspid";
		String dbPass="jsppass";
		
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection(url, dbUser, dbPass);*/
		
		Context init = new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/jspdb");
		con=ds.getConnection();
		return con;
	}
	
	public void insertBoard(BoardBean board){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;		
		try{
			con=getConnection();
			sql="select max(num) from board";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				board.setNum(rs.getInt(1)+1);
				board.setRe_ref(board.getNum());
			}else{
				board.setNum(1);
				board.setRe_ref(1);
			}
			
			sql="insert into board(num, re_ref, re_lev, re_seq, readcount, name, passwd, subject, content, ip, file, date) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			pstmt.setInt(2, board.getRe_ref());
			pstmt.setInt(3, board.getRe_lev());
			pstmt.setInt(4, board.getRe_seq());
			pstmt.setInt(5, board.getReadcount());
			pstmt.setString(6, board.getName());
			pstmt.setString(7, board.getPasswd());
			pstmt.setString(8, board.getSubject());
			pstmt.setString(9, board.getContent());
			pstmt.setString(10, board.getIp());
			pstmt.setString(11, board.getFile());
			pstmt.setTimestamp(12, board.getDate());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
	}
	
	public int getBoardCount(){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;
		int count = 0;
		
		try{
			con=getConnection();
			sql="select count(num) from board";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
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
	
	public List<BoardBean> getBoardList(int page, int manyView){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;
		
		List<BoardBean> arr = new ArrayList<BoardBean>();
		
		try{
			con=getConnection();
			sql="select * from board order by re_ref desc,re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, manyView*(page-1));
			pstmt.setInt(2, manyView);
			rs = pstmt.executeQuery();
			while(rs.next()){
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setReadcount(rs.getInt("readcount"));
				arr.add(bb);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return arr;
	}
	
	public int getPageCount(int manyView){
		 int pageCount = 0;
		 if(getBoardCount()%manyView==0){
	    	pageCount=getBoardCount()/manyView;
	     }else{		
	    	pageCount=(getBoardCount()/manyView)+1;
		 }
		 return pageCount;
	}
	
	public BoardBean getContentView(int num){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;
		
		BoardBean bb = new BoardBean();
		
		try{
			con=getConnection();
			sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,  num);
			rs=pstmt.executeQuery();
			while(rs.next()){
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setFile(rs.getString("file"));
				bb.setIp(rs.getString("ip"));
			}
			sql="update board set readcount=? where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getReadcount()+1);
			pstmt.setInt(2, bb.getNum());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}	
		
		return bb;
	}
	
	public int updateBoard(BoardBean bb){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;
		
		int check=0;
		
		try{
			con=getConnection();
			sql="select passwd from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			rs=pstmt.executeQuery();
			rs.next();
			String dbpass=rs.getString("passwd");
			if(bb.getPasswd().equals(dbpass)){
				sql="update board set name=?, subject=?, content=? where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, bb.getName());
				pstmt.setString(2, bb.getSubject());
				pstmt.setString(3, bb.getContent());
				pstmt.setInt(4, bb.getNum());
				pstmt.executeUpdate();
				check=1;
			}else{
				check=0;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return check;
	}
	
	public int deleteContent(int num, String passwd){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;
		
		int check=0;
		
		try{
			con=getConnection();
			sql="select passwd from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			rs.next();
			String dbpass=rs.getString("passwd");
			if(passwd.equals(dbpass)){
				sql="delete from board where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				check=1;
			}else{
				check=0;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return check;
	}
	
	public void insertReply(BoardBean bb){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int num=0;
		try {
			//1,2 ��񿬰�
			con=getConnection();
			// num���ϱ� => num�� �ִ밪 +1 
			sql="select max(num) from board";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				num=rs.getInt(1)+1;
			}else{
				num=1;
			}
			// ����� ���� ���ġ
			sql="update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bb.getRe_ref());
			pstmt.setInt(2, bb.getRe_seq());
			pstmt.executeUpdate();
			
			//3 insert re_ref �״�� re_seq,re_lev +1
			sql="insert into board(num,name,passwd,subject,content,readcount,date,re_ref,re_lev,re_seq,ip,file) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPasswd());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0); //readcount ��ȸ�� 0
			pstmt.setTimestamp(7, bb.getDate());
			pstmt.setInt(8, bb.getRe_ref()); //re_ref �׷��ȣ �״��
			pstmt.setInt(9, bb.getRe_lev()+1); //re_lev �亯�۵鿩���� +1
			pstmt.setInt(10, bb.getRe_seq()+1); //re_seq �亯�ۼ��� +1
			pstmt.setString(11, bb.getIp());
			pstmt.setString(12, bb.getFile());
			//4 ����
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
	}
}
