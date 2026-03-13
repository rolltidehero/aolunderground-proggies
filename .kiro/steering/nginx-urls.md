---
inclusion: always
description: Nginx URL convention — always use "linux" as the hostname, never an IP address.
---

# Nginx URL Rules

The dev server hostname is **linux**, not an IP address. Always use:

```
http://linux:8088/
```

When providing URLs to the user, ALWAYS use `http://linux:8088/...` — never `192.168.5.175` or `localhost`.
