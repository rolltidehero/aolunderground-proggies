---
inclusion: always
description: Mandatory execution rules for long-running processes - ALWAYS use nohup
---

# Steering Rules for AOL Underground Proggies Project

## Command Execution Order
1. **ALWAYS verify logical order before executing commands**
2. **Create dependencies BEFORE using them** (directories before files, processes before logs)
3. **Never check output of commands that haven't run yet**

## Background Process Management
1. Create directories first
2. Start nohup/background process second
3. Wait/sleep third
4. Check logs/output fourth

## Testing Long-Running Scripts
- ALWAYS run via nohup with output to logs/ trace file
- NEVER run long scripts in foreground
- Watch the trace file to monitor progress and catch errors

## Error Prevention
- Verify file/directory exists before reading
- Check process started before tailing logs
- Validate paths before operations
