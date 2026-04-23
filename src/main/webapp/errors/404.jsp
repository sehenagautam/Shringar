<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found | Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/error-pages.css?v=20260423-1">
</head>
<body>
    <main class="error-shell">
        <section class="error-card">
            <p class="error-kicker">Shringar</p>
            <p class="error-code">404</p>
            <h1>We could not find that page.</h1>
            <p class="error-copy">
                The link may be outdated, or the page may have moved into another section of the site.
            </p>
            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/">Back Home</a>
                <a href="${pageContext.request.contextPath}/pages/services">View Services</a>
                <a href="${pageContext.request.contextPath}/search">Search Services</a>
            </div>
        </section>
    </main>
</body>
</html>
