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
