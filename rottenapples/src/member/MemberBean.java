package member;

public class MemberBean {
	
	private String email, password, nick_name, hash;
	private int level;
	private java.sql.Timestamp regi_date;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNick_name() {
		return nick_name;
	}
	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public java.sql.Timestamp getRegi_date() {
		return regi_date;
	}
	public void setRegi_date(java.sql.Timestamp regi_date) {
		this.regi_date = regi_date;
	}	
	
	public String getHash(){
		return hash;
	}
	public void setHash(String hash){
		this.hash = hash;
	}
	
	
}
	
	