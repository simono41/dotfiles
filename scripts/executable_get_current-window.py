#!/usr/bin/env python
# Prints list of windows in the current workspace.

import sys
if sys.platform == "darwin":
    from AppKit import NSWorkspace
    from Quartz import (
        CGWindowListCopyWindowInfo,
        kCGWindowListOptionOnScreenOnly,
        kCGNullWindowID
    )

if sys.platform == "darwin":
    get_this = sys.argv[1]
    curr_app = NSWorkspace.sharedWorkspace().frontmostApplication()
    curr_pid = NSWorkspace.sharedWorkspace().activeApplication()['NSApplicationProcessIdentifier']
    curr_app_name = curr_app.localizedName()
    options = kCGWindowListOptionOnScreenOnly
    windowList = CGWindowListCopyWindowInfo(options, kCGNullWindowID)
    for window in windowList:
        pid = window['kCGWindowOwnerPID']
        windowNumber = window['kCGWindowNumber']
        ownerName = window['kCGWindowOwnerName']
        geometry = window['kCGWindowBounds']
        windowTitle = window.get('kCGWindowName', u'Unknown')
        if curr_pid == pid:
            if get_this == "all":
                print("%s - %s (PID: %d, WID: %d): %s" % (
                ownerName, windowTitle.encode('ascii', 'ignore'), pid, windowNumber, geometry))
            elif get_this == "pid":
                print(pid)
            elif get_this == "title":
                print(ownerName)
elif sys.platform == "win32":
    (active_app_name, windowTitle) = _getActiveInfo_Win32()

