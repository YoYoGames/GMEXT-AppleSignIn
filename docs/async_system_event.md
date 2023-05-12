@title The Asynchronous System Event

# The Asynchronous System Event

When using the Apple Sign In extension in your projects, you'll call different functions that trigger "callbacks" from the Apple API. What this means is that certain functions will be run but won't return a result until sometime in the future - which could be the next step, or it could be a few seconds later.

This result, when it comes, is called the "callback" and is Apple's Sign In API responding to something you’ve done. This callback is dealt with in the Asynchronous System Event.

This event will always have a DS map in the GML variable async_load, and this map can be parsed to get the required information. Each function will generate different callbacks, but they will all have the following key in common:

* **"id"** – This is the event ID key and it will hold a CONSTANT with the ID of the event that has been triggered. For example, if it's an event for authorising a user, then the constant will be  applesignin_signin_response / mac_applesignin_signin_response. See the different functions for details about the constants returned for each.

The rest of the key/value pairs in the map will depend on the function that triggered the Async Event and the ID of the event, and you should check the individual functions listed in the rest of this manual for exact details.
