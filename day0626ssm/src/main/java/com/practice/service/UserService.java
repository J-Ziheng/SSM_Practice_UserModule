package com.practice.service;

import com.github.pagehelper.PageInfo;
import com.practice.domain.User;

public interface UserService {
	void add(User user);
	PageInfo<User> list(String username, Integer curPage, Integer pageSize);

//	List<User> list();

	User findById(Integer id);

	void update(User user);

	void del(Integer id);
}
