<!-- NAVBAR -->
<%
    String currentPath = request.getServletPath();
    boolean isHome = "/".equals(currentPath) || "/index.jsp".equals(currentPath) || "/pages/index.jsp".equals(currentPath);
    boolean isServices = "/pages/services.jsp".equals(currentPath)
            || "/pages/hair.jsp".equals(currentPath)
            || "/pages/makeup.jsp".equals(currentPath)
            || "/pages/nail.jsp".equals(currentPath);
    boolean isGallery = "/pages/Gallery.jsp".equals(currentPath);
    boolean isAbout = "/aboutus.jsp".equals(currentPath);
    boolean isContact = "/ContactUs.jsp".equals(currentPath);
    boolean isAppointment = "/pages/appointment.jsp".equals(currentPath);
%>
<nav class="navbar">
    <div class="nav-top">
        <div class="nav-top-left">
            <span><i class="fas fa-phone"></i> +977 9820221306</span>
        </div>
        <div class="nav-brand">
            <span class="brand-name">Beauty Salon</span>
            <span class="brand-location">Kamalpokhari, Kathmandu, Nepal</span>
        </div>
        <div class="nav-top-right">
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
        </div>
    </div>
    <div class="nav-main">
        <div class="nav-logo">
            <a href="${pageContext.request.contextPath}/" aria-label="Shringar home">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Logo" class="logo-img"/>
            </a>
        </div>
        <ul class="nav-links">
            <li class="<%= isHome ? "active" : "" %>"><a href="${pageContext.request.contextPath}/">HOME</a></li>
            <li class="<%= isAbout ? "active" : "" %>"><a href="${pageContext.request.contextPath}/aboutus.jsp">ABOUT US</a></li>
            <li class="<%= isServices ? "active" : "" %>"><a href="${pageContext.request.contextPath}/pages/services.jsp">SERVICES</a></li>
            <li class="<%= isGallery ? "active" : "" %>"><a href="${pageContext.request.contextPath}/pages/Gallery.jsp">GALLERY</a></li>
            <li class="<%= isContact ? "active" : "" %>"><a href="${pageContext.request.contextPath}/ContactUs.jsp">CONTACT US</a></li>
            <li class="<%= isAppointment ? "active" : "" %>"><a href="${pageContext.request.contextPath}/pages/appointment.jsp">APPOINTMENT</a></li>
        </ul>
        <a href="${pageContext.request.contextPath}/pages/user.jsp" class="btn-login">Log in</a>
    </div>
</nav>
