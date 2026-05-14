<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${pageContext.request.requestURI.endsWith('/pages/admin-login.jsp')}">
    <c:redirect url="/admin-login"/>
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Shringar Beauty Salon</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=Jost:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css?v=20260514-fix5">
</head>
<body class="login-body login-body--admin">

    <div class="login-card login-card--admin">
        <div class="login-logo-wrap">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Logo" class="login-logo">
        </div>

        <div class="gold-rule">
            <span></span>
            <span class="diamond-mark"></span>
            <span></span>
        </div>

        <p class="login-kicker">Dashboard Access</p>
        <h2 class="login-title">Admin Login</h2>

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

        <form class="login-form" action="${pageContext.request.contextPath}/admin-login" method="post">
            <div class="login-input-group">
                <label class="login-input-label" for="admin-email">Email</label>
                <input id="admin-email" type="email" name="email" value="${typedEmail}" required autocomplete="username">
            </div>
            <div class="login-input-group">
                <label class="login-input-label" for="admin-password">Password</label>
                <input id="admin-password" type="password" name="password" required autocomplete="current-password">
            </div>
            <button type="submit" class="login-btn">Login</button>
        </form>

        <p class="login-links">
            Use the admin email account to access the management dashboard.
        </p>
        <p class="login-links login-links--secondary">
            Not admin? <a href="${pageContext.request.contextPath}/login">Back to user login</a>
        </p>
    </div>

</body>
</html>
