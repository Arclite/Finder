# Finder

An implementation of Find My iPhone for HomePod. For personal use only; I highly doubt this would be allowed in the App Store.

## Getting Started

Currently, Finder only works when run from Xcode. It uses environment variables to get your Apple ID and password in order to log into iCloud and hit the Find my iPhone API. In order to set this up: 
1. Go to "Edit Scheme…" for the Finder or Intent scheme.
2. Select the "Run" step.
3. Select the "Arguments" tab.
4. Add the following environment variables:
    - `FINDER_APPLE_ID`: Your iCloud Apple ID.
    - `FINDER_PASSWORD`: The password to the above Apple ID.
    - `FINDER_ALERT_NAME`: The name of the device you want to send an alert to.

    Once you've added those environment variables, running either scheme will trigger the "play sound" effect for Find my iPhone for the device you've named in `FINDER_ALERT_NAME`.
    
## License

This project is licensed under the [BSD 2-clause](http://choosealicense.com/licenses/bsd-2-clause/) license. If that doesn't work for you, send me an e-mail and I'll work something out.

## Next Steps

Future work, bugs, etc. will be tracked in the [repository issues](https://git.pado.name/pado/Finder/issues).
