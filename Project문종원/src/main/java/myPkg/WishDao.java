package myPkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class WishDao {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String dbid = "jspid";
	String dbpw = "jsppw";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	private static WishDao wdao;
	
	public static WishDao getInstance() {
		if(wdao == null) {
			wdao = new WishDao();
		}
		return wdao;
	}
	private WishDao() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<WishBean> getWish(int memno) {
		ArrayList<WishBean> wlist = new ArrayList<WishBean>();
		String sql = "select * from wish where memno = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memno);
			rs = ps.executeQuery();
			while(rs.next()) {
				WishBean wb = new WishBean();
				wb.setMemno(memno);
				wb.setBrand(rs.getString("brand"));
				wb.setModel(rs.getString("model"));
				wlist.add(wb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return wlist;
	}
	
	public int insertWish(WishBean wb) {
		String sql = "insert into wish values(?, ?, ?)";
		int cnt = -1;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, wb.getMemno());
			ps.setString(2, wb.getBrand());
			ps.setString(3, wb.getModel());
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
	
	public boolean wishContains(String brand, String model, int memno) {
		boolean result = false;
		String sql = "select * from wish where brand = ? and model = ? and memno = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			ps.setString(2, model);
			ps.setInt(3, memno);
			rs = ps.executeQuery();
			if(rs.next()) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int removeWish(WishBean wb) {
		String sql = "delete wish where brand = ? and model = ? and memno = ?";
		int cnt = -1;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wb.getBrand());
			ps.setString(2, wb.getModel());
			ps.setInt(3, wb.getMemno());
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
}
