package myPkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.oreilly.servlet.MultipartRequest;

public class RequestDao {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String dbid = "jspid";
	String dbpw = "jsppw";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	private static RequestDao rdao;
	
	String[] conds = {"S", "A", "B"};
	
	public static RequestDao getInstance() {
		if(rdao == null) {
			rdao = new RequestDao();
		}
		return rdao;
	}
	private RequestDao() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int insertRequest(MultipartRequest mr, int pnum, int memno) {
		int cnt = -1;
		String sql = "insert into request values(reqseq.nextval, ?, ?, ?, ?, ?, ?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memno);
			ps.setInt(2, pnum);
			ps.setString(3, mr.getFilesystemName("fimage"));
			ps.setString(4, mr.getFilesystemName("bimage"));
			ps.setString(5, "미결정");
			ps.setString(6, mr.getParameter("sellPrice"));
			cnt = ps.executeUpdate(); 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public ArrayList<RequestBean> getRequests(int memno) {
		ArrayList<RequestBean> rlist = new ArrayList<RequestBean>();
		String sql = "select * from request where memno = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memno);
			rs = ps.executeQuery();
			while(rs.next()) {
				RequestBean rb = new RequestBean();
				rb.setReqno(rs.getInt("reqno"));
				rb.setMemno(rs.getInt("memno"));
				rb.setPnum(rs.getInt("pnum"));
				rb.setFimage(rs.getString("fimage"));
				rb.setBimage(rs.getString("bimage"));
				rb.setApprove(rs.getString("approve"));
				rb.setSellPrice(rs.getInt("sellPrice"));
				rlist.add(rb);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rlist;
	}
	
	public ArrayList<RequestBean> getAllRequests() {
		ArrayList<RequestBean> rlist = new ArrayList<RequestBean>();
		String sql = "select * from request";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				RequestBean rb = new RequestBean();
				rb.setReqno(rs.getInt("reqno"));
				rb.setMemno(rs.getInt("memno"));
				rb.setPnum(rs.getInt("pnum"));
				rb.setFimage(rs.getString("fimage"));
				rb.setBimage(rs.getString("bimage"));
				rb.setApprove(rs.getString("approve"));
				rb.setSellPrice(rs.getInt("sellPrice"));
				rlist.add(rb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rlist;
	}
	
	public int deleteRequest(int reqno) {
		int cnt = -1;
		String sql = "delete request where reqno = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, reqno);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public ArrayList<RequestBean> getUnapprovedRequests(){
		ArrayList<RequestBean> rlist = new ArrayList<RequestBean>();
		String sql = "select * from request where approve = '미결정'";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				RequestBean rb = new RequestBean();
				rb.setReqno(rs.getInt("reqno"));
				rb.setMemno(rs.getInt("memno"));
				rb.setPnum(rs.getInt("pnum"));
				rb.setFimage(rs.getString("fimage"));
				rb.setBimage(rs.getString("bimage"));
				rb.setApprove(rs.getString("approve"));
				rb.setSellPrice(rs.getInt("sellPrice"));
				rlist.add(rb);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rlist;
	}
	
	public ArrayList<RequestBean> getFinishedRequests(){
		ArrayList<RequestBean> rlist = new ArrayList<RequestBean>();
		String sql = "select * from request where not approve = '미결정'";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				RequestBean rb = new RequestBean();
				rb.setReqno(rs.getInt("reqno"));
				rb.setMemno(rs.getInt("memno"));
				rb.setPnum(rs.getInt("pnum"));
				rb.setFimage(rs.getString("fimage"));
				rb.setBimage(rs.getString("bimage"));
				rb.setApprove(rs.getString("approve"));
				rb.setSellPrice(rs.getInt("sellPrice"));
				rlist.add(rb);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rlist;
	}
	
	public RequestBean getRequestByNo(int reqno) {
		String sql = "select * from request where reqno = ?";
		RequestBean rb = new RequestBean();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, reqno);
			rs = ps.executeQuery();
			if(rs.next()) {
				rb.setReqno(rs.getInt("reqno"));
				rb.setMemno(rs.getInt("memno"));
				rb.setPnum(rs.getInt("pnum"));
				rb.setFimage(rs.getString("fimage"));
				rb.setBimage(rs.getString("bimage"));
				rb.setApprove(rs.getString("approve"));
				rb.setSellPrice(rs.getInt("sellPrice"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rb;
	}
	
	public int updateRequest(int reqno, String decision) {
		String sql = "update request set approve = ? where reqno = ?";
		int cnt = -1;
		try {
			ps = conn.prepareStatement(sql);
			if(decision.equals("y")) {
				ps.setString(1, "판매 가능/입금 처리");
			} else if (decision.equals("n")) {
				ps.setString(1, "판매 불가능");
			}
			ps.setInt(2, reqno);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int getRequestCount() {
		String sql = "select count(*) as reqCount from request";
		int count = 0;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("reqCount");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	}
}
