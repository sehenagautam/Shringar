<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Profile — Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-pages.css?v=20260425-2"/>
</head>
<body>
<%@ include file="/user/nav.jspf" %>
<div class="user-wrap">
    <h1 class="user-page-title">Your profile</h1>
    <p class="user-page-intro">Update your details, password, or profile image.</p>

    <!-- Feedback from the save attempt comes back here after the servlet validates and persists. -->
    <c:if test="${not empty message}">
        <div class="msg-ok"><c:out value="${message}"/></div>
    </c:if>
    <c:if test="${not empty errors}">
        <div class="msg-err">
            <ul>
                <c:forEach var="e" items="${errors}"><li><c:out value="${e}"/></li></c:forEach>
            </ul>
        </div>
    </c:if>

    <!-- One form handles profile details, image upload, and the optional password change. -->
    <form action="${pageContext.request.contextPath}/user/profile" method="post" enctype="multipart/form-data" class="form-card form-stack">
        <c:if test="${not empty sessionScope.user.image}">
            <div class="field">
                <label>Current profile image</label>
                <img src="${pageContext.request.contextPath}/${sessionScope.user.image}" alt="Profile image" style="width:120px;height:120px;object-fit:cover;border-radius:16px;border:1px solid #ddd;"/>
            </div>
        </c:if>
        <div class="field"><label>Full name</label><input type="text" name="name" required maxlength="120" value="${sessionScope.user.name}"/></div>
        <div class="field"><label>Email</label><input type="email" name="email" required maxlength="150" value="${sessionScope.user.email}"/></div>
        <div class="field"><label>Phone</label><input type="text" name="phone" value="${sessionScope.user.phone}" pattern="[0-9+()\\-\\s]{7,20}" title="Use 7 to 20 digits or symbols like +, -, ( ), and spaces."/></div>
        <div class="field"><label>Date of birth</label><input type="date" name="dateOfBirth" value="${sessionScope.user.dateOfBirth}"/></div>
        <div class="field"><label>Membership / level</label><input type="text" name="membershipLevel" maxlength="64" value="${sessionScope.user.membershipLevel}"/></div>
        <div class="field"><label>Member since (year)</label><input type="number" name="memberSinceYear" min="2000" max="2100" value="${sessionScope.user.memberSinceYear}"/></div>
        <div class="field"><label>Preferred services</label><textarea name="preferredServices" rows="2">${sessionScope.user.preferredServices}</textarea></div>
        <div class="field"><label>Profile image</label><input type="file" name="profileImage" accept=".jpg,.jpeg,.png,image/jpeg,image/png"/></div>
        <hr style="border:none;border-top:1px solid var(--border);margin:12px 0;"/>
        <!-- Blank password fields mean "leave my current password alone." -->
        <p class="user-page-intro">Leave blank to keep your current password.</p>
        <div class="field"><label>New password</label><input type="password" name="newPassword" minlength="8" autocomplete="new-password"/></div>
        <div class="field"><label>Confirm new password</label><input type="password" name="confirmPassword" minlength="8" autocomplete="new-password"/></div>
        <button type="submit" class="btn btn-primary btn-block">Save</button>
    </form>
</div>
</body>
</html>
