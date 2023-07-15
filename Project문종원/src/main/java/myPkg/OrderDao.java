package myPkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;

public class OrderDao {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String dbid = "jspid";
	String dbpw = "jsppw";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	private static OrderDao odao;

	public static OrderDao getInstance() {
		if(odao == null) {
			odao = new OrderDao();
		}
		return odao;
	}

	private OrderDao() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public int insertOrder(int sno, Vector<ProductsBean> clist, int delivery, int points) {
		int cnt = -1;
		for(int i = 0; i < clist.size(); i++) {
			ProductsBean pb = clist.get(i);
			subSqty(pb.getPnum(), pb.getSqty());
			if(i != clist.size() - 1) {
				String sql = "insert into orders(orderNo, memNo, pnum, qty, totalPrice, pointRcvd) values(orderseq.nextval, ?, ?, ?, ?, ?)";
				try {
					ps = conn.prepareStatement(sql);
					ps.setInt(1, sno);
					ps.setInt(2, pb.getPnum());
					ps.setInt(3, pb.getSqty());
					ps.setInt(4, pb.getSqty()*pb.getPrice());
					ps.setInt(5, (int)(pb.getSqty()*pb.getPrice()*0.05));
					cnt += ps.executeUpdate();
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
			} else {
				String sql = "insert into orders(orderNo, memNo, pnum, qty, totalPrice, pointUsed, pointRcvd) values(orderseq.nextval, ?, ?, ?, ?, ?, ?)";
				try {
					ps = conn.prepareStatement(sql);
					ps.setInt(1, sno);
					ps.setInt(2, pb.getPnum());
					ps.setInt(3, pb.getSqty());
					ps.setInt(4, (pb.getSqty()*pb.getPrice()) + delivery - points);
					ps.setInt(5, points);
					ps.setInt(6, (int)(pb.getSqty()*pb.getPrice()*0.05));
					cnt += ps.executeUpdate();
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
			}
		}
		return cnt;
	}
	
	public void subSqty(int pnum, int sqty) {
		String sql = "update products set sqty = sqty - ? where pnum = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sqty);
			ps.setInt(2, pnum);
			int cnt = ps.executeUpdate();
			System.out.println(pnum);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int deductPoints(int points, int sno) {
		int cnt = -1;
		String sql = "update members set point = point - ? where no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, points);
			ps.setInt(2, sno);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int addPoints(int points, int sno) {
		int cnt = -1;
		String sql = "update members set point = point + ? where no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, points);
			ps.setInt(2, sno);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public ArrayList<OrderBean> getOrders(){
		String sql = "select * from orders";
		ArrayList<OrderBean> olist = new ArrayList<OrderBean>();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				OrderBean ob = new OrderBean();
				ob.setOrderNo(rs.getInt("orderNo"));
				ob.setMemNo(rs.getInt("memno"));
				ob.setPnum(rs.getInt("pnum"));
				ob.setPointUsed(rs.getInt("pointUsed"));
				ob.setPointRcvd(rs.getInt("pointRcvd"));
				ob.setQty(rs.getInt("qty"));
				ob.setSellDate(String.valueOf(rs.getDate("sellDate")));
				ob.setTotalPrice(rs.getInt("totalPrice"));
				olist.add(ob);
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
		return olist;
	}
	
	public int getOrderCount() {
		String sql = "select count(*) as ordCount from orders";
		int count = 0;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("ordCount");
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
	
	public int getSalesCount() {
		String sql = "select sum(totalPrice) as salesCount from orders";
		int count = 0;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("salesCount");
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
