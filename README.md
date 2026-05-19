# Shringar Beauty & Wellness

Shringar is a salon booking web application built for a smooth and elegant beauty service experience. The project brings together public website pages, customer registration and login, service discovery, a user dashboard, profile management, wishlist support, contact form handling, and protected user features in one Jakarta web app.

The idea behind this project is simple. A visitor should be able to explore the salon comfortably, understand the services clearly, and move into booking related features without confusion. The interface keeps a soft salon-inspired look, while the backend handles authentication, validation, session control, file upload, and database operations.

## What the project includes

- Public homepage with salon branding and linked navigation
- About page and Contact page
- Contact form with server-side validation and database storage
- Service pages for hair, makeup, and nails
- Public search page with filters for category, stylist, and keyword
- User registration and login
- Profile image upload during registration and profile update
- Password hashing with BCrypt
- Session handling with automatic timeout after 30 minutes of inactivity
- User dashboard with protected access
- Wishlist and service request flow
- Custom error pages for 403, 404, and 500

## Tech stack

- Java 17
- Jakarta Servlet and JSP
- JSTL
- MySQL
- JDBC
- Apache Tomcat 10.1
- HTML and CSS

## Project structure

- `src/main/java/com/shringar` contains controllers, filters, DAOs, models, services, and utility classes
- `src/main/webapp` contains JSP pages, shared components, CSS, images, and public assets
- `src/main/resources/salon_schema.sql` contains the database schema used by the project

## Database

Use this database name:

`salon_booking_system_db`

Import the schema from:

`src/main/resources/salon_schema.sql`

This schema includes tables for:

- users
- services
- bookings
- apply_requests
- contact_messages

## Important backend utilities

The application uses the utility style provided in class, adapted for this salon system:

- `SessionUtil` for session attributes, timeout handling, and invalidation
- `PasswordUtil` for password hashing and verification
- `FileUploadUtil` for profile image upload handling
- `CookieUtil` for remembering user email and cookie operations

## Main flows

### Public visitor flow

A visitor can open the homepage, move to About, Contact, Services, Gallery, and Search, and explore the salon without logging in. The public search page helps users filter services even when they do not know the exact name of what they want.

### Customer flow

A customer can register, upload a profile image, sign in, and get redirected to the user dashboard. From there, they can manage their profile, browse services, save wishlist items, and send service requests.

### Contact flow

The Contact page now works as a full form flow. If the form has invalid data, validation messages are shown on the same page. If the submission is valid, the message is saved to the database and a success message is shown after redirect.

## Protected pages

User-only areas are protected through filters and session checks. If a session expires after 30 minutes of inactivity, the user is redirected back to login and asked to sign in again.

## How to run the project

### Requirements

- JDK 17
- MySQL
- Apache Tomcat 10.1
- Eclipse IDE for Enterprise Java

### Setup steps

1. Create a MySQL database named `salon_booking_system_db`.
2. Import `src/main/resources/salon_schema.sql`.
3. Open the project in Eclipse.
4. Make sure Tomcat 10.1 is configured in Eclipse.
5. Add the project to the Tomcat server.
6. Start the server.
7. Open `http://localhost:8080/booking`

## Useful routes

- `/booking/`
- `/booking/aboutus`
- `/booking/ContactUs`
- `/booking/search`
- `/booking/login`
- `/booking/register`
- `/booking/user/dashboard`

## How to quickly test the system

- Open the homepage and check that all public navigation links work
- Open `/ContactUs` and submit invalid data to see validation messages
- Submit valid contact data and check `contact_messages` in phpMyAdmin
- Open `/search` and filter services by keyword, category, or stylist
- Register a new user and confirm the redirect to the user dashboard
- Log in with the same account and confirm session-based access
- Open a wrong URL and confirm the custom 404 page appears

## Notes

- The project uses Jakarta packages, not `javax.*`
- The active Java package used in this project is `com.shringar`
- The frontend is crafted using custom vanilla CSS for a lightweight and unique design
- The user session timeout is set to 30 minutes

## Final thought

Shringar was designed to feel like more than a classroom exercise. It aims to present a beauty salon in a way that feels polished, calm, and welcoming while still meeting the technical expectations of a full web programming project. It combines presentation, usability, and backend logic in a way that feels practical and complete.
