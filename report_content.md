# TripSplit - Project Report

## 17.1 Introduction
Group travel is an exciting experience, but managing shared expenses and coordinating a dynamic itinerary often leads to confusion and disputes. TripSplit is a smart travel expense splitter and itinerary planner designed to address these pain points. Built as a local-first application, TripSplit empowers users to seamlessly track expenses, view intuitive charts, and optimally settle debts, all while maintaining complete functionality in offline or remote travel scenarios. The target users are groups of friends, families, or solo travelers seeking a unified tool to manage trip logistics.

## 17.2 Problem Statement
- **Manual Expense Tracking:** Relying on spreadsheets or physical receipts leads to calculation errors and disputes over who owes whom.
- **Coordination Issues:** Lack of a centralized itinerary means participants are often unaware of scheduled activities and locations.
- **Complex Debt Resolution:** Calculating fair splits among subsets of participants manually is tedious, and individuals often end up passing money back and forth unnecessarily.
- **Connectivity Limitations:** Traditional cloud-based travel apps fail when users travel to remote locations or cross international borders without immediate cellular data.

## 17.3 Objectives
1. Provide a seamless offline-first experience with a local database prioritizing data availability.
2. Implement a robust trip creation module allowing the addition of participants and metadata.
3. Build a dynamic itinerary planner with chronological timelines and categorizations.
4. Develop a multi-participant expense tracking system capable of specific subset splitting.
5. Create a debt simplification algorithm to calculate the optimal number of transactions for settling debts.
6. Design an interactive dashboard with animated charts for spending visualization.
7. Integrate a background synchronization service to handle eventual consistency with a cloud backend.
8. Deliver a premium, highly responsive user interface adhering to Material 3 design principles.

## 17.4 Module Descriptions
- **Trips Module:** Handles the creation, retrieval, updating, and deletion (CRUD) of travel events. It manages the core metadata (dates, destinations, currency) and maintains the list of participants assigned to the trip.
- **Itinerary Module:** A chronologically structured module allowing users to add activities with locations, times, and specific categories (e.g., transit, food). Activities can be marked as completed, providing a checklist functionality.
- **Expenses Module:** The financial core of the app. It records transactions, who paid, and who the expense is split among.
- **Expense Splitter (Algorithm):** Evaluates all expenses to calculate net balances for each user, then applies a greedy algorithm to determine optimal settlement transfers, minimizing the total number of transactions.
- **Search Module:** Provides a unified search interface allowing users to filter trips or expenses by query, participant, or date range.
- **Offline Sync Module:** Monitors device connectivity and utilizes a `SyncQueue` to capture local changes, attempting synchronization only when a stable connection is detected, guaranteeing zero data loss.
- **Settings Module:** Manages global preferences such as default currency, theme overrides, and manual synchronization triggers.

## 17.5 Expense Splitting Logic Explanation
The debt simplification system operates in two stages:
1. **Balance Calculation:** For every expense, the payer's balance is credited (+amount), and each participant sharing the expense is debited (-(amount / number_of_sharers)).
2. **Greedy Simplification Algorithm:** The final net balances are separated into "Creditors" (positive balance) and "Debtors" (negative balance). The lists are sorted descending and ascending, respectively. The algorithm iteratively matches the largest debtor with the largest creditor, creating a settlement transaction and reducing their balances until all balances reach zero.
   *Example:* If Alice (+2000), Bob (-250), and Charlie (-1750) are the final balances, instead of Charlie paying Alice and Bob paying Charlie, the algorithm outputs: Charlie pays Alice 1750, and Bob pays Alice 250.
   *Time Complexity:* O(N log N) dominated by the sorting step of the balances.

## 17.6 Offline Sync Architecture Explanation
TripSplit employs a "Local-First" architecture. The UI reads synchronously from Hive (a high-performance local NoSQL database). When a user performs a write action, the repository writes the data to Hive and flags it as `isSynced = false`, simultaneously appending a mutation record to the `SyncQueueBox`. The `SyncService` listens to network state changes via `connectivity_plus`. Upon detecting an active connection, it dequeues operations, transmits them to the cloud backend (e.g., Firebase), and upon success, updates the local records to `isSynced = true`. This ensures instantaneous UI feedback and robust battery efficiency.

## 17.7 Future Scope
- **OCR Receipt Scanning:** Implementing machine learning to automatically extract totals and items from physical receipts.
- **Live Currency Conversion:** Integrating exchange rate APIs to handle mixed-currency expenses dynamically.
- **AI Itinerary Suggestions:** Utilizing LLMs to suggest activities based on the destination and trip duration.
- **Payment Gateway Integration:** Enabling users to settle debts directly within the app via UPI or localized payment systems.

## 17.8 Conclusion
TripSplit successfully demonstrates a complete solution to group travel management. By leveraging Clean Architecture and Riverpod, the application maintains strict separation of concerns, resulting in highly testable and maintainable code. The implementation of the offline-first sync queue and the optimal debt simplification algorithm highlights advanced capabilities over standard CRUD applications, resulting in a production-grade utility tailored for real-world reliability.
