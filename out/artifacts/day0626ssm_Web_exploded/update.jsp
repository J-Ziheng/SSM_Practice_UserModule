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
