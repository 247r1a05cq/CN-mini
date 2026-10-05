# SimpleChat - Real-Time Chat Application

A complete, beginner-friendly, full-stack real-time chat application built with **React**, **Vite**, **Node.js**, **Express**, **Socket.IO**, and **SQLite**.

---

## 🌟 Features

- 🔐 **User Authentication**: Secure registration and login with password hashing via `bcryptjs` and session handling via JWT (JSON Web Tokens).
- ⚡ **Real-Time Messaging**: Instant 1-on-1 messaging powered by **Socket.IO** with zero page refreshes required.
- 💾 **Persistent Database**: Conversation histories and user accounts are saved to a local **SQLite** database (`database.sqlite`).
- 🟢 **Live Online/Offline Presence**: Tracks and broadcasts active user connections in real time with timestamped last seen status.
- 🔍 **User Search**: Instantly search for existing users by username or email.
- 💬 **Modern Responsive UI**:
  - Desktop sidebar + chat window.
  - Mobile collapsible navigation.
  - User avatars with dynamic initials.
  - Sent vs. received message alignment with timestamps.
  - Auto-scrolling to newest messages.
  - Enter to send, Shift + Enter for multiline messages.
  - Live typing indicator ("Typing...").
- 🧪 **Automated Backend & WebSocket Tests**: Complete test suite with 22 tests verifying auth, messaging, database queries, and real-time socket events.
- 🌱 **Database Seeding**: One-command seed script with demo accounts for immediate testing.

---

## 🏗️ Architecture & Real-Time Flow

```
Browser A (User A)
   │
   │ 1. socket.emit('send_message', { receiverId, content })
   ▼
Node.js + Express + Socket.IO Server
   │
   ├─► 2. Authenticate & validate message
   ├─► 3. Save to SQLite database (messages table)
   │
   ├─► 4. io.to('user_B').emit('receive_message', message)
   └─► 5. io.to('user_A').emit('receive_message', message)
   │
   ▼
Browser B (User B receives message immediately without refresh)
```

---

## 🛠️ Technology Stack

| Layer | Technology | Description |
|---|---|---|
| **Frontend** | React 18, Vite | High-performance SPA with modern React hooks & Context API |
| **Icons** | Lucide React | Clean, modern vector UI icons |
| **Backend** | Node.js, Express.js | Modular REST API and HTTP server |
| **Real-Time** | Socket.IO (v4) | WebSocket-based bidirectional real-time communication |
| **Database** | SQLite (sql.js) | Lightweight relational database with disk persistence |
| **Auth & Security** | JWT, bcryptjs | Encrypted passwords and protected endpoints |
| **Testing** | Node.js Test Runner, Supertest, socket.io-client | Zero-dependency native unit and integration tests |

---

## 📁 Project Structure

```
cn project/
├── client/                     # Frontend (React + Vite)
│   ├── src/
│   │   ├── components/         # UI Components (Avatar, Sidebar, ChatWindow, etc.)
│   │   ├── context/            # AuthContext & SocketContext
│   │   ├── pages/              # LoginPage, RegisterPage, ChatPage
│   │   ├── services/           # Axios API & service handlers
│   │   ├── styles/             # index.css (Responsive design system)
│   │   ├── App.jsx             # Main router & app wrapper
│   │   └── main.jsx            # React root entry
│   ├── index.html
│   ├── vite.config.js          # Vite config with API proxy
│   └── package.json
│
├── server/                     # Backend (Node.js + Express + Socket.IO)
│   ├── src/
│   │   ├── controllers/        # authController, userController, messageController
│   │   ├── database/           # SQLite connection (db.js) & schema (init.js)
│   │   ├── middleware/         # authMiddleware (JWT) & errorHandler
│   │   ├── models/             # UserModel & MessageModel
│   │   ├── routes/             # REST endpoints (/api/auth, /api/users, /api/messages)
│   │   ├── scripts/            # Database seed script (seed.js)
│   │   ├── socket/             # Socket.IO connection & event handlers
│   │   ├── app.js              # Express app setup & CORS
│   │   └── server.js           # Server entry point
│   ├── tests/                  # Automated test suites
│   │   ├── api.test.js         # REST API & authentication tests
│   │   └── realtime.test.js    # Real-time Socket.IO communication tests
│   ├── .env.example
│   └── package.json
│
├── .gitignore
├── .env.example
├── package.json                # Root helper scripts
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- **Node.js** (v18 or higher)
- **npm** (v9 or higher)

---

### Step 1: Install Dependencies

You can install both backend and frontend dependencies in their respective folders:

```bash
# In the server folder:
cd server
npm install

