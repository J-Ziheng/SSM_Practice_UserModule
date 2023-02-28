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
