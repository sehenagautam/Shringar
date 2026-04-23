<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied | Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/error-pages.css?v=20260423-1">
</head>
<body>
    <main class="error-shell">
        <section class="error-card">
            <p class="error-kicker">Shringar</p>
            <p class="error-code">403</p>
            <h1>You do not have access to this page.</h1>
            <p class="error-copy">
                Please go back to a public page or sign in with the correct account.
            </p>
            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/">Back Home</a>
                <a href="${pageContext.request.contextPath}/login">Log In</a>
                <a href="${pageContext.request.contextPath}/ContactUs">Contact Us</a>
            </div>
        </section>
    </main>
</body>
</html>
