<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Create an Account — Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth-pages.css"/>
</head>
<body class="auth-reg-page">
    <aside class="auth-reg-aside">
        <div>
            <div class="auth-reg-logo-slot" title="Logo — add your image later"></div>
            <p class="auth-reg-brand">SHRINGAR</p>
            <p class="auth-reg-tagline">Experience the beauty and elegance. Join our exclusive salon today.</p>
        </div>
        <p class="auth-reg-footer-note">☺ Elevating your natural beauty</p>
    </aside>

    <div class="auth-reg-main">
        <div class="auth-reg-card">
            <h1>Create an Account</h1>
            <p class="sub">Please fill in your details to register.</p>

            <c:if test="${not empty errors}">
                <div class="auth-msg-err" style="margin-bottom:18px;">
                    <ul>
                        <c:forEach var="e" items="${errors}"><li><c:out value="${e}"/></li></c:forEach>
                    </ul>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/user/register" method="post" enctype="multipart/form-data">
                <div class="auth-reg-field">
                    <label for="name">Full name</label>
                    <input id="name" type="text" name="name" required maxlength="120" value="${param.name}"/>
                </div>
                <div class="auth-reg-field">
                    <label for="email">Email address</label>
                    <input id="email" type="email" name="email" required maxlength="150" value="${param.email}"/>
                </div>
                <div class="auth-reg-field">
                    <label for="phone">Phone number</label>
                    <input id="phone" type="text" name="phone" value="${param.phone}" pattern="[0-9+()\\-\\s]{7,20}" title="Use 7 to 20 digits or symbols like +, -, ( ), and spaces."/>
                </div>
                <div class="auth-reg-field">
                    <label for="dob">Date of birth</label>
                    <input id="dob" type="date" name="dateOfBirth" value="${param.dateOfBirth}"/>
                </div>
                <div class="auth-reg-field">
                    <label for="ml">Membership / level</label>
                    <input id="ml" type="text" name="membershipLevel" maxlength="64" value="${param.membershipLevel}"/>
                </div>
                <div class="auth-reg-field">
                    <label for="my">Member since (year)</label>
                    <input id="my" type="number" name="memberSinceYear" min="2000" max="2100" value="${param.memberSinceYear}"/>
                </div>
                <div class="auth-reg-field">
                    <label for="ps">Preferred services</label>
                    <textarea id="ps" name="preferredServices" rows="2">${param.preferredServices}</textarea>
                </div>
                <div class="auth-reg-field">
                    <label for="profileImage">Profile image (JPG/JPEG/PNG)</label>
                    <input id="profileImage" type="file" name="profileImage" required
                           accept=".jpg,.jpeg,.png,image/jpeg,image/png"/>
                    
                </div>
                <div class="auth-reg-row2">
                    <div class="auth-reg-field">
                        <label for="pw">Password (min 8)</label>
                        <input id="pw" type="password" name="password" required minlength="8" autocomplete="new-password"/>
                    </div>
                    <div class="auth-reg-field">
                        <label for="pwc">Confirm password</label>
                        <input id="pwc" type="password" name="confirmPassword" required minlength="8" autocomplete="new-password"/>
                    </div>
                </div>
                <button type="submit" class="auth-reg-submit">Register</button>
            </form>

            <p class="auth-reg-bottom">Already have an account? <a href="${pageContext.request.contextPath}/user/login">Sign in</a></p>
        </div>
    </div>
</body>
</html>
