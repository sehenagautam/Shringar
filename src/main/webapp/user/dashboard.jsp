<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Dashboard — Shringar Beauty Salon</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600;700&family=Jost:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-user.css?v=20260425-1"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<div class="dash-layout">
    <!-- Sidebar anchors jump to sections inside the dashboard for quick scanning. -->
    <aside class="dash-side" aria-label="Sidebar">
        <nav>
            <ul>
                <li><a class="active" href="${pageContext.request.contextPath}/user/dashboard"><span class="nav-ico"><i class="fa fa-th-large"></i></span> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/"><span class="nav-ico"><i class="fa fa-home"></i></span> Home</a></li>
                <li><a href="${pageContext.request.contextPath}/user/search"><span class="nav-ico"><i class="fa fa-search"></i></span> Search</a></li>
                <li><a href="${pageContext.request.contextPath}/user/search"><span class="nav-ico"><i class="fa fa-diamond"></i></span> Services</a></li>
                <li><a href="${pageContext.request.contextPath}/user/dashboard#appointments"><span class="nav-ico"><i class="fa fa-calendar"></i></span> My appointments</a></li>
                <li><a href="${pageContext.request.contextPath}/user/dashboard#promos"><span class="nav-ico"><i class="fa fa-gift"></i></span> Promos &amp; offers</a></li>
            </ul>
        </nav>
    </aside>

    <main class="dash-main">
        <!-- Top nav mirrors the sidebar for wider screens. -->
        <header class="dash-topbar">
            <nav class="dash-topbar-links" aria-label="Top">
                <a class="active" href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/">Home</a>
                <a href="${pageContext.request.contextPath}/user/search">Search</a>
                <a href="${pageContext.request.contextPath}/user/search">Services</a>
                <a href="#appointments">My appointments</a>
                <a href="#promos">Promos</a>
            </nav>
            <div class="dash-topbar-tools">
                <a class="signout" href="${pageContext.request.contextPath}/user/logout">Sign out</a>
            </div>
        </header>

        <!-- Hero keeps the next useful action visible right away. -->
        <section class="dash-hero">
            <h1>Welcome, <c:out value="${sessionScope.user.name}"/>!</h1>
            <p>How can we help you look your best today?</p>
            <div class="dash-actions">
                <a class="btn-mauve" href="${pageContext.request.contextPath}/user/search">Book an appointment</a>
                <a class="btn-soft" href="${pageContext.request.contextPath}/user/search">View services</a>
            </div>
        </section>

        <!-- Promotions are driven by servlet-built cards so the copy lives in one place. -->
        <section class="dash-card dash-promos-panel" id="promos">
            <div class="dash-section-header">
                <div>
                    <p class="dash-section-tag">Seasonal deals</p>
                    <h2>Special promos and offers</h2>
                </div>
                <a class="see-all" href="${pageContext.request.contextPath}/user/search">Browse services ›</a>
            </div>
            <div class="dash-promo-grid">
                <c:forEach var="promo" items="${promoCards}">
                    <div class="dash-promo-card">
                        <img src="${pageContext.request.contextPath}${promo.imagePath}" alt="${promo.title}" class="dash-promo-image"/>
                        <div class="dash-promo-text">
                            <p class="script"><c:out value="${promo.title}"/></p>
                            <p class="dash-promo-copy"><c:out value="${promo.description}"/></p>
                            <c:url var="promoUrl" value="/user/search">
                                <c:param name="category" value="${promo.category}"/>
                                <c:param name="q" value="${promo.query}"/>
                            </c:url>
                            <a class="btn-mauve" href="${promoUrl}"><c:out value="${promo.buttonLabel}"/></a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <!-- This block uses the refreshed session user so recent profile edits show up immediately. -->
        <div class="dash-profile-row dash-card">
            <c:choose>
                <c:when test="${not empty sessionScope.user.image}">
                    <img src="${pageContext.request.contextPath}${sessionScope.user.image}" alt="Profile image" class="dash-avatar-slot" style="object-fit:cover;"/>
                </c:when>
                <c:otherwise>
                    <div class="dash-avatar-slot" title="Profile photo — add your image later"></div>
                </c:otherwise>
            </c:choose>
            <div>
                <h2 style="font-family:Georgia,serif;font-size:1.35rem;margin-bottom:6px;border:none;"><c:out value="${sessionScope.user.name}"/></h2>
                <p class="muted"><i class="fa fa-star" style="color:#c9a96e;"></i> Member<c:if test="${not empty sessionScope.user.memberSinceYear}"> since <c:out value="${sessionScope.user.memberSinceYear}"/></c:if></p>
                <div class="dash-actions" style="margin-top:14px;">
                    <a class="btn-dark" href="${pageContext.request.contextPath}/user/search">Book appointment</a>
                    <a class="btn-soft" href="${pageContext.request.contextPath}/user/profile">Edit profile</a>
                </div>
            </div>
        </div>

        <!-- Quick metrics first, then the more detailed lists below. -->
        <div class="dash-grid">
            <div class="dash-card">
                <h2>Total bookings</h2>
                <p style="font-size:2rem;font-weight:700;margin:6px 0;"><c:out value="${bookingCount}"/></p>
                <p class="muted">All appointments linked with your account.</p>
            </div>
            <div class="dash-card">
                <h2>Upcoming visits</h2>
                <p style="font-size:2rem;font-weight:700;margin:6px 0;"><c:out value="${fn:length(upcomingBookings)}"/></p>
                <p class="muted">Confirmed future appointments on your schedule.</p>
            </div>
            <div class="dash-card">
                <h2>Pending requests</h2>
                <p style="font-size:2rem;font-weight:700;margin:6px 0;"><c:out value="${pendingRequestCount}"/></p>
                <p class="muted">Service requests waiting for salon confirmation.</p>
            </div>
        </div>

        <div class="dash-card">
            <h2>Personal info</h2>
            <div class="dash-info-line"><span class="muted"><i class="fa fa-envelope-o"></i> Email</span> <c:out value="${sessionScope.user.email}"/></div>
            <div class="dash-info-line"><span class="muted"><i class="fa fa-phone"></i> Phone</span> <c:out value="${empty sessionScope.user.phone ? '—' : sessionScope.user.phone}"/></div>
            <p class="muted" style="margin-top:8px;"><a href="${pageContext.request.contextPath}/user/profile">Edit</a></p>
        </div>

        <div class="dash-card">
            <h2>Member rewards</h2>
            <div style="display:flex;justify-content:space-between;align-items:baseline;flex-wrap:wrap;gap:12px;">
                <div>
                    <span class="muted">Current status</span><br/>
                    <strong style="font-size:1.1rem;"><c:out value="${empty sessionScope.user.membershipLevel ? 'Gold Member' : sessionScope.user.membershipLevel}"/></strong>
                </div>
                <div style="text-align:right;font-size:1.5rem;font-weight:600;line-height:1.2;">85<br/><span style="font-size:0.9rem;font-weight:400;color:var(--dash-muted);">0</span></div>
            </div>
            <div class="progress-bar"><span></span></div>
            <p class="muted" style="font-size:0.8rem;text-align:center;">150 points away from Platinum</p>
        </div>

        <!-- Appointments are split in the servlet so the JSP can stay mostly presentational. -->
        <div class="dash-grid" id="appointments">
            <div>
                <div class="dash-card">
                    <h2>Upcoming appointment</h2>
                    <c:choose>
                        <c:when test="${empty upcomingBookings}">
                            <p class="muted">No upcoming visits. <a href="${pageContext.request.contextPath}/user/search">Book a service</a>.</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${upcomingBookings}" end="0">
                                <div class="dash-appt">
                                    <div style="display:flex;gap:14px;flex:1;min-width:200px;">
                                        <div class="date-box">Appt<br/><strong style="font-size:1rem;color:var(--dash-text);">●</strong></div>
                                        <div>
                                            <div class="appt-title"><c:out value="${b.serviceName}"/></div>
                                            <p class="muted" style="margin-top:6px;font-size:0.88rem;">
                                                <c:out value="${b.appointmentDatetime}"/>
                                            </p>
                                            <p class="dash-inline-photo-row" style="margin-top:10px;font-size:0.88rem;">
                                                <c:set var="upcomingImage" value="${serviceImageMap[b.serviceId]}"/>
                                                <c:if test="${empty upcomingImage}">
                                                    <c:set var="upcomingImage" value="/public/client_hair.png"/>
                                                </c:if>
                                                <img src="${pageContext.request.contextPath}${upcomingImage}" alt="${b.serviceName}" class="dash-inline-avatar"/>
                                                <c:out value="${b.stylistName}"/> · <span class="muted"><c:out value="${b.category}"/></span>
                                            </p>
                                        </div>
                                    </div>
                                    <div>
                                        <a class="btn-mauve" href="${pageContext.request.contextPath}/user/search" style="display:inline-block;margin-bottom:6px;">View appointment</a><br/>
                                        <a href="${pageContext.request.contextPath}/user/search" class="muted" style="font-size:0.85rem;">Reschedule ›</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="dash-card">
                    <h2>Your appointment history <a class="see-all" href="${pageContext.request.contextPath}/user/search">View all history ›</a></h2>
                    <c:choose>
                        <c:when test="${empty historyBookings}">
                            <p class="muted">No past appointments yet.</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="h" items="${historyBookings}" end="2">
                                <div class="dash-appt">
                                    <div style="display:flex;gap:10px;align-items:center;">
                                        <c:set var="historyImage" value="${serviceImageMap[h.serviceId]}"/>
                                        <c:if test="${empty historyImage}">
                                            <c:set var="historyImage" value="/public/client_hair.png"/>
                                        </c:if>
                                        <img src="${pageContext.request.contextPath}${historyImage}" alt="${h.serviceName}" class="dash-history-thumb"/>
                                        <div>
                                            <div style="font-weight:600;font-size:0.9rem;"><c:out value="${h.serviceName}"/></div>
                                            <p class="muted" style="font-size:0.82rem;"><c:out value="${h.appointmentDatetime}"/></p>
                                        </div>
                                    </div>
                                    <span class="muted" style="font-size:0.85rem;">Completed ›</span>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="dash-card">
                    <h2>Your service requests</h2>
                    <c:choose>
                        <c:when test="${empty applyRequests}">
                            <p class="muted">No requests submitted yet. Use Search to send a booking request.</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="request" items="${applyRequests}" end="2">
                                <div class="dash-appt">
                                    <div>
                                        <div style="font-weight:600;font-size:0.92rem;">Service request #<c:out value="${request.requestId}"/></div>
                                        <p class="muted" style="font-size:0.82rem;">
                                            Preferred date:
                                            <c:out value="${empty request.preferredDate ? 'Not specified' : request.preferredDate}"/>
                                        </p>
                                    </div>
                                    <span class="muted" style="font-size:0.85rem;"><c:out value="${request.status}"/></span>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div>
                <!-- Team cards are simple maps from the servlet, which keeps this loop tidy. -->
                <div class="dash-card">
                    <h2>Favourite stylists <a class="see-all" href="${pageContext.request.contextPath}/user/search">See all ›</a></h2>
                    <p class="muted" style="margin-bottom:12px;">From the Shringar team</p>
                    <div class="dash-stylist-row">
                        <c:forEach var="stylist" items="${favouriteStylists}">
                            <div class="dash-stylist">
                                <div class="dash-stylist-slot dash-stylist-photo">
                                    <img src="${pageContext.request.contextPath}${stylist.imagePath}" alt="${stylist.name}"/>
                                    <span class="heart" aria-hidden="true">♥</span>
                                </div>
                                <div style="font-weight:600;"><c:out value="${stylist.name}"/></div>
                                <div class="muted"><c:out value="${stylist.role}"/></div>
                            </div>
                        </c:forEach>
                    </div>
                    <a class="btn-soft" href="${pageContext.request.contextPath}/user/search" style="display:inline-block;margin-top:14px;width:100%;text-align:center;box-sizing:border-box;">View all stylists ›</a>
                </div>

                <!-- Favorite services reuse the same category data prepared for search. -->
                <div class="dash-card">
                    <h2>Favorite services</h2>
                    <div class="chips">
                        <c:forEach var="cat" items="${categories}">
                            <c:url var="catUrl" value="/user/search"><c:param name="category" value="${cat}"/></c:url>
                            <a href="${catUrl}"><c:out value="${cat}"/></a>
                        </c:forEach>
                        <a class="add-placeholder" href="${pageContext.request.contextPath}/user/search">+ Add service</a>
                    </div>
                </div>

            </div>
        </div>
    </main>
</div>
</body>
</html>
