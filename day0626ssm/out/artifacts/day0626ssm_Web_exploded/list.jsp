<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <base href="${pageContext.request.contextPath}/"/>
</head>
<body>
<table border="1" cellspacing="0" cellpadding="5">
    <tr>
        <th>序号</th>
        <th>用户名</th>
        <th>密码</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${list}" var="u">
        <tr>
            <td>${u.id}</td>
            <td>${u.username}</td>
            <td>${u.password}</td>
            <td>
                <a href="/user/findById/${u.id}">修改</a>
                <a href="/user/del/${u.id}">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
