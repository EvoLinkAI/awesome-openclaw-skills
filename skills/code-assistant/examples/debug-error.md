# Example: Debug Error

## Prompt

```
Debug the "list index out of range" error in data_processor.py
```

## Input Code (data_processor.py)

```python
def process_data(items):
    results = []
    for i in range(len(items)):
        # Process each item with its next neighbor
        current = items[i]
        next_item = items[i + 1]  # ❌ Error happens here
        
        combined = current + next_item
        results.append(combined)
    
    return results

# Usage
data = [1, 2, 3, 4, 5]
output = process_data(data)
print(output)
```

## Error Output

```
Traceback (most recent call last):
  File "data_processor.py", line 13, in <module>
    output = process_data(data)
  File "data_processor.py", line 6, in process_data
    next_item = items[i + 1]
IndexError: list index out of range
```

## Root Cause Analysis

```
🔍 Analysis:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Problem: Loop iterates through all indices (0 to len-1), but tries to access i+1

When i = 4 (last index):
  - items[4] = 5 ✅ Valid
  - items[5] = ??? ❌ Out of range (list only has indices 0-4)

The loop should stop one element earlier to avoid accessing beyond the list.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Fixed Code

```python
def process_data(items):
    results = []
    # Stop at len(items) - 1 to avoid index out of range
    for i in range(len(items) - 1):
        current = items[i]
        next_item = items[i + 1]
        
        combined = current + next_item
        results.append(combined)
    
    return results

# Usage
data = [1, 2, 3, 4, 5]
output = process_data(data)
print(output)
```

## Verification

```bash
$ python data_processor.py
[3, 5, 7, 9]
```

✅ **Success**: Code runs without errors and produces expected output (pairs of consecutive elements summed).

## Explanation

**What Changed:**
- `range(len(items))` → `range(len(items) - 1)`

**Why It Works:**
- Original: Loop ran from 0 to 4 (5 iterations)
- Fixed: Loop runs from 0 to 3 (4 iterations)
- Now `items[i + 1]` is always valid because i never reaches the last index

**Alternative Solution** (more Pythonic):

```python
def process_data(items):
    return [items[i] + items[i + 1] for i in range(len(items) - 1)]
```

Or using `zip`:

```python
def process_data(items):
    return [a + b for a, b in zip(items, items[1:])]
```
