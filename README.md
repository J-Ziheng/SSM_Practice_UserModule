# SSM_Practice_UserModule
>基于SSM框架整合的用户管理模块

## 一、开发说明
>基于SSM框架整合的用户管理模块，利用Spring框架技术连接数据库实现用户数据的增删改查。

**开发者：**
&emsp;靳子恒 信息工程系计算机科学与技术专业

**开发技术：** 
&emsp;SSM框架 + MySQL

**开发工具：**
&emsp;IDEA2022 + Navicat + Tomcat8.5

## 二、三大框架整合
### 1.Spring框架
- 能整合各种框架
- Spring充当父容器
- ContextLoaderListener启动Spring容器,实例化Spring容器,管理bean(Service,Mapper,数据源,SqlSession,MapperScanConfiguror,Transaction),能管业务层和数据访问层

### 2.SpringMVC框架
- SpringMVC是子容器
- 实例化SpringMVC容器(是Spring容器的子容器,子容器的bean可以访问父容器的bean),管理  bean(controller,视图解析器,CommonsMultipartResolver)
- 配置扫描基本包:com.practice.controller,管理控制层,视图层

### 3.Mybatis
- mapper-dao数据持久层,pojo-数据库实体类,配置文件 ,映射文件

### 4.父子容器的关系
- 父容器是Spring容器
- 子容器SpringMVC容器
- 子容器的bean可以访问父容器的bean


## 三、整合配置文件

### 1.创建Maven工程，Pom.xml添加依赖
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.practice</groupId>
    <artifactId>day0626ssm</artifactId>
    <version>1.0-SNAPSHOT</version>
    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
            <version>5.2.9.RELEASE</version>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-tx</artifactId>
            <version>5.2.9.RELEASE</version>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-orm</artifactId>
            <version>5.2.9.RELEASE</version>
        </dependency>

```

### 2.创建配置web.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    <!--父容器-->
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:applicationContext.xml</param-value>
    </context-param>
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>
    <!--编码过滤器-->
    <filter>
        <filter-name>EncodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
    </filter>
    <filter-mapping>
        <filter-name>EncodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
    <!--子容器-->
    <servlet>
        <servlet-name>springmvc</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:springmvc.xml</param-value>
        </init-param>
    </servlet>
    <servlet-mapping>
        <servlet-name>springmvc</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
</web-app>

```

### 3.配置applicationContext.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:tx="http://www.springframework.org/schema/tx"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd
       http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd
       http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd
 ">
    <context:component-scan base-package="com.tjetc.service"></context:component-scan>
    <!--数据源:DruidDataSource数据库连接池-->
    <bean id="dataSource" class="com.alibaba.druid.pool.DruidDataSource">
        <property name="driverClassName" value="com.mysql.cj.jdbc.Driver"></property>
        <property name="url" value="jdbc:mysql:///a?serverTimezone=GMT%2B8"></property>
        <property name="username" value="root"></property>
        <!--password公开注意修改-->
        <property name="password" value="123456"></property>
    </bean>
    <!--Sql会话-->
    <bean id="sqlSession" class="org.mybatis.spring.SqlSessionFactoryBean">
        <property name="configLocation" value="classpath:mybatis.xml"></property>
        <property name="dataSource" ref="dataSource"></property>
    </bean>
    <!--扫描mapper接口-->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <property name="sqlSessionFactoryBeanName" value="sqlSession"></property>
        <property name="basePackage" value="com.tjetc.dao"></property>
    </bean>
    <!--事务管理器-->
    <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <property name="dataSource" ref="dataSource"></property>
    </bean>
    <!--配置事务增强-->
    <tx:advice id="txAdvice" transaction-manager="transactionManager">

        <tx:attributes>
            <tx:method name="add*" propagation="REQUIRED"/>
            <tx:method name="update*" propagation="REQUIRED"/>
            <tx:method name="del*" propagation="REQUIRED"/>
            <tx:method name="*" read-only="true"/>
        </tx:attributes>
    </tx:advice>
    <!--Aop:config-->
    <aop:config>
        <aop:pointcut id="mycut" expression="execution(* com.tjetc.service..*.*(..))"></aop:pointcut>
        <aop:advisor advice-ref="txAdvice" pointcut-ref="mycut"></aop:advisor>
    </aop:config>
</beans>

```

### 4.配置springmvc.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd
       http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd
       http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc.xsd
       http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd ">
    <context:component-scan base-package="com.tjetc.controller"></context:component-scan>
    <mvc:annotation-driven>
    </mvc:annotation-driven>
    <mvc:default-servlet-handler/>
    <bean id="viewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="viewClass" value="org.springframework.web.servlet.view.JstlView"></property>
        <property name="prefix" value="/"></property>
        <property name="suffix" value=".jsp"></property>
    </bean>
</beans>

```

### 5.配置mybatis.xml
```xml
 <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <settings>
        <setting name="logImpl" value="STDOUT_LOGGING"/>
    </settings>
    <typeAliases>
        <package name="com.practice.domain"/>
    </typeAliases>
    <plugins>
        <plugin interceptor="com.github.pagehelper.PageInterceptor"></plugin>
    </plugins>
</configuration>

```

---

## 四、数据持久层 + 服务层 + 控制层 + 视图层

### 1.创建数据库表
``` mysql
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
)

```
### 2.持久层 Data Acess Object

>pojo,mapper和mapper映射文件

#### 2.1 pojo 数据库实体类(domain)
```java
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

```
#### 2.2  数据库接口 mapper映射

> 对数据库持久化操作，负责跟数据库打交道

