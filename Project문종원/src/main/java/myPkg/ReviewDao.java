package myPkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReviewDao {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String dbid = "jspid";
	String dbpw = "jsppw";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	private static ReviewDao rdao;
	
	public static ReviewDao getInstance() {
		if(rdao == null) {
			rdao = new ReviewDao();
		}
		return rdao;
	}
	
	private ReviewDao() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<ReviewBean> getReviewByProduct(String brand, String model){
		String sql = "select * from reviews where brand = ? and model = ?";
		ArrayList<ReviewBean> rlist = new ArrayList<ReviewBean>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			ps.setString(2, model);
			rs = ps.executeQuery();
			while(rs.next()) {
				ReviewBean rbean = new ReviewBean();
				rbean.setRevNo(rs.getInt("revNo"));
				rbean.setMemNo(rs.getInt("memNo"));
				rbean.setMemName(rs.getString("memName"));
				rbean.setBrand(rs.getString("brand"));
				rbean.setModel(rs.getString("model"));
				rbean.setRevDate(String.valueOf(rs.getDate("revDate")));
				rbean.setRevText(rs.getString("revText"));
				
				rlist.add(rbean);
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
	
	public int insertReview(ReviewBean rb) {
		int cnt = -1;
		String sql = "insert into reviews(revNo, memNo, memName, brand, model, revText) values(reviewseq.nextval, ?, ?, ?, ?, ?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, rb.getMemNo());
			ps.setString(2, rb.getMemName());
			ps.setString(3, rb.getBrand());
			ps.setString(4, rb.getModel());
			ps.setString(5, rb.getRevText());
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int deleteReview(int memNo, String brand, String model) {
		int cnt = -1;
		String sql = "delete from reviews where memNo = ? and brand = ? and model = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memNo);
			ps.setString(2, brand);
			ps.setString(3, model);
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
	
	public ArrayList<ReviewBean> getReviewByMemNo(int memNo){
		String sql = "select * from reviews where memNo = ?";
		ArrayList<ReviewBean> rlist = new ArrayList<ReviewBean>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memNo);
			rs = ps.executeQuery();
			while(rs.next()) {
				ReviewBean rbean = new ReviewBean();
				rbean.setRevNo(rs.getInt("revNo"));
				rbean.setMemNo(rs.getInt("memNo"));
				rbean.setMemName(rs.getString("memName"));
				rbean.setBrand(rs.getString("brand"));
				rbean.setModel(rs.getString("model"));
				rbean.setRevDate(String.valueOf(rs.getDate("revDate")));
				rbean.setRevText(rs.getString("revText"));
				
				rlist.add(rbean);
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
	
	public int getReviewCount() {
		String sql = "select count(*) as revCount from reviews";
		int count = 0;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("revCount");
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
	
	public int getReviewCountBrandModel(String brand, String model) {
		String sql = "select count(*) revCount from reviews where brand = ? and model = ?";
		int revCount = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			ps.setString(2, model);
			rs = ps.executeQuery();
			if(rs.next()) {
				revCount = rs.getInt("revCount");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}  finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return revCount;
	}
}
