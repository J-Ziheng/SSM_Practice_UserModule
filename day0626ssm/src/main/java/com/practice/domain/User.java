package com.practice.domain;

public class User {
	private Integer id;
	private String username;
	private String password;
	private String name;
	private String phone;
	private String addr;

	public User(Integer id, String username, String password, String name, String phone, String addr) {
		this.id = id;
		this.username = username;
		this.password = password;
		this.name = name;
		this.phone = phone;
		this.addr = addr;
	}
	public User( String username, String password, String name, String phone, String addr) {
		this.username = username;
		this.password = password;
		this.name = name;
		this.phone = phone;
		this.addr = addr;
	}

	@Override
	public String toString() {
		return "User{" +
				"id=" + id +
				", username='" + username + '\'' +
				", password='" + password + '\'' +
				", name='" + name + '\'' +
				", phone='" + phone + '\'' +
				", addr='" + addr + '\'' +
				'}';
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public User() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
