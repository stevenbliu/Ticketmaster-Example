# Ticketmaster-Example
Online platform that allows user to purchase for events such as concerts and sports.

# System Design
## Functional Requirements
  - View events
  - Book tickets
  - Search events
- Extras
  - **Create Events
  - **User Accounts
  - **Process Payments
  - **Real-time updates
- Issues
  - How do you handle a popular event when many users are trying to book at the same time?
    - Implement a queue for the event. A random queue would be good for fairness.
      - Improve Queue design with real-time queue position updates + session reservation so user don't lose their spot 

## Non-Functional Requirements
  - Consistency: Strong consistency when booking tickets
    - Solved with Distributed Transactions or Optimistic Locking 
  - Availability: Near 100% uptime when viewing and searching events regardless of traffic
    - Load balancers, replicated databases, and distributed services
  - Scalability: Handle spikes in traffic, especially for popular events
    - Scale horizontally by adding more servers or workers 
  - **Latency: Low Latency when searcing for events. Should load quickly (within milliseconds) even with  millions of users
    - Caching with Redis/CDN for frequently accessed data
    - Search optimized database with ElasticSearch
  -  Reliability: Guarentee ticket booking completes/fails cleanly with clear feedback
    - Implement retries and compensating actions for failed bookings.    
  - Security: Protect user data and payments with robust encryption. (HTTPS, tokenization)
    - Prevent fraud by enforcing rate limiting and CAPTCHA during high-traffic events
  - **Real-Time Updates: Reflect ticket availability and prices in real-time to avoid misleading users.
    - Use server-to-client tools like WebSockets, Server Push Mechanisms or SSE to provide instant updates from server to the client
  - Fault Tolerance: System should be able to continue operating despite partial failures
    - Use failover systems for databasesa and services
  - Data Durability: Ensure once a booking is completed, it is never lost, even if system crashes.
    - Write-ahead logs or multi-region backups.
  - **Compliance: Adhere to legal/regulatory requirements.

## Core Entities
  - Tickets (1:1 for user and event)
    - id
    - userId (booked by)
    - eventId
    - seatNum
    - status
  - Events (1:many for tickets)
    - id
    - Date/Time
    - available_seats -> tickets
  - Users (1:many for tickets and events)
    - id    

## Logic
  - Viewing an event
    - Retrieve event details. Calculate and display available tickets.
  - Initiate booking process
    - Verify if number of tickets requested are available, then proceed to booking process.
  - Booking process
    - Ensure tickets are reserved temporarily during the process with Optimistic Locking. (Reserves tickets for x amount of time to complete booking process to prevent double-booking)
      - Lock tickets by marking them as reserved for x amount of time
      - Update Event's available ticket count
    - Continue to payment process
      - if successful: update ticket status + user, event ticket availability, and record booking. confirm updates were successful. 
      - if fail: notify user of fail, ask for retry
    - Completed payment process
      - send user confirmation notification.  

## Architecure/Tech Stack
  - Django
  - PostgreSQL
  - Redis
  - ElasticSearch

***Possible Improvements*
