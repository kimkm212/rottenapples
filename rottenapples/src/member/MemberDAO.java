package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDAO {
	
	private Connection getConnection () throws Exception{
		Connection con=null;
		Context init = new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/rottenapples");
		con=ds.getConnection();
		return con;
	}
	
	
	public void insertMember(MemberBean mb){
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		
		try{
			con = getConnection();
			/*sql="select email from member where email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,mb.getEmail());
			rs = pstmt.executeQuery();
	
			if(rs.next()){
				
			}else{*/
				sql="insert into member(Email, password, nick_name, level, regi_date, hash) values(?,?,?,?,?,?)"; 
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, mb.getEmail()); 
				pstmt.setString(2, mb.getPassword()); 
				pstmt.setString(3, mb.getNick_name());
				pstmt.setInt(4, mb.getLevel());
				pstmt.setTimestamp(5, mb.getRegi_date());
				pstmt.setString(6, mb.getHash());
				pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
	}
	
	public int emailCheck(String email){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int check=0;
		try{
			con = getConnection();
			sql="select Email from member where Email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()){
				check= 1;
			}else{
				check= 0;
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
	
	public int nickCheck(String nick){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int check=0;
		try{
			con = getConnection();
			sql="select nick_name from member where nick_name=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			if(rs.next()){
				check= 1;
			}else{
				check= 0;
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
	
	public int userCheck(String email, String password){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		
		int check=-1;
		try{
			con = getConnection();
			sql="select Email, password, level from member where Email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getInt("level")==0){
					check=2;
				}else{
					if(password.equals(rs.getString("password"))){
						check= 1;
					}else{
						check= 0;
					}
				}
			}else{
				check= -1;
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


	public MemberBean getMember(String Email){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;
		
		MemberBean mb = null;
		
		try{
			con = getConnection();
			sql="select * from member where email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,Email);
			rs=pstmt.executeQuery();
			if(rs.next()){
				mb = new MemberBean();
				mb.setEmail(rs.getString("email"));		
				mb.setPassword(rs.getString("password"));
				mb.setNick_name(rs.getString("nick_name"));
				mb.setRegi_date(rs.getTimestamp("regi_date"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return mb;
	}
	public MemberBean getMemberByHash(String hash){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;
		
		MemberBean mb = null;
		
		try{
			con = getConnection();
			sql="select * from member where hash=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,hash);
			rs=pstmt.executeQuery();
			if(rs.next()){
				mb = new MemberBean();
				mb.setEmail(rs.getString("email"));		
				mb.setPassword(rs.getString("password"));
				mb.setNick_name(rs.getString("nick_name"));
				mb.setRegi_date(rs.getTimestamp("regi_date"));
				
				sql="update member set level=1 where hash=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, hash);
				pstmt.executeUpdate();
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return mb;
	}
	
	public int updateMember(MemberBean mb){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;
		int check = 0;
		try{
			con=getConnection();
			sql="update member set password=?, nick_name=? where email=?"; 
			pstmt=con.prepareStatement(sql); 
			pstmt.setString(1, mb.getPassword()); 
			pstmt.setString(2, mb.getNick_name());
			pstmt.setString(3, mb.getEmail());
			pstmt.executeUpdate();
			check = 1;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return check;
	}

	public int deleteMember(String email, String password){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;
		
		int check=-1;
		
		try{
			con = getConnection();
			sql="select password from member where email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()){
				String dbpass= rs.getString("password");
				if(!dbpass.equals(password)){
					check = -1;
				}else{
					sql="delete from member where email=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, email); 
					pstmt.executeUpdate();
					check = 1;
				}
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
	
	
	public int getHash(String hash){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;
		int check = 0;
		try{
			con = getConnection();
			sql="select hash from member where hash=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hash);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				check = 1;
			}else{
				check= 0;
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
}
/*
	public List<MemberBean> getList(){
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs = null;
		
		List<MemberBean> arr = new ArrayList<MemberBean>();
		
		try{
			con=getConnection();
			sql="select * from member";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				MemberBean mb = new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPasswd(rs.getString("passwd"));
				mb.setName(rs.getString("name"));
				mb.setM_date(rs.getTimestamp("m_date"));
				mb.setAge(rs.getInt("age"));
				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
				arr.add(mb);
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
	
}//�겢�옒�뒪
*/