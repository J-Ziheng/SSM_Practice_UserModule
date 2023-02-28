package com.practice.controller;

import com.github.pagehelper.PageInfo;
import com.practice.domain.User;
import com.practice.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	@RequestMapping("/add")
	public String add(User user){
		userService.add(user);
		return "redirect:/user/list";
	}
	@RequestMapping("/update")
	public String update(User user){
		userService.update(user);
		return "redirect:/user/list";
	}
	@RequestMapping("/del/{id}")
	public String del(@PathVariable("id") Integer id){
		userService.del(id);
		return "redirect:/user/list";
	}
	@RequestMapping("/list")
	public String list(@RequestParam(defaultValue = "") String username, @RequestParam(defaultValue = "1") Integer curPage,
					   @RequestParam(defaultValue = "2") Integer pageSize, Model model){
		PageInfo<User> pageInfo=userService.list(username,curPage,pageSize);
		model.addAttribute("page", pageInfo);
		model.addAttribute("username", username);
		return "list";
	}
	@RequestMapping("findById/{id}")
	public String findById(@PathVariable("id") Integer id,Model model){
		User user=userService.findById(id);
		model.addAttribute("user", user);
		return "update";
	}
}
