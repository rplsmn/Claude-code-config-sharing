---
name: Test-Driven Development
description: RED-GREEN-REFACTOR cycle for implementing features and bugfixes with tests before code
author: obra (superpowers)
source: https://github.com/obra/superpowers/tree/main/skills/test-driven-development
version: 1.0
---

# Test-Driven Development (TDD)

Use this skill when implementing **any feature or bugfix**.

## Core Principle

**"If you didn't watch the test fail, you don't know if it tests the right thing."**

## The RED-GREEN-REFACTOR Cycle

### 🔴 RED: Write a Failing Test

**FIRST, before ANY implementation code:**

1. Write a minimal test that demonstrates the desired behavior
2. Run the test and **watch it fail**
3. Verify it fails for the **right reason** (missing feature, not typo or syntax error)

**Example:**
```python
def test_user_can_login_with_valid_credentials():
    user = User.create(email="test@example.com", password="secret123")
    result = authenticate(email="test@example.com", password="secret123")
    assert result.success == True
    assert result.user.email == "test@example.com"
```

Run it → **FAILS** (authenticate() doesn't exist yet) ✅

### 🟢 GREEN: Make It Pass

**Write the SIMPLEST code to make the test pass:**

1. Implement just enough to turn the test green
2. No premature optimization
3. No extra features
4. Run the test and **watch it pass**

**Example:**
```python
def authenticate(email, password):
    user = User.find_by_email(email)
    if user and user.verify_password(password):
        return AuthResult(success=True, user=user)
    return AuthResult(success=False, user=None)
```

Run it → **PASSES** ✅

### ♻️ REFACTOR: Improve Without Breaking

**Clean up while keeping tests green:**

1. Remove duplication
2. Improve naming
3. Extract methods/classes
4. Run ALL tests after each change
5. If any test fails, revert and try again

**Example:**
```python
# Refactor: Extract validation logic
def authenticate(email, password):
    user = User.find_by_email(email)
    if self._is_valid_authentication(user, password):
        return AuthResult.success(user)
    return AuthResult.failure()

def _is_valid_authentication(self, user, password):
    return user is not None and user.verify_password(password)
```

Run tests → **ALL PASS** ✅

---

## Critical Rules

### ⛔ NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST

**If you write production code before the test:**
- **DELETE IT COMPLETELY**
- Don't keep it as reference
- Don't copy-paste during testing
- Start over with the test first

### ✅ Always Verify Each Step

**Don't skip verification:**
- ✅ Confirm test **fails** for the right reason
- ✅ Confirm test **passes** after implementation
- ✅ Confirm **all tests still pass** after refactoring

### 📝 One Behavior Per Test

**Good test:**
```python
def test_invalid_password_returns_failure():
    user = User.create(email="test@example.com", password="secret123")
    result = authenticate(email="test@example.com", password="wrong")
    assert result.success == False
```

**Bad test (multiple behaviors):**
```python
def test_authentication():
    # Tests login AND logout AND session creation
    ...
```

---

## Common Rationalizations (Don't Fall For These!)

### ❌ "I'll write tests after I finish coding"

**Problem:** Tests will pass immediately, proving nothing.

**Reality:** You're testing your implementation, not requirements.

**Solution:** Write the test FIRST, watch it fail.

---

### ❌ "I already manually tested this"

**Problem:** Manual testing is ad-hoc and won't catch regressions.

**Reality:** You'll forget the exact steps next time.

**Solution:** Automated tests document AND verify behavior.

---

### ❌ "This code is too simple to test"

**Problem:** Simple code still breaks during refactoring.

**Reality:** Tests enable confident changes later.

**Solution:** Simple code = simple tests (write them anyway).

---

### ❌ "I need to explore the solution first"

**Problem:** Exploration without tests leads to untested code.

**Reality:** Experiments become production code accidentally.

**Solution:** Use spike/prototype branch, then delete and TDD properly.

---

### ❌ "Tests are slowing me down"

**Problem:** You're measuring initial speed, not total time.

**Reality:** Debugging untested code takes 10x longer than writing tests.

**Solution:** Measure time to working, tested, refactored code.

---

## Testing Anti-Patterns to Avoid

### 🚫 Writing Tests After Implementation

**Why it's bad:**
- Tests confirm implementation, not requirements
- Easy to write tests that always pass
- Misses edge cases you didn't think of

**Instead:** Test FIRST, code second.

---

### 🚫 Testing Implementation Details

**Bad:**
```python
def test_uses_bcrypt_to_hash_password():
    # Tests HOW it works, not WHAT it does
    assert isinstance(user.password_hash, BCryptHash)
```

**Good:**
```python
def test_password_cannot_be_read_as_plaintext():
    user = User.create(password="secret")
    assert user.password != "secret"
    assert user.verify_password("secret") == True
```

---

### 🚫 Excessive Mocking

**Problem:** Tests break when refactoring even if behavior unchanged.

**Instead:** Use real objects when possible, mock only external dependencies.

---

### 🚫 One Giant Test

**Problem:** When it fails, you don't know which behavior broke.

**Instead:** One test per behavior, clear names.

---

## Verification Checklist

Before marking work complete, verify:

- [ ] **Every new function has a test**
- [ ] **Every test was written BEFORE the code**
- [ ] **Every test failed initially** (and I saw it fail)
- [ ] **Every test failed for the RIGHT reason** (not syntax errors)
- [ ] **Minimal code written** to make tests pass
- [ ] **All tests pass** with clean output
- [ ] **Code refactored** for clarity (without breaking tests)
- [ ] **No production code** exists without a corresponding test

---

## TDD Workflow Summary

```
1. 🔴 Write test → Run → FAIL ❌
          ↓
2. 🟢 Write code → Run → PASS ✅
          ↓
3. ♻️ Refactor → Run ALL → PASS ✅
          ↓
   Repeat for next behavior
```

---

## Example: Complete TDD Session

**Requirement:** Users can update their email address

### Step 1: RED (Write Failing Test)

```python
def test_user_can_update_email():
    user = User.create(email="old@example.com")
    user.update_email("new@example.com")
    user.save()

    reloaded_user = User.find(user.id)
    assert reloaded_user.email == "new@example.com"
```

Run → **FAILS** (update_email doesn't exist) ✅

### Step 2: GREEN (Implement)

```python
class User:
    def update_email(self, new_email):
        self.email = new_email
```

Run → **PASSES** ✅

### Step 3: Add Validation Test (RED)

```python
def test_cannot_update_to_invalid_email():
    user = User.create(email="valid@example.com")
    with pytest.raises(ValidationError):
        user.update_email("not-an-email")
```

Run → **FAILS** (no validation) ✅

### Step 4: GREEN (Add Validation)

```python
class User:
    def update_email(self, new_email):
        if not self._is_valid_email(new_email):
            raise ValidationError("Invalid email format")
        self.email = new_email

    def _is_valid_email(self, email):
        return "@" in email and "." in email
```

Run → **PASSES** ✅

### Step 5: REFACTOR

```python
# Extract validator class
class EmailValidator:
    @staticmethod
    def validate(email):
        if not ("@" in email and "." in email):
            raise ValidationError("Invalid email format")

class User:
    def update_email(self, new_email):
        EmailValidator.validate(new_email)
        self.email = new_email
```

Run ALL tests → **ALL PASS** ✅

---

## Benefits of TDD

✅ **Confidence:** Tests prove code works
✅ **Design:** Tests reveal design issues early
✅ **Refactoring:** Change code fearlessly
✅ **Documentation:** Tests show how to use code
✅ **Debugging:** Failing test pinpoints issue
✅ **Regression:** Catch bugs before deployment

---

## When to Use This Skill

**Always use TDD when:**
- Implementing new features
- Fixing bugs
- Refactoring existing code
- Adding API endpoints
- Building business logic
- Creating utilities

**Can skip TDD for:**
- Exploratory spikes (delete after)
- Proof-of-concept demos (not production)
- Configuration files
- Documentation

---

**Remember:** If you didn't see the test fail, you don't know if it tests the right thing. RED → GREEN → REFACTOR. Always.
