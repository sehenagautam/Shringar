<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login - Shringar Beauty Salon</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=Jost:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css?v=20260411-1430">
</head>
<body class="login-body">

    <div class="login-card">

        <div class="login-logo-wrap">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Logo" class="login-logo">
        </div>

        <div class="gold-rule">
            <span></span>
            <i class="fas fa-diamond"></i>
            <span></span>
        </div>

        <h2 class="login-title">User Login</h2>

        <div class="login-form">
            <div class="login-input-group">
                <i class="fas fa-phone"></i>
                <input type="text" name="mobile" placeholder="Mobile Number">
            </div>
            <div class="login-input-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="Password*">
            </div>
            <button type="button" class="login-btn">Login</button>
        </div>

    </div>

</body>
</html>
