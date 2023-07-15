package myPkg;

import java.util.Vector;

public class CartBean {
	private ProductsBean pb;
	private Vector<ProductsBean> plist;
	
	public CartBean() {
		plist = new Vector<ProductsBean>();
	}
	
	public void addProduct(String brand, String model, String cond, String storage, String color, String pqty) {
		for(ProductsBean pbean : plist){
			if(pbean.getBrand().equals(brand) && pbean.getModel().equals(model) && pbean.getCond().equals(cond) && pbean.getStorage().equals(storage) && pbean.getColor().equals(color)) {
				int oldpqty = pbean.getSqty();
				pbean.setSqty(oldpqty + Integer.parseInt(pqty));
				return;
			}
		}
		ProductsDao pdao = ProductsDao.getInstance();
		pb = pdao.getProduct(brand, model, cond, storage, color);
		pb.setSqty(Integer.parseInt(pqty));
		plist.add(pb);
	}
	
	public Vector<ProductsBean> getAllProducts(){
		return plist;
	}
	
	public void cartDelete(String pnum) {
		int pNum = Integer.parseInt(pnum);
		for(ProductsBean pbean : plist) {
			if(pbean.getPnum() == pNum) {
				plist.removeElement(pbean);
				break;
			}
		}
	}
	
	public void updateCart(String pnum, String sqty) {
		int pnumber = Integer.parseInt(pnum);
		for(ProductsBean pbean : plist) {
			if(pnumber == pbean.getPnum()) {
				pbean.setSqty(Integer.parseInt(sqty));
			}
		}
	}
}


