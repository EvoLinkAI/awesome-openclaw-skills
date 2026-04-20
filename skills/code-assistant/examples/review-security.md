# Example: Security Review

## Prompt

```
Review this authentication code for security vulnerabilities
```

## Input Code (auth.py)

```python
import sqlite3
from flask import request

def login(username, password):
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    
    # Check credentials
    query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
    cursor.execute(query)
    user = cursor.fetchone()
    
    if user:
        return {"status": "success", "user_id": user[0]}
    return {"status": "failed"}
```

## Review Output

```
🔴 CRITICAL: SQL Injection Vulnerability (Line 9)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Issue: Direct string interpolation in SQL query allows SQL injection attacks.

Vulnerable Code:
    query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"

Attack Example:
    username = "admin' OR '1'='1"
    password = "anything"
    # Results in: SELECT * FROM users WHERE username='admin' OR '1'='1' AND password='anything'
    # This bypasses authentication!

Fix: Use parameterized queries
    query = "SELECT * FROM users WHERE username=? AND password=?"
    cursor.execute(query, (username, password))

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔴 CRITICAL: Plain Text Password Storage (Line 9)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Issue: Passwords are stored and compared in plain text.

Current Approach:
    Storing passwords as-is in the database

Fix: Use password hashing
    from werkzeug.security import generate_password_hash, check_password_hash
    
    # When storing:
    hashed = generate_password_hash(password)
    
    # When checking:
    if check_password_hash(stored_hash, provided_password):
        # Valid

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🟡 WARNING: No Connection Cleanup (Line 5)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Issue: Database connection is never closed, leading to resource leaks.

Fix: Use context manager
    with sqlite3.connect('users.db') as conn:
        cursor = conn.cursor()
        # ... rest of code

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Summary:
  🔴 Critical: 2
  🟡 Warning: 1
  🟢 Info: 0

Recommendation: Fix critical issues immediately before deploying to production.
```

## Fixed Code

```python
import sqlite3
from flask import request
from werkzeug.security import check_password_hash

def login(username, password):
    with sqlite3.connect('users.db') as conn:
        cursor = conn.cursor()
        
        # Use parameterized query to prevent SQL injection
        query = "SELECT id, password_hash FROM users WHERE username=?"
        cursor.execute(query, (username,))
        user = cursor.fetchone()
        
        if user and check_password_hash(user[1], password):
            return {"status": "success", "user_id": user[0]}
        return {"status": "failed"}
```

## Verification

All security issues resolved:
- ✅ SQL injection prevented via parameterized queries
- ✅ Passwords hashed using industry-standard algorithm
- ✅ Database connections properly managed