# In the client folder:
cd ../client
npm install
```

---

### Step 2: Environment Setup

The backend comes with preconfigured default variables in `server/.env.example`.
Create a `.env` file in the `server` directory (already created by default):

```ini
PORT=5000
JWT_SECRET=simple_chat_secret_key_change_in_production_2026
DATABASE_URL=./database.sqlite
CLIENT_URL=http://localhost:5173
NODE_ENV=development
```

---

### Step 3: Seed Database with Demo Users

Run the seed script in the `server` directory to populate demo accounts and initial conversations:

```bash
# In the server folder:
npm run seed
```

This creates 3 demo accounts (all with password `password123`):
- 👤 **Alice**: `alice@example.com` / `password123`
- 👤 **Bob**: `bob@example.com` / `password123`
- 👤 **Charlie**: `charlie@example.com` / `password123`

---

### Step 4: Start the Backend and Frontend

Open two terminal windows:

#### Terminal 1 — Backend Server:
```bash
cd server
npm run dev
```
*The server will start on `http://localhost:5000`.*

#### Terminal 2 — Frontend Client:
```bash
cd client
npm run dev
```
*The Vite development server will open on `http://localhost:5173`.*

---

## 🧪 Running Automated Tests

Run the backend and real-time Socket.IO test suite:

```bash
cd server
npm test
```

**Test Coverage Highlights (22 Passing Tests):**
- ✅ User registration with valid inputs & validation error handling
- ✅ Email duplication & password mismatch rejection
- ✅ Secure login with password verification
- ✅ Protected route rejection without JWT token
- ✅ Listing conversations and filtering users via search
- ✅ Message creation, retrieval, and recipient validation
- ✅ Socket.IO token handshake authentication
- ✅ Real-time message emission and delivery without page refresh
- ✅ Presence tracking (`user_online` and `user_offline` events)
- ✅ Database message persistence verification

---

## 📡 API Documentation

### Authentication (`/api/auth`)

#### `POST /api/auth/register`
Create a new user account.
```json
// Request Body
{
  "username": "johndoe",
  "email": "john@example.com",
  "password": "password123",
  "confirmPassword": "password123"
}

// Response (201 Created)
{
  "success": true,
  "message": "Account created successfully.",
  "data": {
    "user": {
      "id": 4,
      "username": "johndoe",
      "email": "john@example.com",
      "created_at": "2026-09-27 13:00:00",
      "last_seen": "2026-09-27 13:00:00"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5c..."
  }
}
```

#### `POST /api/auth/login`
Authenticate user with email and password.
```json
// Request Body
{
  "email": "john@example.com",
  "password": "password123"
}

// Response (200 OK)
{
  "success": true,
  "message": "Logged in successfully.",
  "data": {
    "user": { ... },
    "token": "eyJhbGciOiJIUzI1NiIsInR5c..."
  }
}
```

#### `GET /api/auth/me`
Retrieve currently logged-in user profile (Requires `Authorization: Bearer <token>`).

---

### Users (`/api/users`)

#### `GET /api/users`
List other users and conversations (annotated with latest message snippet, timestamp, and online status). Supports `?search=term`.

#### `GET /api/users/:id`
Get single user details by ID.

---

### Messages (`/api/messages`)

