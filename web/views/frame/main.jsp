<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>爱尚美拉</title>
</head>
<frameset rows="98,*,8" frameborder="no" border="0" framespacing="0">
    <frame src="${rootPath}/frame/top.do" name="topFrame" scrolling="No" noresize="noresize" id="topFrame"/>
    <frameset cols="175,*" frameborder="no" border="0" framespacing="0">
        <frame src="${rootPath}/frame/left.do" name="leftFrame" id="leftFrame"/>
        <frame src="${rootPath}/frame/tab.do" name="rightFrame" id="rightFrame"/>
    </frameset>
    <frame src="${rootPath}/frame/down.do" name="bottomFrame" scrolling="No" noresize="noresize" id="bottomFrame"/>
</frameset>
</html>


