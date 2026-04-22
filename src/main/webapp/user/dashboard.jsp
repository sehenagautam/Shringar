<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Dashboard — Shringar Beauty Salon</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-user.css"/>
</head>
<body>
<div class="dash-layout">
    <aside class="dash-side" aria-label="Sidebar">
        <div class="dash-logo-slot" title="Logo placeholder — add your image later"></div>
        <nav>
            <ul>
                <li><a class="active" href="${pageContext.request.contextPath}/user/dashboard"><span class="nav-ico">◆</span> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/index.jsp"><span class="nav-ico">⌂</span> Home</a></li>
                <li><a href="${pageContext.request.contextPath}/user/search"><span class="nav-ico">◷</span> Booking</a></li>
                <li><a href="${pageContext.request.contextPath}/user/search"><span class="nav-ico">✦</span> Services</a></li>
                <li><a href="${pageContext.request.contextPath}/user/dashboard#appointments"><span class="nav-ico">☷</span> My appointments</a></li>
            </ul>
        </nav>
    </aside>

    <main class="dash-main">
        <header class="dash-topbar">
            <nav class="dash-topbar-links" aria-label="Top">
                <a class="active" href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <a href="${pageContext.request.contextPath}/user/search">Booking</a>
                <a href="${pageContext.request.contextPath}/user/search">Services</a>
                <a href="#appointments">My appointments</a>
            </nav>
            <div class="dash-topbar-tools">
                <span class="ico" title="Notifications">🔔</span>
                <span class="ico" title="Profile">👤</span>
                <a class="signout" href="${pageContext.request.contextPath}/user/logout">Sign out</a>
            </div>
        </header>

        <section class="dash-hero">
            <h1>Welcome, <c:out value="${sessionScope.user.name}"/>!</h1>
            <p>How can we help you look your best today?</p>
            <div class="dash-actions">
                <a class="btn-mauve" href="${pageContext.request.contextPath}/user/search">Book an appointment</a>
                <a class="btn-soft" href="${pageContext.request.contextPath}/user/search">View services</a>
            </div>
        </section>

        <div class="dash-profile-row dash-card">
            <c:choose>
                <c:when test="${not empty sessionScope.user.image}">
                    <img src="${pageContext.request.contextPath}/${sessionScope.user.image}" alt="Profile image" class="dash-avatar-slot" style="object-fit:cover;"/>
                </c:when>
                <c:otherwise>
                    <div class="dash-avatar-slot" title="Profile photo — add your image later"></div>
                </c:otherwise>
            </c:choose>
            <div>
                <h2 style="font-family:Georgia,serif;font-size:1.35rem;margin-bottom:6px;border:none;"><c:out value="${sessionScope.user.name}"/></h2>
                <p class="muted">👑 Member<c:if test="${not empty sessionScope.user.memberSinceYear}"> since <c:out value="${sessionScope.user.memberSinceYear}"/></c:if></p>
                <div class="dash-actions" style="margin-top:14px;">
                    <a class="btn-dark" href="${pageContext.request.contextPath}/user/search">Book appointment</a>
                    <a class="btn-soft" href="${pageContext.request.contextPath}/user/profile">Edit profile</a>
                </div>
            </div>
        </div>

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
            <div class="dash-info-line"><span class="muted">✉ Email</span> <c:out value="${sessionScope.user.email}"/></div>
            <div class="dash-info-line"><span class="muted">☎ Phone</span> <c:out value="${empty sessionScope.user.phone ? '—' : sessionScope.user.phone}"/></div>
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
                                            <p style="margin-top:10px;font-size:0.88rem;">
                                                <span class="dash-avatar-slot" style="width:40px;height:40px;display:inline-block;vertical-align:middle;margin-right:8px;" title="Stylist photo placeholder"></span>
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
                                        <div class="dash-avatar-slot" style="width:44px;height:44px;" title="Placeholder"></div>
                                        <div>
                                            <div style="font-weight:600;font-size:0.9rem;"><c:out value="${h.stylistName}"/></div>
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
                <div class="dash-card">
                    <h2>Favourite stylists <a class="see-all" href="${pageContext.request.contextPath}/user/search">See all ›</a></h2>
                    <p class="muted" style="margin-bottom:12px;">From popular services</p>
                    <div class="dash-stylist-row">
                        <c:forEach var="p" items="${popularServices}" end="4">
                            <div class="dash-stylist">
                                <div class="dash-stylist-slot" title="Photo placeholder">
                                    <span class="heart" aria-hidden="true">♥</span>
                                </div>
                                <div style="font-weight:600;"><c:out value="${p.stylistName}"/></div>
                                <div class="muted"><c:out value="${p.category}"/></div>
                            </div>
                        </c:forEach>
                    </div>
                    <a class="btn-soft" href="${pageContext.request.contextPath}/user/search" style="display:inline-block;margin-top:14px;width:100%;text-align:center;box-sizing:border-box;">View all stylists ›</a>
                </div>

                <div class="dash-card">
                    <h2>Favorite services</h2>
                    <div class="chips">
                        <c:forEach var="cat" items="${categories}">
                            <c:url var="catUrl" value="/user/search"><c:param name="category" value="${cat}"/></c:url>
                            <a href="${pageContext.request.contextPath}${catUrl}"><c:out value="${cat}"/></a>
                        </c:forEach>
                        <a class="add-placeholder" href="${pageContext.request.contextPath}/user/search">+ Add service</a>
                    </div>
                </div>

                <div class="dash-card">
                    <h2>Promotions</h2>
                    <div class="dash-promo">
                        <div class="dash-promo-text">
                            <p class="script">Spring special</p>
                            <p style="font-size:1rem;margin-bottom:12px;">20% off all manicure services</p>
                            <a class="btn-mauve" href="${pageContext.request.contextPath}/user/search">Book now</a>
                        </div>
                        <div class="dash-promo-img-slot" title="Promotion image — add later"></div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>
