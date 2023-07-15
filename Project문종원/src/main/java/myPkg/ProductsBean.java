package myPkg;

import java.util.Comparator;

public class ProductsBean {
	private int pnum;
	private String brand;
	private String model;
	private String cond;
	private String storage;
	private String pdesc;
	private int sqty;
	private int price;
	private int point;
	private String pimage;
	private String pimage2;
	private String color;
	private int minPrice;
	private int maxPrice;
	
	public int getPrice() {
		return price;
	}
	public int getMinPrice() {
		return minPrice;
	}
	public void setMinPrice(int minPrice) {
		this.minPrice = minPrice;
	}
	public int getMaxPrice() {
		return maxPrice;
	}
	public void setMaxPrice(int maxPrice) {
		this.maxPrice = maxPrice;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getPdesc() {
		return pdesc;
	}
	public void setPdesc(String pdesc) {
		this.pdesc = pdesc;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
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
	public String getCond() {
		return cond;
	}
	public void setCond(String cond) {
		this.cond = cond;
	}
	public String getStorage() {
		return storage;
	}
	public void setStorage(String storage) {
		this.storage = storage;
	}
	public int getSqty() {
		return sqty;
	}
	public void setSqty(int sqty) {
		this.sqty = sqty;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getPimage() {
		return pimage;
	}
	public void setPimage(String pimage) {
		this.pimage = pimage;
	}
	public String getPimage2() {
		return pimage2;
	}
	public void setPimage2(String pimage2) {
		this.pimage2 = pimage2;
	}
	public String toString() {
		return pnum + "/" + brand + "/" + model + "/" + cond + "/" + storage + "/" + pdesc + "/" + sqty + "/" + price + "/" + point + "/";
	}
}
