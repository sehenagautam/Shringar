<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Shringar Beauty Salon</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600;700&family=Jost:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css?v=20260411-2146">
</head>
<body class="admin-body">
    <div class="dashboard-shell">
        <aside class="dashboard-sidebar">
            <a class="brand-panel" href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Shringar Beauty Salon">
                <span>Admin Suite</span>
            </a>

            <nav class="admin-nav" aria-label="Admin navigation">
                <a class="admin-nav-link active" href="#">
                    <i class="fa-solid fa-chart-pie"></i>
                    <span>Dashboard</span>
                </a>
                <a class="admin-nav-link" href="#">
                    <i class="fa-regular fa-calendar-check"></i>
                    <span>Bookings</span>
                </a>
                <a class="admin-nav-link" href="#">
                    <i class="fa-regular fa-user"></i>
                    <span>Customers</span>
                </a>
                <a class="admin-nav-link" href="#">
                    <i class="fa-solid fa-wand-magic-sparkles"></i>
                    <span>Services</span>
                </a>
                <a class="admin-nav-link" href="#">
                    <i class="fa-solid fa-user-tie"></i>
                    <span>Staff</span>
                </a>
                <a class="admin-nav-link" href="#">
                    <i class="fa-solid fa-gear"></i>
                    <span>Settings</span>
                </a>
            </nav>

            <div class="sidebar-note">
                <p>Today</p>
                <strong>18 appointments</strong>
                <span>6 services completed</span>
            </div>
        </aside>

        <main class="dashboard-main">
            <header class="admin-topbar">
                <div>
                    <p class="eyebrow">Shringar Beauty &amp; Wellness</p>
                    <h1>Admin Dashboard</h1>
                </div>

                <div class="topbar-actions">
                    <label class="search-box">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="search" placeholder="Search bookings">
                    </label>
                    <button class="icon-button" type="button" aria-label="Notifications">
                        <i class="fa-regular fa-bell"></i>
                    </button>
                    <button class="admin-profile" type="button">
                        <span>SG</span>
                        <div>
                            <strong>Admin</strong>
                            <small>Salon Manager</small>
                        </div>
                    </button>
                </div>
            </header>

            <section class="kpi-row" aria-label="Dashboard summary">
                <article class="kpi-card">
                    <span class="kpi-icon booking"><i class="fa-regular fa-calendar-days"></i></span>
                    <div>
                        <p>Total bookings</p>
                        <strong>150</strong>
                        <small class="trend up">+12% this week</small>
                    </div>
                </article>

                <article class="kpi-card">
                    <span class="kpi-icon customers"><i class="fa-solid fa-user-group"></i></span>
                    <div>
                        <p>Customers</p>
                        <strong>120</strong>
                        <small class="trend up">18 repeat clients</small>
                    </div>
                </article>

                <article class="kpi-card accent">
                    <span class="kpi-icon revenue"><i class="fa-solid fa-sack-dollar"></i></span>
                    <div>
                        <p>Revenue</p>
                        <strong>NPR 500,000</strong>
                        <small class="trend up">+8.5% this month</small>
                    </div>
                </article>

                <article class="kpi-card">
                    <span class="kpi-icon services"><i class="fa-solid fa-star"></i></span>
                    <div>
                        <p>Services done</p>
                        <strong>320</strong>
                        <small class="trend neutral">32 today</small>
                    </div>
                </article>
            </section>

            <section class="dashboard-content">
                <div class="content-stack wide-stack">
                    <article class="dashboard-card analytics-card">
                        <div class="card-header">
                            <div>
                                <p class="eyebrow">Weekly activity</p>
                                <h2>Appointments Overview</h2>
                            </div>
                            <button class="filter-button" type="button">This Week <i class="fa-solid fa-chevron-down"></i></button>
                        </div>

                        <div class="chart-area" aria-label="Appointments overview chart">
                            <svg class="line-chart" viewBox="0 0 760 300" role="img" aria-labelledby="chartTitle">
                                <title id="chartTitle">Appointments from Monday to Sunday</title>
                                <line class="grid-line" x1="56" y1="46" x2="724" y2="46"></line>
                                <line class="grid-line" x1="56" y1="104" x2="724" y2="104"></line>
                                <line class="grid-line" x1="56" y1="162" x2="724" y2="162"></line>
                                <line class="grid-line" x1="56" y1="220" x2="724" y2="220"></line>
                                <text x="16" y="51" class="axis-label">40</text>
                                <text x="16" y="109" class="axis-label">30</text>
                                <text x="16" y="167" class="axis-label">20</text>
                                <text x="16" y="225" class="axis-label">10</text>
                                <path class="chart-fill" d="M56 192 C98 150 135 128 174 140 C224 156 250 168 300 150 C358 128 386 82 440 96 C496 112 522 136 570 118 C632 94 650 36 686 64 C710 84 724 148 724 172 L724 248 L56 248 Z"></path>
                                <path class="chart-line" d="M56 192 C98 150 135 128 174 140 C224 156 250 168 300 150 C358 128 386 82 440 96 C496 112 522 136 570 118 C632 94 650 36 686 64 C710 84 724 148 724 172"></path>
                                <circle class="chart-dot" cx="56" cy="192" r="6"></circle>
                                <circle class="chart-dot" cx="174" cy="140" r="6"></circle>
                                <circle class="chart-dot" cx="300" cy="150" r="6"></circle>
                                <circle class="chart-dot" cx="440" cy="96" r="6"></circle>
                                <circle class="chart-dot" cx="570" cy="118" r="6"></circle>
                                <circle class="chart-dot highlight" cx="686" cy="64" r="8"></circle>
                                <circle class="chart-dot" cx="724" cy="172" r="6"></circle>
                                <text x="45" y="282" class="day-label">Mon</text>
                                <text x="162" y="282" class="day-label">Tue</text>
                                <text x="287" y="282" class="day-label">Wed</text>
                                <text x="426" y="282" class="day-label">Thu</text>
                                <text x="558" y="282" class="day-label">Fri</text>
                                <text x="674" y="282" class="day-label">Sat</text>
                                <text x="713" y="282" class="day-label">Sun</text>
                            </svg>
                        </div>

                        <div class="chart-summary">
                            <span><strong>40</strong> peak bookings</span>
                            <span><strong>24</strong> avg per day</span>
                            <span><strong>86%</strong> confirmed</span>
                        </div>
                    </article>

                    <article class="dashboard-card service-table-card">
                        <div class="card-header">
                            <div>
                                <p class="eyebrow">Operations</p>
                                <h2>Service Performance</h2>
                            </div>
                            <a class="text-link" href="#">Manage services</a>
                        </div>

                        <table class="service-table">
                            <thead>
                                <tr>
                                    <th>Service</th>
                                    <th>Bookings</th>
                                    <th>Revenue</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/public/client_makeup.png" alt="">
                                        <span>Bridal Makeup</span>
                                    </td>
                                    <td>32</td>
                                    <td>NPR 96,000</td>
                                    <td><span class="status-pill strong">Top</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/public/hair_popular_services.png" alt="">
                                        <span>Hair Cut &amp; Styling</span>
                                    </td>
                                    <td>28</td>
                                    <td>NPR 42,000</td>
                                    <td><span class="status-pill">Stable</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/public/nail.png" alt="">
                                        <span>Nail Art Design</span>
                                    </td>
                                    <td>24</td>
                                    <td>NPR 30,000</td>
                                    <td><span class="status-pill warning">Pending slots</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </article>
                </div>

                <div class="content-stack side-stack">
                    <article class="dashboard-card schedule-card">
                        <div class="card-header compact">
                            <div>
                                <p class="eyebrow">Today</p>
                                <h2>Upcoming</h2>
                            </div>
                            <a class="text-link" href="#">View all</a>
                        </div>

                        <div class="timeline">
                            <article class="timeline-item">
                                <time>10:00</time>
                                <div>
                                    <h3>Priya Sharma</h3>
                                    <p>Hair Cut &amp; Styling</p>
                                </div>
                                <span class="status-pill strong">Confirmed</span>
                            </article>

                            <article class="timeline-item">
                                <time>11:30</time>
                                <div>
                                    <h3>Anjali Verma</h3>
                                    <p>Bridal Makeup</p>
                                </div>
                                <span class="status-pill strong">Confirmed</span>
                            </article>

                            <article class="timeline-item">
                                <time>01:00</time>
                                <div>
                                    <h3>Neha Singh</h3>
                                    <p>Nail Art Design</p>
                                </div>
                                <span class="status-pill warning">Pending</span>
                            </article>

                            <article class="timeline-item">
                                <time>03:30</time>
                                <div>
                                    <h3>Ritika Arora</h3>
                                    <p>Hair Spa Treatment</p>
                                </div>
                                <span class="status-pill strong">Confirmed</span>
                            </article>
                        </div>
                    </article>

                    <article class="dashboard-card quick-card">
                        <p class="eyebrow">Quick action</p>
                        <h2>Create a booking</h2>
                        <p>Use this panel for admin-only bookings after the admin login flow is added.</p>
                        <button class="primary-action" type="button">New Appointment</button>
                    </article>

                    <article class="dashboard-card review-card">
                        <div class="card-header compact">
                            <div>
                                <p class="eyebrow">Feedback</p>
                                <h2>Recent Reviews</h2>
                            </div>
                            <span class="rating-badge">4.8</span>
                        </div>

                        <div class="review-block">
                            <span class="review-avatar">P</span>
                            <div>
                                <h3>Priya Sharma</h3>
                                <p>"Amazing experience. The staff was professional and friendly."</p>
                                <span class="stars">
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                </span>
                            </div>
                        </div>
                    </article>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
