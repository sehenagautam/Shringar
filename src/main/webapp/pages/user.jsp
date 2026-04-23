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

        <div class="login-form">
            <div class="login-input-group">
                <span class="login-input-label">Phone</span>
                <input type="text" name="mobile" placeholder="Mobile Number">
            </div>
            <div class="login-input-group">
                <span class="login-input-label">Pass</span>
                <input type="password" name="password" placeholder="Password*">
            </div>
            <button type="button" class="login-btn">Login</button>
        </div>

        <p class="login-links">
            New here? <a href="${pageContext.request.contextPath}/pages/register">Create an account</a>
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
            <a href="${pageContext.request.contextPath}/pages/appointment">Appointment</a>
        </p>

    </div>

</body>
</html>
