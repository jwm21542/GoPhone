package myPkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class MembersDao {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String dbid = "jspid";
	String dbpw = "jsppw";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	private static MembersDao mdao;
	String[] conds = {"S", "A", "B"};
	public static MembersDao getInstance() {
		if(mdao == null) {
			mdao = new MembersDao();
		}
		return mdao;
	}
	private MembersDao() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public MembersBean getMemberInfo(String id, String password) {
		String sql = "select * from members where userid = ? and password = ?";
		MembersBean member = null;
		try {
			ps = conn.prepareStatement(sql);

			ps.setString(1, id);
			ps.setString(2, password);

			rs = ps.executeQuery();
			if(rs.next()) {
				member = getMembersBean(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return member;
	}
	//getMemberInfo
	private MembersBean getMembersBean(ResultSet rs2) throws SQLException {

		MembersBean member = new MembersBean();
		member.setNo(rs2.getInt("no"));
		member.setName(rs2.getString("name"));
		member.setUserid(rs2.getString("userid"));
		member.setPassword(rs2.getString("password"));
		member.setBrn1(rs2.getString("brn1"));
		member.setBrn2(rs2.getString("brn2"));
		member.setBankNum(rs2.getString("bankNum"));
		member.setBankName(rs2.getString("bankName"));
		member.setEmail(rs2.getString("email"));
		member.setPhn1(rs2.getString("phn1"));
		member.setPhn2(rs2.getString("phn2"));
		member.setPhn3(rs2.getString("phn3"));
		member.setAddr1(rs2.getString("addr1"));
		member.setAddr2(rs2.getString("addr2"));
		member.setAddr3(rs2.getString("addr3"));
		member.setPostCode(rs2.getString("postCode"));
		member.setRegdate(String.valueOf(rs2.getDate("regdate")));
		member.setPoint(rs2.getInt("point"));
		return member;
	}//getMemberDTO
	
	public int insertMember(MembersBean mb) {
		int cnt = 0;
		String sql = "insert into members(no, name, userid, password, brn1, brn2, bankNum, bankName, email, phn1, phn2, phn3, addr1, addr2, addr3, postCode, point) values(memseq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getName());
			ps.setString(2, mb.getUserid());
			ps.setString(3, mb.getPassword());
			ps.setString(4, mb.getBrn1());
			ps.setString(5, mb.getBrn2());
			ps.setString(6, mb.getBankNum());
			ps.setString(7, mb.getBankName());
			ps.setString(8, mb.getEmail());
			ps.setString(9, mb.getPhn1());
			ps.setString(10, mb.getPhn2());
			ps.setString(11, mb.getPhn3());
			ps.setString(12, mb.getAddr1());
			ps.setString(13, mb.getAddr2());
			ps.setString(14, mb.getAddr3());
			ps.setString(15, mb.getPostCode());
			ps.setInt(16, mb.getPoint());
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}//insertMember
	
	public boolean searchId(String userId) {
		boolean flag = false;
		String sql = "select * from members where userid = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userId);
			rs = ps.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	} //searchId
	
	public MembersBean getMemberByNo(int no) {
		String sql = "select * from members where no = ?";
		MembersBean mb = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				mb = getMembersBean(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return mb;
	}//getMemberByNo
	
	public int updatePersonalInfo(MembersBean mb) {
		int cnt = -1;
		String sql = "update members set name = ?, email = ?, phn1 = ?, phn2 = ?, phn3 = ?, brn1 = ?, brn2 = ?, postCode = ?, addr1 = ?, addr2 = ?, addr3 = ? where no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getName());
			ps.setString(2, mb.getEmail());
			ps.setString(3, mb.getPhn1());
			ps.setString(4, mb.getPhn2());
			ps.setString(5, mb.getPhn3());
			ps.setString(6, mb.getBrn1());
			ps.setString(7, mb.getBrn2());
			ps.setString(8, mb.getPostCode());
			ps.setString(9, mb.getAddr1());
			ps.setString(10, mb.getAddr2());
			ps.setString(11, mb.getAddr3());
			ps.setInt(12, mb.getNo());
			
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
	
	public int updateBanking(int no, String bankName, String bankNum) {
		int cnt = -1;
		String sql = "update members set bankName = ?, bankNum = ? where no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bankName);
			ps.setString(2, bankNum);
			ps.setInt(3, no);
			
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
	}//updateBanking
	
	public int updatePassword(int no, String password) {
		int cnt = -1;
		String sql = "update members set password = ? where no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, password);
			ps.setInt(2, no);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	} //updatePassword
	
	public int deleteAccount(int no) {
		String sql = "delete members where no = ?";
		int cnt = -1;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public ArrayList<OrderHistoryBean> getOrderHistory(int sno){
		String sql = "select pnum, sqty, totalPrice, brand, model, color, storage, cond, buyDate from (select o.memno as no, o.pnum pnum, o.qty sqty, o.totalprice totalPrice, p.brand brand, p.model model , p.color color, p.storage storage, p.cond cond, o.sellDate buyDate from orders o inner join products p on o.pnum = p.pnum) where no = ?";
		ArrayList<OrderHistoryBean> oList = new ArrayList<OrderHistoryBean>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sno);
			rs = ps.executeQuery();
			while(rs.next()) {
				OrderHistoryBean obean = new OrderHistoryBean();
				obean.setNo(sno);
				obean.setPnum(rs.getInt("pnum"));
				obean.setBrand(rs.getString("brand"));
				obean.setSqty(rs.getInt("sqty"));
				obean.setTotalPrice(rs.getInt("totalPrice"));
				obean.setModel(rs.getString("model"));
				obean.setColor(rs.getString("color"));
				obean.setStorage(rs.getString("storage"));
				obean.setCond(rs.getString("cond"));
				obean.setBuyDate(String.valueOf(rs.getDate("buyDate")));
				oList.add(obean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return oList;
	}
	
	public ArrayList<MembersBean> getAllMembers() {
		String sql = "select * from members";
		ArrayList<MembersBean> mlist = new ArrayList<MembersBean>();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				MembersBean mb = getMembersBean(rs);
				mlist.add(mb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return mlist;
	}
	
	public int getMembersCount() {
		String sql = "select count(*) as memCount from members";
		int count = 0;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("memCount");
			}
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
		return count;
	}
	
	public String findId(String name, String email) {
		String sql = "select userid from members where name = ? and email = ?";
		String id = "";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, email);
			rs = ps.executeQuery();
			if(rs.next()) {
				id = rs.getString("userid");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return id;
	}
	public String findPw(MembersBean mb) {
		String sql = "select password from members where userid = ? and name = ? and email = ? and brn1 = ? and brn2 = ?";
		String pw = "";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getUserid());
			ps.setString(2, mb.getName());
			ps.setString(3, mb.getEmail());
			ps.setInt(4, Integer.parseInt(mb.getBrn1()));
			ps.setInt(5, Integer.parseInt(mb.getBrn2()));
			rs = ps.executeQuery();
			if(rs.next()) {
				pw = rs.getString("password");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pw;
	}
}
	