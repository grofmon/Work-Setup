--
--  Work Setup.applescript
--  Work Setup
--
--  Created by Monty on 9/24/12.
--  Copyright (c) 2012 taolam. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
    -- this property will be used to configure our notification
	property myNotification : missing value
    
    property theAppName : "Work Setup"
    property theSetMessage : "All Work Applications have been started."
    property theWorkList : {"Calendar", "Evernote", "Reminders", "Adium"}
	
	on applicationWillFinishLaunching_(aNotification)
        repeat with theApp in theWorkList
            if utilAppIsRunning(theApp) is false then
                tell application theApp to activate
                delay 2
                -- Hide the application
                tell application "System Events"
                    set visible of process theApp to false
                end tell
            end if
        end repeat
        
        sendNotificationWithTitle_AndMessage_(theAppName,theSetMessage)
        
        quit
        
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits
		return current application's NSTerminateNow
	end applicationShouldTerminate_
    
    on utilAppIsRunning(appName)
        tell application "System Events" to set appNameIsRunning to exists (processes where name is appName)
        if appNameIsRunning is true then
            log appName & " is already running"
            else
            log appName & " is not running"
        end if
        return appNameIsRunning
    end utilAppIsRunning
    
	-- Method for sending a notification based on supplied title and text
	on sendNotificationWithTitle_AndMessage_(aTitle, aMessage)
		set myNotification to current application's NSUserNotification's alloc()'s init()
		set myNotification's title to aTitle
		set myNotification's informativeText to aMessage
		current application's NSUserNotificationCenter's defaultUserNotificationCenter's deliverNotification_(myNotification)
	end sendNotification
    
end script