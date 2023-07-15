package myPkg;

public class OrderBean {
	private int orderNo;
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	private int memNo;
	private int pnum;
	private int qty;
	private String sellDate;
	private int totalPrice;
	private int pointUsed;
	private int pointRcvd;
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public String getSellDate() {
		return sellDate;
	}
	public void setSellDate(String sellDate) {
		this.sellDate = sellDate;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public int getPointUsed() {
		return pointUsed;
	}
	public void setPointUsed(int pointUsed) {
		this.pointUsed = pointUsed;
	}
	public int getPointRcvd() {
		return pointRcvd;
	}
	public void setPointRcvd(int pointRcvd) {
		this.pointRcvd = pointRcvd;
	}
	
}
