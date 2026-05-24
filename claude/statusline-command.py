#!/usr/bin/env python3
import json
import subprocess
import sys
from pathlib import Path

data = json.load(sys.stdin)

# Path
cwd = data.get("cwd", "")
home = str(Path.home())
cwd_display = "~" + cwd[len(home):] if cwd.startswith(home) else cwd

# Model + effort
model_short = data.get("model", {}).get("display_name", "")
effort = data.get("effort", {}).get("level", "")
if effort:
    model_short = f"{model_short} [{effort}]"

# Git branch
try:
    branch = subprocess.check_output(
        ["git", "-C", cwd, "--no-optional-locks", "branch", "--show-current"],
        stderr=subprocess.DEVNULL, text=True
    ).strip()
except Exception:
    branch = ""

# Context
used = data.get("context_window", {}).get("used_percentage")
ctx_display = f"{used:.0f}% used" if used is not None else ""

# Rate limits
rl = data.get("rate_limits", {})
five_hour = rl.get("five_hour", {}).get("used_percentage")
seven_day = rl.get("seven_day", {}).get("used_percentage")
quota_parts = []
if five_hour is not None:
    quota_parts.append(f"5h:{five_hour:.0f}%")
if seven_day is not None:
    quota_parts.append(f"7d:{seven_day:.0f}%")
quota_display = " ".join(quota_parts)

# Truncate path: keep leading prefix before first /, show last 3 segments
# e.g. ["~", "a", "b", "c", "d"] -> "~/.../b/c/d"
parts = cwd_display.split("/")
if len(parts) > 4:
    prefix = parts[0]
    last3 = "/".join(parts[-3:])
    cwd_display = f"{prefix}/.../{last3}"

# Column widths
col_ws = len(cwd_display) + 2
col_br = 8
col_md = len(model_short) + 2
col_ctx = 11

DIM = "\033[2m"
RESET = "\033[0m"

header = (
    f"{DIM}"
    f"{'workspace':<{col_ws}}"
    f"{'branch':<{col_br}}"
    f"{'model':<{col_md}}"
    f"{'context':<{col_ctx}}"
    f"{'quota'}"
    f"{RESET}"
)
values = (
    f"{cwd_display:<{col_ws}}"
    f"{branch:<{col_br}}"
    f"{model_short:<{col_md}}"
    f"{ctx_display:<{col_ctx}}"
    f"{quota_display}"
)

print(header)
print(values)