```java
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

#### 2.3 mapper文件 UserMapper.xml

> mapper文件配置SQL语句

```xml
<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="com.practice.dao.UserMapper">
    
    <insert id="add" parameterType="User">
        insert into user (username,password,name,phone,addr)
        values (#{username},#{password},#{name },#{phone},#{addr})
    </insert>
    
    <select id="list" parameterType="string" resultType="com.practice.domain.User">
        select * from user where  username like concat('%',#{username},'%')
    </select>
    <select id="findById" parameterType="int" resultType="User">
        select *
        from user where id=#{id}
    </select>
    
    <update id="update" parameterType="User">
        update user
        set  username=#{username},password=#{password} ,name=#{name },phone=#{phone},addr=#{addr}
        where id=#{id}
    </update>
    
    <delete id="del" parameterType="int">
        delete from user where id=#{id}
    </delete>
</mapper>
```
### 3. Service业务层

> 负责模块的逻辑应用设计
>- 先设计接口然后再设计实类，然后再在Spring的配置文件中配置其实现的关联。（业务逻辑层的实现具体要调用到自己已经定义好的Dao的接口上）这样就可以在应用中调用Service接口来进行业务处理。
>- 建立好Dao之后再建立service层，service层又要在controller层之下，因为既要调用Dao层的接口又要提供接口给controller层。每个模型都有一个service接口，每个接口分别封装各自的业务处理的方法。

#### 3.1 接口 UserService
```java
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

```
#### 3.2 实现类 UserServiceImpl
```java
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
```

### 4. Controller(Handler) 控制(表现)层 

>负责具体的业务模块流程的控制
>- 配置在Spring的配置文件里面进行
>- 调用Service层提供的接口来控制业务流程
>- 业务流程的不同会有不同的控制器(在具体的开发中可以将流程进行抽象归纳，设计出可以重复利用的子单元流程模块)

#### 4.1 UserController
```java
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

```

### 5. View 视图层

>与控制层紧密结合，负责前台jsp页面表示

#### 5.1 add.jsp

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <base href="${pageContext.request.contextPath}/"/>
</head>
<body>
<form action="user/add" method="post">
    用户名: <input type="text" name="username"> <br>
    密码: <input type="password" name="password"> <br>
    姓名：<input type="text" name="name"> <br>
    电话：<input type="number" name="phone"> <br>
    地址：<input type="text" name="addr"> <br>
    <input type="submit" value="提交"> <br>
</form>
</body>
</html>

```

#### 5.2 list.jsp (涵盖delete)
```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <title>Title</title>
    <script>
        function fenye(curPage) {
            location.href="user/list?curPage="+curPage+"&username="+document.getElementById("username").value;
        }
        function update(id) {
            location.href="user/findById/"+id;
        }
        function del(id) {
            if (confirm("你确认删除吗?")){
                location.href="user/del/"+id;
            }
        }
    </script>
</head>
<body>
<div>
    用户名:<input type="text" id="username" value="${username}"/> <button onclick="fenye(1)">查询</button>
</div>
<table>
    <tr>
        <th>序号</th>
        <th>用户名</th>
        <th>密码</th>
        <th>姓名</th>
        <th>电话</th>
        <th>地址</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${page.list}" var="u">
        <tr>
            <td>${u.id}</td>
            <td>${u.username}</td>
            <td>${u.password}</td>
            <td>${u.name}</td>
            <td>${u.phone}</td>
            <td>${u.addr}</td>
            <td>
                <button onclick="update(${u.id})">修改</button>
                <button onclick="del(${u.id})">删除</button>
            </td>
        </tr>
    </c:forEach>
    <tr>
        <td colspan="10">
            <button onclick="fenye(1)">首页</button>
            <button onclick="fenye(${page.prePage})">上一页</button>
            <button onclick="fenye(${page.nextPage})">下一页</button>
            <button onclick="fenye(${page.pages})">尾页</button>
        </td>
    </tr>
</table>
</body>
</html>

```
#### 5.3 update.jsp
```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <base href="${pageContext.request.contextPath}/"/>
</head>
<body>
<form action="user/update" method="post">
    <input type="hidden" name="id" value="${user.id}">
    用户名: <input type="text" name="username" value="${user.username}"> <br>
    密码: <input type="password" name="password" value="${user.password}"> <br>
    姓名：<input type="text" name="name" value="${user.name}"> <br>
    电话：<input type="number" name="phone" value="${user.phone}"> <br>
    地址：<input type="text" name="addr" value="${user.addr}"> <br>
    <input type="submit" value="提交"> <br>
</form>
</body>
</html>

```
---

### 五、总结与心得

- 总结

>spring是轻量级的开源框架，用于实现业务的对象。<br>
>
>springMVC负责转发请求和视图。<br>
>
>mybatis是对jdbc的封装，是一个基于Java的持久层框架，负责数据库的操作。MyBatis使用简单的XML或注解用于配置和原始映射，将接口和 Java 的POJOs（Plain Old Java Objects，普通的 Java对象）映射成数据库中的记录。<br>


>DAO层，Service层这两个层都可以单独开发，互相的耦合度很低，完全可以独立进行，这样的一种模式在开发大项目的过程中尤其有优势。<br>
>
>Controller，View层因为耦合度比较高，因而要结合在一起开发，但是也可以看作一个整体独立于前两个层进行开发。<br>
>
>这样，在层与层之前只需要知道接口的定义，调用接口即可完成所需要的逻辑单元应用，一切更显得清晰。<br>

- 心得

>开发实践让我对ssm框架有了整体的了解。<br>
>
>整体框架的技术运用更建立在逻辑分析与设计的基础之上。<br>
>
>后端技术的深入学习更觉任重道远，系统分析与设计更不能忽视。<br>





