<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Error | Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/error-pages.css?v=20260423-1">
</head>
<body>
    <main class="error-shell">
        <section class="error-card">
            <p class="error-kicker">Shringar</p>
            <p class="error-code">500</p>
            <h1><c:out value="${empty friendlyErrorTitle ? 'Something went wrong on our side.' : friendlyErrorTitle}"/></h1>
            <p class="error-copy">
                <c:out value="${empty friendlyErrorMessage ? 'Please try again shortly. If the issue continues, contact the salon team.' : friendlyErrorMessage}"/>
            </p>
            <c:if test="${not empty failedPath}">
                <p class="error-path">Request: <c:out value="${failedPath}"/></p>
            </c:if>
            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/">Back Home</a>
                <a href="${pageContext.request.contextPath}/search">Search Services</a>
                <a href="${pageContext.request.contextPath}/ContactUs">Contact Us</a>
            </div>
        </section>
    </main>
</body>
</html>