#### `GET /api/messages/:userId`
Fetch chronological message history between the logged-in user and `:userId`.

#### `POST /api/messages`
HTTP fallback endpoint to send a message.
```json
// Request Body
{
  "receiverId": 2,
  "content": "Hello from SimpleChat!"
}
```

---

## ⚡ Socket.IO Real-Time Events

| Event Name | Direction | Payload | Description |
|---|---|---|---|
| `connection` | Client ↔ Server | Handshake `{ auth: { token } }` | Authenticates connection and joins user room `user_<id>` |
| `send_message` | Client → Server | `{ receiverId: number, content: string }` | Client sends message; server validates, saves to DB, and forwards to recipient |
| `receive_message` | Server → Client | `{ id, sender_id, receiver_id, content, created_at }` | Real-time message delivered to receiver and sender |
| `typing` | Client → Server | `{ receiverId: number, isTyping: boolean }` | Notifies receiver that user is typing |
| `user_typing` | Server → Client | `{ senderId: number, isTyping: boolean }` | Displays live typing bubble to recipient |
| `online_users_list` | Server → Client | `[userId1, userId2, ...]` | Sent on connection with all currently active user IDs |
| `user_online` | Server → Client | `{ userId, username }` | Broadcasted when a user connects |
| `user_offline` | Server → Client | `{ userId, lastSeen }` | Broadcasted when a user disconnects |
| `disconnect` | Client → Server | - | Updates `last_seen` in database and notifies users |

---

## 🧪 Acceptance Test Walkthrough

To verify the complete real-time messaging flow manually:

1. **User A Login**:
   - Open `http://localhost:5173` in Browser 1 (e.g. Chrome).
   - Click **Quick Demo Login: Alice** (or sign in with `alice@example.com` / `password123`).
2. **User B Login**:
   - Open `http://localhost:5173` in an Incognito window or Browser 2 (e.g. Edge / Firefox).
   - Click **Quick Demo Login: Bob** (or sign in with `bob@example.com` / `password123`).
3. **Check Live Presence**:
   - In Alice's window, Bob will show a green **● Online** indicator badge.
   - In Bob's window, Alice will show as **● Online**.
4. **Real-Time Message Exchange**:
   - In Alice's window, select Bob from the sidebar.
   - Type `"Hello Bob! Testing real-time chat."` and press **Enter**.
   - Watch Bob's window: the message appears instantly on the left without any page reload.
   - In Bob's window, reply `"Hi Alice! It works instantly!"`.
   - Watch Alice's window: the reply appears immediately on the left.
5. **Persistence Check**:
   - Refresh both browser tabs.
   - Re-open the conversation between Alice and Bob.
   - All sent and received messages remain preserved in order from SQLite!

---

## 🛠️ Common Troubleshooting

| Issue | Solution |
|---|---|
| Port 5000 already in use | Change `PORT` in `server/.env` to another port (e.g. `5001`) and update `client/vite.config.js` proxy. |
| Socket connection error | Make sure the backend server is running and reachable on `http://localhost:5000`. |
| Login fails after database reset | Run `npm run seed` in the `server` directory to regenerate demo accounts. |

---

## 🔮 Future Improvements

- 👥 **Group Chats & Channels**: Multi-user rooms with participant management.
- 📎 **File & Media Sharing**: Upload images, voice notes, and document attachments.
- 👁️ **Read Receipts**: Blue double checkmarks when messages are seen by recipient.
- 🔔 **Push Notifications**: Web push notifications for background alerts.
- 😀 **Message Reactions & Emojis**: React to messages with emoji icons.
- ✏️ **Message Editing & Deletion**: Edit or soft-delete sent messages.
- 🔒 **End-to-End Encryption (E2EE)**: Client-side asymmetric key encryption.
- 📞 **Audio & Video Calls**: WebRTC peer-to-peer audio and video calling.

---

## 📄 License

MIT License. Built for learning and building real-time full-stack web applications!
