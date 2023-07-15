package myPkg;

public class RequestBean {
	private int reqno;
	private int memno;
	private int pnum;
	private String fimage;
	private String bimage;
	private String approve;
	private int sellPrice;
	public int getSellPrice() {
		return sellPrice;
	}
	public void setSellPrice(int sellPrice) {
		this.sellPrice = sellPrice;
	}
	public int getReqno() {
		return reqno;
	}
	public void setReqno(int reqno) {
		this.reqno = reqno;
	}
	public int getMemno() {
		return memno;
	}
	public void setMemno(int memno) {
		this.memno = memno;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getFimage() {
		return fimage;
	}
	public void setFimage(String fimage) {
		this.fimage = fimage;
	}
	public String getBimage() {
		return bimage;
	}
	public void setBimage(String bimage) {
		this.bimage = bimage;
	}
	public String getApprove() {
		return approve;
	}
	public void setApprove(String approve) {
		this.approve = approve;
	}
}
