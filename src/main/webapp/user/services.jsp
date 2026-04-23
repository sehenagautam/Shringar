<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Services — Shringar</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-pages.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Jost:wght@300;400;500&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body>
<%@ include file="/user/site-header.jspf" %>

<div class="user-wrap-wide">
    <div class="svc-main-hero">
        <div class="svc-main-hero-bg" style="background-image:url('${pageContext.request.contextPath}/images/about.png');"></div>
        <div class="svc-main-hero-title">SERVICES</div>
    </div>

    <div class="svc-tiles">
        <a class="svc-tile" href="${pageContext.request.contextPath}/user/services/makeup"
           style="background-image:url('${pageContext.request.contextPath}/images/makeup.png');">
            <span>Makeup</span>
        </a>

        <a class="svc-tile" href="${pageContext.request.contextPath}/user/services/hair"
           style="background-image:url('${pageContext.request.contextPath}/images/makeup2.png');">
            <span>Hair</span>
        </a>

        <a class="svc-tile" href="${pageContext.request.contextPath}/user/services/nails"
           style="background-image:url('${pageContext.request.contextPath}/images/makeup4.png');">
            <span>Nail</span>
        </a>
    </div>
</div>
<%@ include file="/user/site-footer.jspf" %>
</body>
</html>

