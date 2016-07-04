package phoneBoard;

import java.sql.Date;

public class PhoneBean {
	private String code_name, phone_name, manufacturer,
					 cpu, img_location;
	private int  battery_capacity, weight, resolution;
	private float ram, display_size,  os;
	private Date release_date;
	
	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
	public String getPhone_name() {
		return phone_name;
	}
	public void setPhone_name(String phone_name) {
		this.phone_name = phone_name;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public int getResolution() {
		return resolution;
	}
	public void setResolution(int resolution) {
		this.resolution = resolution;
	}
	public float getOs() {
		return os;
	}
	public void setOs(float os) {
		this.os = os;
	}
	public String getCpu() {
		return cpu;
	}
	public void setCpu(String cpu) {
		this.cpu = cpu;
	}
	public String getImg_location() {
		return img_location;
	}
	public void setImg_location(String img_location) {
		this.img_location = img_location;
	}
	public int getBattery_capacity() {
		return battery_capacity;
	}
	public void setBattery_capacity(int battery_capacity) {
		this.battery_capacity = battery_capacity;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	public float getRam() {
		return ram;
	}
	public void setRam(float ram) {
		this.ram = ram;
	}
	public float getDisplay_size() {
		return display_size;
	}
	public void setDisplay_size(float display_size) {
		this.display_size = display_size;
	}
	public Date getRelease_date() {
		return release_date;
	}
	public void setRelease_date(Date release_date) {
		this.release_date = release_date;
	}
	

	
}
