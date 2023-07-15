package myPkg;

public class OrderHistoryBean {
	private int no;
	private int pnum;
	private int sqty;
	private int totalPrice;
	private String brand;
	private String model;
	private String color;
	private String storage;
	private String cond;
	private String buyDate;
	public int getSqty() {
		return sqty;
	}
	public void setSqty(int sqty) {
		this.sqty = sqty;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getStorage() {
		return storage;
	}
	public void setStorage(String storage) {
		this.storage = storage;
	}
	public String getCond() {
		return cond;
	}
	public void setCond(String cond) {
		this.cond = cond;
	}
	public String getBuyDate() {
		return buyDate;
	}
	public void setBuyDate(String buyDate) {
		this.buyDate = buyDate;
	}
}
