<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login - Shringar Beauty Salon</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=Jost:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css?v=20260413-plain">
</head>
<body class="login-body">

    <div class="login-card">

        <div class="login-logo-wrap">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Logo" class="login-logo">
        </div>

        <div class="gold-rule">
            <span></span>
            <span class="diamond-mark"></span>
            <span></span>
        </div>

        <h2 class="login-title">User Login</h2>

        <c:if test="${not empty message}">
            <div style="margin: 0 0 18px; padding: 12px 14px; border-radius: 10px; background: #f4efe7; color: #6b4c3b; text-align: center;">
                <c:out value="${message}"/>
            </div>
        </c:if>
        <c:if test="${not empty errors or not empty error}">
            <div style="margin: 0 0 18px; padding: 12px 14px; border-radius: 10px; background: #fff2f0; color: #9a4b43;">
                <c:choose>
                    <c:when test="${not empty errors}">
                        <c:forEach var="e" items="${errors}">
                            <div><c:out value="${e}"/></div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div><c:out value="${error}"/></div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <form class="login-form" action="${pageContext.request.contextPath}/login" method="post">
            <div class="login-input-group">
                <span class="login-input-label">Email</span>
                <input type="email" name="email" placeholder="Email Address" value="${typedEmail}" required autocomplete="username">
            </div>
            <div class="login-input-group">
                <span class="login-input-label">Password</span>
                <input type="password" name="password" placeholder="Password" required autocomplete="current-password">
            </div>
            <button type="submit" class="login-btn">Login</button>
        </form>

        <p class="login-links">
            New here? <a href="${pageContext.request.contextPath}/register">Create an account</a>
        </p>
        <p class="login-links login-links--nav">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <span>|</span>
            <a href="${pageContext.request.contextPath}/aboutus">About Us</a>
            <span>|</span>
            <a href="${pageContext.request.contextPath}/pages/services">Services</a>
            <span>|</span>
            <a href="${pageContext.request.contextPath}/pages/Gallery">Gallery</a>
            <span>|</span>
            <a href="${pageContext.request.contextPath}/ContactUs">Contact</a>
            <span>|</span>
            <a href="${pageContext.request.contextPath}/search">Search</a>
        </p>

    </div>

</body>
</html>
