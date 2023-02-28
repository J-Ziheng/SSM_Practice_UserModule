package com.practice.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.practice.dao.UserMapper;
import com.practice.domain.User;

import com.practice.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper userMapper;
	@Override
	public void add(User user) {
		userMapper.add(user);
	}

	@Override
	public PageInfo<User> list(String username, Integer curPage, Integer pageSize) {
		PageHelper.startPage(curPage, pageSize);
		List<User> list=userMapper.list(username);
		PageInfo<User> pageInfo = new PageInfo<>(list);
		return pageInfo;
	}

	@Override
	public User findById(Integer id) {
		return userMapper.findById(id);
	}

	@Override
	public void update(User user) {
		userMapper.update(user);
	}

	@Override
	public void del(Integer id) {
		userMapper.del(id);
	}
}
