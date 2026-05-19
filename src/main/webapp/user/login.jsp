<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>User Login — Shringar Beauty Salon</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth-pages.css"/>
</head>
<body class="auth-login-page">
    <div class="auth-login-card">
        <div class="auth-logo-slot" title="Logo — add your image later"></div>
        <h1 class="auth-login-title">User Login</h1>

        <c:if test="${not empty message}">
            <div class="auth-msg-ok"><c:out value="${message}"/></div>
        </c:if>
        <c:if test="${not empty errors}">
            <div class="auth-msg-err">
                <ul>
                    <c:forEach var="e" items="${errors}"><li><c:out value="${e}"/></li></c:forEach>
                </ul>
            </div>
        </c:if>

        <form class="auth-login-form" action="${pageContext.request.contextPath}/login" method="post">
            <div class="auth-pill-wrap">
                <span class="auth-icon" aria-hidden="true">✉</span>
                <input type="email" name="email" placeholder="Email address" required maxlength="150" autocomplete="username"/>
            </div>
            <div class="auth-pill-wrap">
                <span class="auth-icon" aria-hidden="true">🔒</span>
                <input type="password" name="password" placeholder="Password" required minlength="8" autocomplete="current-password"/>
            </div>
            <button type="submit" class="auth-login-submit">Login</button>
        </form>

        <p class="auth-login-footer">
            <a href="${pageContext.request.contextPath}/register">Create an account</a>
            · <a href="${pageContext.request.contextPath}/">Home</a>
            <br/><br/>
            Admin? <a href="${pageContext.request.contextPath}/admin-login">Admin Login</a>
        </p>
    </div>
</body>
</html>
