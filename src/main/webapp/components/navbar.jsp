<!-- NAVBAR -->
<%
    String currentPath = request.getServletPath();
    boolean isHome = "/".equals(currentPath) || "/index.jsp".equals(currentPath) || "/pages/index.jsp".equals(currentPath);
    boolean isServices = "/pages/services".equals(currentPath)
            || "/pages/services.jsp".equals(currentPath)
            || "/pages/hair".equals(currentPath)
            || "/pages/hair.jsp".equals(currentPath)
            || "/pages/makeup".equals(currentPath)
            || "/pages/makeup.jsp".equals(currentPath)
            || "/pages/nail".equals(currentPath)
            || "/pages/nail.jsp".equals(currentPath);
    boolean isGallery = "/pages/Gallery".equals(currentPath) || "/pages/Gallery.jsp".equals(currentPath);
    boolean isAbout = "/aboutus".equals(currentPath) || "/aboutus.jsp".equals(currentPath);
    boolean isContact = "/ContactUs".equals(currentPath) || "/ContactUs.jsp".equals(currentPath);
    boolean isAppointment = "/pages/appointment".equals(currentPath)
            || "/pages/appointments".equals(currentPath)
            || "/pages/appointment.jsp".equals(currentPath);
%>
<nav class="navbar">
    <div class="nav-top">
        <div class="nav-top-left">
            <span><span class="inline-icon">Phone</span> +977 9820221306</span>
        </div>
        <div class="nav-brand">
            <span class="brand-name">Beauty Salon</span>
            <span class="brand-location">Kamalpokhari, Kathmandu, Nepal</span>
        </div>
        <div class="nav-top-right">
            <a href="#">F</a>
            <a href="#">I</a>
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
            <li class="<%= isAbout ? "active" : "" %>"><a href="${pageContext.request.contextPath}/aboutus">ABOUT US</a></li>
            <li class="<%= isServices ? "active" : "" %>"><a href="${pageContext.request.contextPath}/pages/services">SERVICES</a></li>
            <li class="<%= isGallery ? "active" : "" %>"><a href="${pageContext.request.contextPath}/pages/Gallery">GALLERY</a></li>
            <li class="<%= isContact ? "active" : "" %>"><a href="${pageContext.request.contextPath}/ContactUs">CONTACT US</a></li>
            <li class="<%= isAppointment ? "active" : "" %>"><a href="${pageContext.request.contextPath}/pages/appointment">APPOINTMENT</a></li>
        </ul>
        <a href="${pageContext.request.contextPath}/pages/user" class="btn-login">Log in</a>
    </div>
</nav>
