<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Shringar Beauty Salon</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=Jost:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css?v=20260413-plain">
</head>
<body class="login-body">

    <div class="login-card">

        <!-- Brand framing for the standalone auth card. -->
        <div class="login-logo-wrap">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Logo" class="login-logo">
        </div>

        <div class="gold-rule">
            <span></span>
            <span class="diamond-mark"></span>
            <span></span>
        </div>

        <h2 class="login-title">Admin Login</h2>

        <!-- One shared area handles both redirects and validation feedback. -->
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

        <!-- typedEmail is either the last attempted value or the remembered cookie value. -->
        <form class="login-form" action="${pageContext.request.contextPath}/admin-login" method="post">
            <div class="login-input-group">
                <span class="login-input-label">Admin Email</span>
                <input type="email" name="email" placeholder="Admin Email" value="${typedEmail}" required autocomplete="username">
            </div>
            <div class="login-input-group">
                <span class="login-input-label">Password</span>
                <input type="password" name="password" placeholder="Password" required autocomplete="current-password">
            </div>
            <button type="submit" class="login-btn">Admin Login</button>
        </form>

        <!-- Keep a lightweight route back into the public site from auth pages. -->
        <p class="login-links">
            Not an admin? <a href="${pageContext.request.contextPath}/pages/user">User Login</a><br/>
            <a href="${pageContext.request.contextPath}/">Back to Home</a>
        </p>

    </div>

</body>
</html>
