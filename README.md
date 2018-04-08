# Finder

An implementation of Find My iPhone for HomePod. For personal use only; I highly doubt this would be allowed in the App Store.

## Using Finder

The user interface for Finder is currently a bit of a hack job. Here are the steps to set up the app for use with HomePod:

1. Launch Finder.
2. Enter your Apple ID and password for iCloud.
3. Tap the "Log In" button.
3. Dismiss any two-factor authentication prompts that appear.
4. If logging in was unsuccessful, the app will return to the login form.
5. If logging in was successful, the app will begin updating the device list.

Once the device list finishes updating, you can now use Siri from either the device or HomePod to trigger Find my iPhone. The following command is simplest:

> Hey Siri, send a message using Finder.

This will trigger a "play sound" alert on the device that is set up to handle Personal Requests from HomePod, or the active device from any other iOS device (though this has dubious utility).

The following command is also available:

> Hey Siri, send a message to `<device name>` using Finder.

This allows you to send an alert to any device associated with your iCloud account.
    
## License

This project is licensed under the [BSD 2-clause](http://choosealicense.com/licenses/bsd-2-clause/) license. If that doesn't work for you, send me an e-mail and I'll work something out.

## Next Steps

Future work, bugs, etc. will be tracked in the [repository issues](https://git.pado.name/pado/Finder/issues).
