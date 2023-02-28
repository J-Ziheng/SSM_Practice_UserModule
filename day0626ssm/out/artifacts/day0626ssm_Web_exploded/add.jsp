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
    <input type="submit" value="提交"> <br>
</form>
</body>
</html>
