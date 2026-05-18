<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Shringar Beauty Salon</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=Jost:wght@400;500&display=swap" rel="stylesheet">
    <style>
        html, body {
            margin: 0 !important;
            padding: 0 !important;
            height: 100% !important;
            min-height: 100vh !important;
        }

        body.register-body {
            display: flex !important;
            font-family: 'Jost', sans-serif !important;
        }

        /* Left panel */
        .register-left {
            width: 40% !important;
            min-height: 100vh !important;
            background: linear-gradient(160deg, #f5ede3 0%, #d9c4b8 100%) !important;
            display: flex !important;
            flex-direction: column !important;
            justify-content: center !important;
            padding: 60px 48px !important;
            box-sizing: border-box !important;
        }

        .register-logo-wrap {
            display: inline-flex !important;
            background: #ffffff !important;
            border: 1px solid #e0d4c8 !important;
            border-radius: 14px !important;
            padding: 14px 24px !important;
            margin-bottom: 36px !important;
            width: fit-content !important;
        }

        .register-logo {
            height: 80px !important;
            width: auto !important;
            display: block !important;
        }

        .register-brand {
            font-family: 'Cormorant Garamond', serif !important;
            font-size: 3rem !important;
            font-weight: 600 !important;
            color: #6b4c3b !important;
            letter-spacing: 4px !important;
            margin-bottom: 24px !important;
            line-height: 1 !important;
        }

        .register-tagline {
            font-size: 1.05rem !important;
            color: #8a7060 !important;
            line-height: 1.7 !important;
            max-width: 280px !important;
            margin-bottom: 48px !important;
        }

        .register-badge {
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
            color: #a08070 !important;
            font-size: 0.9rem !important;
        }

        .register-badge-mark {
            align-items: center !important;
            background: #c9a96e !important;
            border-radius: 999px !important;
            color: #ffffff !important;
            display: inline-flex !important;
            font-size: 0.72rem !important;
            font-weight: 600 !important;
            height: 24px !important;
            justify-content: center !important;
            letter-spacing: 0.08em !important;
            min-width: 52px !important;
            padding: 0 8px !important;
            text-transform: uppercase !important;
        }

        /* Right panel */
        .register-right {
            width: 60% !important;
            min-height: 100vh !important;
            background: #ffffff !important;
            display: flex !important;
            flex-direction: column !important;
            justify-content: center !important;
            padding: 60px 72px !important;
            box-sizing: border-box !important;
        }

        .register-title {
            font-family: 'Cormorant Garamond', serif !important;
            font-size: 2.4rem !important;
            color: #2c2c2c !important;
            font-weight: 600 !important;
            margin: 0 0 8px 0 !important;
        }

        .register-subtitle {
            font-size: 0.92rem !important;
            color: #7a7a7a !important;
            margin: 0 0 40px 0 !important;
        }

        .register-form {
            display: flex !important;
            flex-direction: column !important;
            gap: 20px !important;
            width: 100% !important;
        }

        .form-field {
            display: flex !important;
            flex-direction: column !important;
            gap: 8px !important;
            width: 100% !important;
        }

        .form-field label {
            font-size: 0.88rem !important;
            color: #2c2c2c !important;
            font-weight: 500 !important;
        }

        .form-field input {
            width: 100% !important;
            height: 52px !important;
            background: #f5f2f0 !important;
            border: 1.5px solid transparent !important;
            border-radius: 10px !important;
            padding: 0 18px !important;
            font-family: 'Jost', sans-serif !important;
            font-size: 0.95rem !important;
            color: #2c2c2c !important;
            outline: none !important;
            box-sizing: border-box !important;
            transition: border-color 0.2s !important;
        }

        .form-field input[type="file"] {
            height: auto !important;
            padding: 14px 18px !important;
        }

        .form-field input:focus {
            border-color: #c9a96e !important;
            background: #fff !important;
        }

        .form-field input::placeholder {
            color: #b0a8a0 !important;
        }

        .form-row {
            display: flex !important;
            gap: 20px !important;
            width: 100% !important;
        }

        .form-row .form-field {
            flex: 1 !important;
        }

        .register-btn {
            display: block !important;
            width: 100% !important;
            background: #2c2c2c !important;
            color: #ffffff !important;
            font-family: 'Cormorant Garamond', serif !important;
            font-size: 1.2rem !important;
            letter-spacing: 3px !important;
            padding: 17px !important;
            border: none !important;
            border-radius: 10px !important;
            cursor: pointer !important;
            margin-top: 8px !important;
            box-sizing: border-box !important;
            transition: background 0.2s, transform 0.15s !important;
        }

        .register-btn:hover {
            background: #c9a96e !important;
            transform: translateY(-1px) !important;
        }

        .register-signin {
            text-align: center !important;
            font-size: 0.88rem !important;
            color: #7a7a7a !important;
            margin-top: 20px !important;
        }

        .register-signin a {
            color: #c9a96e !important;
            text-decoration: none !important;
            font-weight: 500 !important;
        }

        .register-signin a:hover {
            color: #a8894d !important;
        }

        .register-alert {
            border-radius: 10px !important;
            margin-bottom: 18px !important;
            padding: 14px 16px !important;
        }

        .register-alert--error {
            background: #fff2f0 !important;
            color: #9a4b43 !important;
        }

        .register-alert ul {
            list-style: none !important;
            margin: 0 !important;
            padding: 0 !important;
        }

        .register-alert li + li {
            margin-top: 6px !important;
        }

        .register-nav-links {
            color: #8a7060 !important;
            display: flex !important;
            flex-wrap: wrap !important;
            gap: 10px !important;
            justify-content: center !important;
            line-height: 1.8 !important;
            margin-top: 14px !important;
            text-align: center !important;
        }

        .register-nav-links a {
            color: #c9a96e !important;
            font-size: 0.88rem !important;
            font-weight: 500 !important;
            text-decoration: none !important;
        }

        @media (max-width: 768px) {
            body.register-body {
                flex-direction: column !important;
            }
            .register-left, .register-right {
                width: 100% !important;
                padding: 40px 28px !important;
            }
            .register-left {
                min-height: auto !important;
            }
            .form-row {
                flex-direction: column !important;
            }
        }
    </style>
</head>
<body class="register-body">

    <!-- Left panel keeps the brand visible while the right side stays focused on the form. -->
    <div class="register-left">
        <div class="register-logo-wrap">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Logo" class="register-logo"/>
        </div>
        <div class="register-brand">SHRINGAR</div>
        <p class="register-tagline">Experience the beauty and elegance. Join our exclusive salon today.</p>
        <div class="register-badge">
            <span class="register-badge-mark">Glow</span>
            <span>Elevating your natural beauty</span>
        </div>
    </div>

    <!-- Right panel holds the actual registration flow and any validation feedback. -->
    <div class="register-right">
        <h2 class="register-title">Create an Account</h2>
        <p class="register-subtitle">Please fill in your details to register.</p>

        <!-- The servlet sends either a list of detailed validation errors or one fallback message. -->
        <c:if test="${not empty errors or not empty error}">
            <div class="register-alert register-alert--error">
                <c:choose>
                    <c:when test="${not empty errors}">
                        <ul>
                            <c:forEach var="e" items="${errors}"><li><c:out value="${e}"/></li></c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${error}"/>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- Field names line up with the user model plus a few optional extras. -->
        <form class="register-form" action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">

            <div class="form-field">
                <label>Full Name</label>
                <input type="text" name="fullName" placeholder="Enter your full name" value="${param.fullName}" required maxlength="120">
            </div>

            <div class="form-field">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="Enter your email" value="${param.email}" required maxlength="150" autocomplete="username">
            </div>

            <div class="form-field">
                <label>Phone Number</label>
                <input type="text" name="phone" placeholder="Enter your phone number" value="${param.phone}" pattern="[0-9+()\\-\\s]{7,20}" title="Use 7 to 20 digits or symbols like +, -, ( ), and spaces.">
            </div>

            <div class="form-field">
                <label>Profile Image</label>
                <input type="file" name="profileImage" accept=".jpg,.jpeg,.png,image/jpeg,image/png">
            </div>

            <div class="form-row">
                <div class="form-field">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Create password" required minlength="8" autocomplete="new-password">
                </div>
                <div class="form-field">
                    <label>Confirm Password</label>
                    <input type="password" name="confirmPassword" placeholder="Confirm password" required minlength="8" autocomplete="new-password">
                </div>
            </div>

            <button type="submit" class="register-btn">Register</button>

        </form>

        <!-- Sign-in shortcut is useful after an approved account already exists. -->
        <p class="register-signin">Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in</a></p>
        <p class="register-nav-links">
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
