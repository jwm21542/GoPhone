package myPkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class BoardDao {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String dbid = "jspid";
	String dbpw = "jsppw";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	private static BoardDao bdao;
	
	public static BoardDao getInstance() {
		if(bdao == null) {
			bdao = new BoardDao();
		}
		return bdao;
	}
	private BoardDao() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int getCount() {
		int cnt = 0;
		String sql = "select count(*) from board";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("count(*)");
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
		return cnt;
	}
	public ArrayList<BoardBean> getAllBoard(int start, int end){
		String sql = "select no, title, memno, regDate, ref, re_step, re_level, content, readcount " ;		        
		sql += "from (select rownum as rank, no, title, memno, regDate, ref, re_step, re_level, content, readcount ";
		sql += "from (select no, title, memno, regDate, ref, re_step, re_level, content, readcount ";
		sql += "from board  ";
		sql += "order by ref desc, re_step asc )) ";
		sql += "where rank between ? and ? ";		;
		ArrayList<BoardBean> blist = new ArrayList<BoardBean>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);		
			ps.setInt(2, end);
			rs = ps.executeQuery();
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNo(rs.getInt("no"));
				bb.setTitle(rs.getString("title"));
				bb.setMemno(rs.getInt("memno"));
				bb.setRegDate(String.valueOf(rs.getDate("regDate")));
				bb.setRef(rs.getInt("ref"));
				bb.setRe_step(rs.getInt("re_step"));
				bb.setRe_level(rs.getInt("re_level"));
				bb.setContent(rs.getString("content"));
				bb.setReadCount(rs.getInt("readcount"));
				blist.add(bb);
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
		return blist;
	}
	
	public int writeBoard(BoardBean bb) {
		int cnt = -1;
		String sql = "insert into board(no, title, memno, ref, re_step, re_level, content, readcount) " + 
		"values(boardseq.nextval, ?, ?, boardseq.currval, ?, ?, ?, ?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bb.getTitle());
			ps.setInt(2, bb.getMemno());
			ps.setInt(3, 0);
			ps.setInt(4, 0);
			ps.setString(5, bb.getContent());
			ps.setInt(6, 0);
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
	
	public BoardBean getBoardByNo(int no) {
		BoardBean bb = new BoardBean();
		String sql = "select * from board where no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			rs = ps.executeQuery();
			if(rs.next()) {
				bb.setNo(rs.getInt("no"));
				bb.setTitle(rs.getString("title"));
				bb.setMemno(rs.getInt("memno"));
				bb.setRegDate(String.valueOf(rs.getDate("regDate")));
				bb.setRef(rs.getInt("ref"));
				bb.setRe_step(rs.getInt("re_step"));
				bb.setRe_level(rs.getInt("re_level"));
				bb.setContent(rs.getString("content"));
				bb.setReadCount(rs.getInt("readcount"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return bb;
	}
	
	public int updateArticle(BoardBean bb) {
		int cnt = -1;
		String sql = "update board set title = ?, content = ? where no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bb.getTitle());
			ps.setString(2, bb.getContent());
			ps.setInt(3, bb.getNo());
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
	
	public int deleteArticle(int no) {
		int cnt = -1;
		String sql = "delete board where no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
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
	
	public int updateReadCount(int no) {
		String sql = "update board set readcount = readcount + 0.5 where no = ?";
		int cnt = -1;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	public int replyArticle(BoardBean bb) {
		int re_step, re_level, cnt = 0;
		String sql = "update board set re_step = re_step + 0.5 where ref = ? and re_step > ?";
		String sql2 = "insert into board(no, title, memno, ref, re_step, re_level, content, readcount) "
				+ "values(boardseq.nextval,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bb.getRef());
			ps.setInt(2,  bb.getRe_step());
			ps.executeUpdate();
			
			re_step = bb.getRe_step() + 1; //부모 것 + 1
			re_level = bb.getRe_level() + 1;
			
			ps = conn.prepareStatement(sql2);
			ps.setString(1, bb.getTitle());
			ps.setInt(2, bb.getMemno());
			ps.setInt(3, bb.getRef());
			ps.setInt(4, re_step); // re_step
			ps.setInt(5, re_level); // re_level
			ps.setString(6, bb.getContent());
			ps.setInt(7, 0);
			cnt = ps.executeUpdate();

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
		return cnt;
	}
}
