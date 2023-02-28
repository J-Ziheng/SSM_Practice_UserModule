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
    <input type="submit" value="提交"> <br>
</form>
</body>
</html>
