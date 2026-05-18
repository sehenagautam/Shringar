<<<<<<< HEAD
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:forward page="/search" />
=======
<%@ include file="../components/header.jsp" %>
<%@ include file="../components/navbar.jsp" %>

<div class="main-container">

    <div class="appointment-title">
        <h1>Book Appointment</h1>
    </div>

    <div class="appointment-main">

        <div class="appointment-intro">
            <p>Fill in the details below to book your appointment at Shringar Salon.<br>
            We will confirm your booking shortly.</p>
        </div>

        <div class="appointment-wrapper">

            <!-- LEFT: FORM FIELDS -->
            <div class="appt-form">
                <div class="appt-group">
                    <label>Full Name</label>
                    <input type="text" placeholder="Your full name">
                </div>
                <div class="appt-group">
                    <label>Phone Number</label>
                    <input type="text" placeholder="+977-XXXXXXXXXX">
                </div>
                <div class="appt-group">
                    <label>Email Address</label>
                    <input type="text" placeholder="your@email.com">
                </div>
                <div class="appt-group">
                    <label>Service Type</label>
                    <select>
                        <option>-- Select Service --</option>
                        <option>Hair Cut Services</option>
                        <option>Nail Services</option>
                        <option>Makeup Services</option>
                    </select>
                </div>
                <div class="appt-group">
                    <label>Stylist Preference</label>
                    <select>
                        <option>-- No Preference --</option>
                        <option>Any Available</option>
                    </select>
                </div>
                <div class="appt-group">
                    <label>Additional Notes</label>
                    <textarea placeholder="Any special requests or notes..."></textarea>
                </div>
            </div>

            <!-- RIGHT: CALENDAR + TIME -->
            <div class="calendar-section">
                <label>Select Date</label>
                <div class="calendar-box">
                    <div class="cal-header">
                        <button>&lt;</button>
                        <span>April 2026</span>
                        <button>&gt;</button>
                    </div>
                    <div class="cal-days-header">
                        <span>SU</span><span>MO</span><span>TU</span>
                        <span>WE</span><span>TH</span><span>FR</span><span>SA</span>
                    </div>
                    <div class="cal-days">
                        <div class="cal-day empty"></div>
                        <div class="cal-day empty"></div>
                        <div class="cal-day empty"></div>
                        <div class="cal-day">1</div>
                        <div class="cal-day">2</div>
                        <div class="cal-day">3</div>
                        <div class="cal-day">4</div>
                        <div class="cal-day">5</div>
                        <div class="cal-day">6</div>
                        <div class="cal-day">7</div>
                        <div class="cal-day">8</div>
                        <div class="cal-day">9</div>
                        <div class="cal-day">10</div>
                        <div class="cal-day">11</div>
                        <div class="cal-day">12</div>
                        <div class="cal-day">13</div>
                        <div class="cal-day">14</div>
                        <div class="cal-day">15</div>
                        <div class="cal-day">16</div>
                        <div class="cal-day">17</div>
                        <div class="cal-day">18</div>
                        <div class="cal-day">19</div>
                        <div class="cal-day">20</div>
                        <div class="cal-day">21</div>
                        <div class="cal-day selected">22</div>
                        <div class="cal-day">23</div>
                        <div class="cal-day">24</div>
                        <div class="cal-day">25</div>
                        <div class="cal-day">26</div>
                        <div class="cal-day">27</div>
                        <div class="cal-day">28</div>
                        <div class="cal-day">29</div>
                        <div class="cal-day">30</div>
                        <div class="cal-day empty"></div>
                        <div class="cal-day empty"></div>
                    </div>
                </div>

                <div class="time-label">Select Time</div>
                <div class="time-slots">
                    <div class="time-slot">9:30 AM</div>
                    <div class="time-slot">10:00 AM</div>
                    <div class="time-slot">11:00 AM</div>
                    <div class="time-slot selected">1:00 PM</div>
                    <div class="time-slot">2:00 PM</div>
                    <div class="time-slot">3:00 PM</div>
                    <div class="time-slot">4:00 PM</div>
                    <div class="time-slot">5:00 PM</div>
                    <div class="time-slot">6:00 PM</div>
                </div>
            </div>

        </div>

        <button class="appt-submit">BOOK APPOINTMENT</button>

        <div class="appt-info-row">
            <div class="appt-info-box">
                <h4>Our Location</h4>
                <p>Kamalpokhari, Kathmandu, Nepal</p>
            </div>
            <div class="appt-info-box">
                <h4>Opening Hours</h4>
                <p>Sunday - Saturday<br>9:30 AM - 7:00 PM</p>
            </div>
            <div class="appt-info-box">
                <h4>Call Us</h4>
                <p>+977-9820221306<br>+977-9823603213</p>
            </div>
        </div>

    </div>

</div>

<%@ include file="../components/footer.jsp" %>
>>>>>>> 81341f24903c2fbc7ab471e2df027b1816445a92
