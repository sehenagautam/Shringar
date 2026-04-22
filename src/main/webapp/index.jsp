<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-pages.css"/>
</head>
<body>
<div class="user-wrap">
    <h1 class="user-page-title">Shringar</h1>
    <p class="user-page-intro">Salon booking — user portal.</p>
    <div class="stack-actions">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/user/login">Sign in</a>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/user/register">Register</a>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/user/dashboard">Dashboard (login required)</a>
    </div>
    <p class="user-page-intro" style="margin-top:24px;">
        <a href="${pageContext.request.contextPath}/aboutus.jsp">About</a>
        · <a href="${pageContext.request.contextPath}/ContactUs.jsp">Contact</a>
    </p>
</div>
</body>
</html>
