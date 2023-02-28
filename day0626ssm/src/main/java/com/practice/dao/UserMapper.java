package com.practice.dao;

import com.practice.domain.User;

import java.util.List;

public interface UserMapper {

	void add(User user);

	List<User> list(String username);

	User findById(Integer id);

	void update(User user);

	void del(Integer id);
}
