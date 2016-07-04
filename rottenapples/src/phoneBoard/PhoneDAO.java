package phoneBoard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class PhoneDAO {
	
	private Connection getConnection() throws Exception{
		Context init = new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/rottenapples");
		Connection con=ds.getConnection();
		return con;
	}
	
	public void insertPhone(PhoneBean pb){
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		
		try{
			con = getConnection();
			sql="insert into ph_info(Code_name, Phone_name, Manufacturer, display_size, resolution, os, cpu, ram,"
						+ 				" battery_capacity, weight, release_date, img_location) values(?,?,?,?,?,?,?,?,?,?,?,?)"; 
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pb.getCode_name()); 
			pstmt.setString(2, pb.getPhone_name()); 
			pstmt.setString(3, pb.getManufacturer());
			pstmt.setFloat(4, pb.getDisplay_size());
			pstmt.setInt(5, pb.getResolution());
			pstmt.setFloat(6, pb.getOs());
			pstmt.setString(7,  pb.getCpu());
			pstmt.setFloat(8, pb.getRam());
			pstmt.setInt(9, pb.getBattery_capacity());
			pstmt.setInt(10, pb.getWeight());
			pstmt.setDate(11, pb.getRelease_date());
			pstmt.setString(12, pb.getImg_location());			
			pstmt.executeUpdate();		
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
	}
	
	public PhoneBean getPhoneInfo(String code_name){
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		
		PhoneBean ph = new PhoneBean();
		
		try{
			con=getConnection();
			sql="select * from ph_info where code_name=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, code_name);
			rs=pstmt.executeQuery();
			if(rs.next()){
				ph.setCode_name(rs.getString(1));
				ph.setPhone_name(rs.getString(2));
				ph.setManufacturer(rs.getString(3));
				ph.setDisplay_size(rs.getFloat(4));
				ph.setResolution(rs.getInt(5));
				ph.setOs(rs.getInt(6));
				ph.setCpu(rs.getString(7));
				ph.setRam(rs.getFloat(8));
				ph.setBattery_capacity(rs.getInt(9));
				ph.setWeight(rs.getInt(10));
				ph.setRelease_date(rs.getDate(11));
				ph.setImg_location(rs.getString(12));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return ph;
	}
	
	public ArrayList<PhoneBean> getPhoneList(String manufacturer){
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		
		ArrayList<PhoneBean> phoneList = new ArrayList<PhoneBean>();
		
		try{
			con=getConnection();
			sql="select code_name, phone_name, img_location from ph_info where manufacturer=? order by release_date desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, manufacturer);
			rs=pstmt.executeQuery();
			while(rs.next()){
				PhoneBean pb = new PhoneBean();
				pb.setCode_name(rs.getString("code_name"));
				pb.setPhone_name(rs.getString("phone_name"));
				pb.setImg_location(rs.getString("img_location"));
				pb.setManufacturer(manufacturer);
				phoneList.add(pb);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return phoneList;
	}
	
	public ArrayList<PhoneBean> getSearch(String search){
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		
		ArrayList<PhoneBean> phoneList = new ArrayList<PhoneBean>();
		
		try{
			con=getConnection();
			sql="select code_name, phone_name, img_location, manufacturer from ph_info "
					+ "where phone_name like ? or manufacturer like ? order by release_date desc limit 5";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setString(2, "%"+search+"%");
			rs=pstmt.executeQuery();
			while(rs.next()){
				PhoneBean pb = new PhoneBean();
				pb.setCode_name(rs.getString("code_name"));
				pb.setPhone_name(rs.getString("phone_name"));
				pb.setImg_location(rs.getString("img_location"));
				pb.setManufacturer(rs.getString("manufacturer"));
				phoneList.add(pb);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return phoneList;
	}
	public int getCpuGrade(String cpu){
		Connection con = null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		int cpuGrade=0;
		try{
			con=getConnection();
			sql="select grade from cpu_grade where cpu=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cpu);
			rs=pstmt.executeQuery();
			if(rs.next()){
				cpuGrade=rs.getInt("grade");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return cpuGrade;
	}
	
	
// 폰 비교 메소드들.......................................................//
	public int compareElement(float ph1, float ph2){
		int result=0;
		
		if(ph1>ph2){
			result=1;
		}else if(ph1==ph2){
			result=0;
		}else{
			result=-1;
		}

		return result;
	}
	
	public ArrayList<Integer> comparePhone(PhoneBean ph1, PhoneBean ph2){
		
		ArrayList<Integer> reCompare = new ArrayList<Integer>();
		
		reCompare.add(compareElement(ph1.getDisplay_size(), ph2.getDisplay_size()));
		reCompare.add(compareElement(ph1.getResolution(), ph2.getResolution()));
		reCompare.add(compareElement(ph1.getOs(), ph2.getOs()));
		reCompare.add(compareElement(getCpuGrade(ph1.getCpu()),getCpuGrade(ph2.getCpu())));
		reCompare.add(compareElement(ph1.getRam(),ph2.getRam()));
		reCompare.add(compareElement(ph1.getBattery_capacity(),ph2.getBattery_capacity()));
		reCompare.add(compareElement(ph1.getWeight(),ph2.getWeight()));
		
		return reCompare;
	}
	
}
