package myPkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

public class ProductsDao {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String dbid = "jspid";
	String dbpw = "jsppw";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	private static ProductsDao pdao;
	String[] conds = {"S", "A", "B"};
	public static ProductsDao getInstance() {
		if(pdao == null) {
			pdao = new ProductsDao();
		}
		return pdao;
	}
	private ProductsDao() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public int insertProduct(MultipartRequest mr) {
		int cnt = -1;
		String sql = "insert into products(pnum, brand, model, cond, storage, pimage, pimage2, color, pdesc) "
				+ "values(pseq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)";
		String[] colors = mr.getParameterValues("color");
		String[] storage = mr.getParameterValues("storage");
		String[] network = mr.getParameterValues("network");
		String networkValue = "";
		for(int i = 0; i < network.length; i++){
			networkValue += network[i] + " ";
		}
		String[] security = mr.getParameterValues("security");
		String securityValue = "";
		for(int i = 0; i < security.length; i++){
			securityValue += security[i] + " ";
		}
		int releasePrice = Integer.parseInt(mr.getParameter("releasePrice"));
		DecimalFormat df = new DecimalFormat("###,###");
		String relPrice = df.format(releasePrice) + "원";
		String pdesc = mr.getParameter("osList") + "/" + mr.getParameter("releaseDate") + "/" + relPrice +
				"/" + mr.getParameter("screenSize") + "/" + mr.getParameter("cpuList") + "/" + mr.getParameter("ram") + "/" + networkValue
				+ "/" + securityValue;
		try {
			for(int i = 0; i < conds.length; i++) {
				for(int j = 0; j < colors.length; j++) {
					for(int k = 0; k < storage.length; k++) {
						ps = conn.prepareStatement(sql);
						ps.setString(1, mr.getParameter("brand"));
						ps.setString(2, mr.getParameter("model"));
						ps.setString(3, conds[i]);
						ps.setString(4, storage[k]);
						ps.setString(5, mr.getFilesystemName("pimage"));
						ps.setString(6, mr.getFilesystemName("pimage2"));
						ps.setString(7, colors[j]);
						ps.setString(8, pdesc);
						cnt += ps.executeUpdate();
					}
				}

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
		return cnt;
	}

	public ArrayList<ProductsBean> getAllProducts() {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select * from products";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setPnum(rs.getInt("pnum"));
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setCond(rs.getString("cond"));
				pb.setStorage(rs.getString("storage"));
				pb.setSqty(rs.getInt("sqty"));
				pb.setPrice(rs.getInt("price"));
				pb.setPoint(rs.getInt("point"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				pb.setColor(rs.getString("color"));
				pb.setPdesc(rs.getString("pdesc"));
				list.add(pb);
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
		return list;
	}

	public ArrayList<ProductsBean> getBrandModels() {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select brand, model, pimage, pimage2, min(price) as minPrice, max(price) as maxPrice from products group by brand, model, pimage, pimage2";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setMinPrice(rs.getInt("minPrice"));
				pb.setMaxPrice(rs.getInt("maxPrice"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				list.add(pb);
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
		return list;
	}
	public ArrayList<ProductsBean> getBrandModels(int startRow, int endRow) {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select brand, model, pimage, pimage2, minPrice, maxPrice from "
				+ "(select rownum as rank, brand, model, pimage, pimage2, minPrice, maxPrice from "
				+ "(select brand, model, pimage, pimage2, min(price) as minPrice, max(price) as maxPrice from products group by brand, model, pimage, pimage2)) where rank between ? and ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, startRow);
			ps.setInt(2, endRow);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setMinPrice(rs.getInt("minPrice"));
				pb.setMaxPrice(rs.getInt("maxPrice"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				list.add(pb);
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
		return list;
	}

	public ArrayList<ProductsBean> getBrandModelsByColor(String color) {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select brand, model, pimage, pimage2, min(price) as minPrice, max(price) as maxPrice from products where color = ? group by brand, model, pimage, pimage2";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, color);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setMinPrice(rs.getInt("minPrice"));
				pb.setMaxPrice(rs.getInt("maxPrice"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				list.add(pb);
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
		return list;
	}
	
	public ArrayList<ProductsBean> getBrandModelsMinPriceAsc(int startRow, int endRow) {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select brand, model, pimage, pimage2, minPrice, maxPrice from "
				+ "(select rownum as rank, brand, model, pimage, pimage2, minPrice, maxPrice from "
				+ "(select brand, model, pimage, pimage2, min(price) as minPrice, max(price) as maxPrice from products group by brand, model, pimage, pimage2 order by minPrice asc)) where rank between ? and ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, startRow);
			ps.setInt(2, endRow);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setMinPrice(rs.getInt("minPrice"));
				pb.setMaxPrice(rs.getInt("maxPrice"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				list.add(pb);
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
		return list;
	}
	
	public ArrayList<ProductsBean> getBrandModelsMaxPriceDesc(int startRow, int endRow) {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select brand, model, pimage, pimage2, minPrice, maxPrice from "
				+ "(select rownum as rank, brand, model, pimage, pimage2, minPrice, maxPrice from "
				+ "(select brand, model, pimage, pimage2, min(price) as minPrice, max(price) as maxPrice from products group by brand, model, pimage, pimage2 order by maxPrice desc)) where rank between ? and ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, startRow);
			ps.setInt(2, endRow);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setMinPrice(rs.getInt("minPrice"));
				pb.setMaxPrice(rs.getInt("maxPrice"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				list.add(pb);
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
		return list;
	}
	
	public ArrayList<ProductsBean> getBrandModelsNameAsc(int startRow, int endRow) {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select brand, model, pimage, pimage2, minPrice, maxPrice from "
				+ "(select rownum as rank, brand, model, pimage, pimage2, minPrice, maxPrice from "
				+ "(select brand, model, pimage, pimage2, min(price) as minPrice, max(price) as maxPrice from products group by brand, model, pimage, pimage2 order by model asc)) where rank between ? and ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, startRow);
			ps.setInt(2, endRow);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setMinPrice(rs.getInt("minPrice"));
				pb.setMaxPrice(rs.getInt("maxPrice"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				list.add(pb);
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
		return list;
	}
	
	public ArrayList<ProductsBean> getBrandModelsByBrand(String brand) {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select brand, model, pimage, pimage2, min(price) as minPrice, max(price) as maxPrice from products where brand = ? group by brand, model, pimage, pimage2";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setMinPrice(rs.getInt("minPrice"));
				pb.setMaxPrice(rs.getInt("maxPrice"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				list.add(pb);
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
		return list;
	}
	
	public ArrayList<ProductsBean> getRandomBrandModels() {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select brand, model, pimage, pimage2, minPrice, maxPrice from "
				+ "(select brand, model, pimage, pimage2, min(price) as minPrice, max(price) as maxPrice from products group by brand, model, pimage, pimage2 order by dbms_random.value) "
				+ "where rownum between 1 and 3";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setMinPrice(rs.getInt("minPrice"));
				pb.setMaxPrice(rs.getInt("maxPrice"));
				pb.setPimage(rs.getString("pimage"));
				list.add(pb);
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
		return list;
	}
	
	public ArrayList<ProductsBean> getBrandModelsByPdesc(String pdesc) {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select brand, model, pimage, pimage2, min(price) as minPrice, max(price) as maxPrice from products where pdesc like '%" + pdesc +
				"%' group by brand, model, pimage, pimage2";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setMinPrice(rs.getInt("minPrice"));
				pb.setMaxPrice(rs.getInt("maxPrice"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				list.add(pb);
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
		return list;
	}
	public ArrayList<ProductsBean> getBrandModelsByColorAndBrand(String color, String brand) {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select brand, model, pimage, pimage2, min(price) as minPrice, max(price) as maxPrice from products where color = ? and brand = ? group by brand, model, pimage, pimage2";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, color);
			ps.setString(2, brand);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setMinPrice(rs.getInt("minPrice"));
				pb.setMaxPrice(rs.getInt("maxPrice"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				list.add(pb);
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
		return list;
	}
	public ProductsBean getProductByPnum(String pnum) {
		String sql = "select * from products where pnum = ?";
		ProductsBean pb = new ProductsBean();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, pnum);
			rs = ps.executeQuery();
			if(rs.next()) {
				pb.setPnum(rs.getInt("pnum"));
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setCond(rs.getString("cond"));
				pb.setStorage(rs.getString("storage"));
				pb.setSqty(rs.getInt("sqty"));
				pb.setPrice(rs.getInt("price"));
				pb.setPoint(rs.getInt("point"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				pb.setColor(rs.getString("color"));
				pb.setPdesc(rs.getString("pdesc"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return pb;
	}

	public ArrayList<ProductsBean> getProdList() {
		ArrayList<ProductsBean> list = new ArrayList<ProductsBean>();
		String sql = "select model, brand, storage, cond, price, pimage, pimage2, sum(sqty) as sqty from products group by model, brand, storage, cond, price, pimage, pimage2";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductsBean pb = new ProductsBean();
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setCond(rs.getString("cond"));
				pb.setStorage(rs.getString("storage"));
				pb.setSqty(rs.getInt("sqty"));
				pb.setPrice(rs.getInt("price"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
				list.add(pb);
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
		return list;
	}


	public ArrayList<String> getModelColors(String model) { 
		ArrayList<String> list = new ArrayList<String>();
		String sql = "select distinct color from products where model = ?"; 
		try { 
			ps = conn.prepareStatement(sql); 
			ps.setString(1, model); 
			rs = ps.executeQuery();
			while(rs.next()) { 
				list.add(rs.getString("color"));
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
		} return list; 
	} 
	public ArrayList<String> getModelStorage(String model) {
		ArrayList<String> list = new ArrayList<String>(); 
		String sql = "select distinct storage from products where model = ?"; 
		try { 
			ps = conn.prepareStatement(sql); 
			ps.setString(1, model); 
			rs = ps.executeQuery();
			while(rs.next()) { 
				list.add(rs.getString("storage")); 
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
		} return list; 
	}

	public int findPnum(ProductsBean pb) {
		String sql = "select pnum from products where model = ? and brand = ? and storage = ? and cond = ? and color = ?";
		int pnum = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, pb.getModel());
			ps.setString(2, pb.getBrand());
			ps.setString(3, pb.getStorage());
			ps.setString(4, pb.getCond());
			ps.setString(5, pb.getColor());
			rs = ps.executeQuery();

			if(rs.next()) {
				pnum = rs.getInt("pnum");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pnum;
	}

	public ArrayList<String> getStorages(String brand, String model){
		String sql = "select distinct storage from products where brand = ? and model = ?";
		ArrayList<String> list = new ArrayList<String>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			ps.setString(2, model);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(rs.getString("storage"));
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
		return list;
	}

	public ArrayList<String> getColors(String brand, String model){
		String sql = "select distinct color from products where brand = ? and model = ?";
		ArrayList<String> list = new ArrayList<String>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			ps.setString(2, model);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(rs.getString("color"));
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
		return list;
	}

	public int setPrice(String[] price, ArrayList<String> list, String brand, String model) {
		int cnt = -1;
		int itemprice = 0;
		String sql = "update products set price = ? where brand = ? and model = ? and storage = ? and cond = ?";
		try {
			ps = conn.prepareStatement(sql);
			for(int i = 0; i < conds.length; i++) {
				for(int j = 0; j < price.length; j++) {
					itemprice = Integer.parseInt(price[j]);
					if(conds[i].equals("S")) {
						itemprice *= 1.2;
					} else if(conds[i].equals("B")) {
						itemprice *= 0.8;
					}
					ps.setInt(1, itemprice);
					ps.setString(2, brand);
					ps.setString(3, model);
					ps.setString(4, list.get(j));
					ps.setString(5, conds[i]);
					cnt += ps.executeUpdate();
				}
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
		if(cnt > -1) {
			updatePoints();
		}
		return cnt;
	}

	public void updatePoints() {
		String sql = "update products set point = (price * 0.05)";
		try {
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();
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

	}

	public int deleteProducts(String brand, String model) {
		String sql = "delete products where brand = ? and model = ?";
		int cnt = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			ps.setString(2, model);
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

	public int updateImage(String img, String brand, String model) {
		String sql = "update products set pimage = ? where brand = ? and model = ?";
		int cnt = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, img);
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
	public int updateImage2(String img, String brand, String model) {
		String sql = "update products set pimage2 = ? where brand = ? and model = ?";
		int cnt = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, img);
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

	public ArrayList<String> getImage(String brand, String model) {
		ArrayList<String> images = new ArrayList<String>();
		String sql = "select distinct pimage, pimage2 from products where brand = ? and model = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			ps.setString(2, model);
			rs = ps.executeQuery();
			if(rs.next()) {
				images.add(rs.getString("pimage"));
				images.add(rs.getString("pimage2"));
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
		return images;
	}

	public ProductsBean getProduct(String brand, String model, String cond, String storage, String color) {
		String sql = "select * from products where brand = ? and model = ? and cond = ? and storage = ? and color = ?";
		ProductsBean pb = new ProductsBean();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			ps.setString(2, model);
			ps.setString(3, cond);
			ps.setString(4, storage);
			ps.setString(5, color);
			rs = ps.executeQuery();
			if(rs.next()) {
				pb.setPnum(rs.getInt("pnum"));
				pb.setBrand(rs.getString("brand"));
				pb.setModel(rs.getString("model"));
				pb.setCond(rs.getString("cond"));
				pb.setStorage(rs.getString("storage"));
				pb.setColor(rs.getString("color"));
				pb.setPdesc(rs.getString("pdesc"));
				pb.setSqty(rs.getInt("sqty"));
				pb.setPrice(rs.getInt("price"));
				pb.setPoint(rs.getInt("point"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPimage2(rs.getString("pimage2"));
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
		return pb;
	}

	public int getPrice(String brand, String model, String storage, String cond) {
		String sql = "select price from products where brand = ? and model = ? and storage = ? and cond = ?";
		int price = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			ps.setString(2, model);
			ps.setString(3, storage);
			ps.setString(4, cond);
			rs = ps.executeQuery();
			if(rs.next()) {
				price = rs.getInt("price");
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
		return price;
	}

	public String getItemDesc(String brand, String model) {
		String sql = "select distinct pdesc from products where brand = ? and model = ?";
		String pdesc = "";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			ps.setString(2, model);
			rs = ps.executeQuery();
			if(rs.next()) {
				pdesc = rs.getString("pdesc");
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
		return pdesc;
	}

	public ArrayList<String> getModelsByBrand(String brand) {
		String sql = "select distinct model from products where brand = ?";
		ArrayList<String> modelList = new ArrayList<String>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, brand);
			rs = ps.executeQuery();
			while(rs.next()) {
				String model = rs.getString("model");
				modelList.add(model);
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
		return modelList;
	}

	public int updateProdInfo(String brand, String model, String pdesc) {
		String sql = "update products set pdesc = ? where brand = ? and model = ?";
		int cnt = -1;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, pdesc);
			ps.setString(2, brand);
			ps.setString(3, model);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public void addSqty(int pnum) {
		String sql = "update products set sqty = sqty + 1 where pnum = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pnum);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void subSqty(int pnum, int sqty) {
		String sql = "update products set sqty = sqty - ? where pnum = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sqty);
			ps.setInt(2, pnum);
			int cnt = ps.executeUpdate();
			System.out.println(cnt);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public int getCount() {
		String sql = "select count(*) as count from products";
		int cnt = 0;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("count");
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
}
