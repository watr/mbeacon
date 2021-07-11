# mbeacon
Turn your mac into an iBeacon.

# Installation

```
$ brew tap watr/formulae
...
$ brew install mbeacon
```

# How to use

```
$ defaults write mbeacon uuid -string "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
$ defaults write mbeacon measuredPower -integer -45
$ mbeacon -major 0 -minor 0
```

or 

```
$ defaults write mbeacon measuredPower -integer -45
$ mbeacon -uuid "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX" -major 0 -minor 0
```

## macOS 11 Big Sur - Security & Privacy

'mbeacon' requires Bluetooth permission

<img width="668" alt="image" src="https://user-images.githubusercontent.com/94398/125193622-50905d00-e288-11eb-94a1-9242559de1d4.png">


## Notes

### How to set measuredPower value?

You can't pass ```measuredPower``` value as ```mbeacon```'s command line argument. Because ```mbeacon``` failes to parse negative value. Use ```defaults``` command.

```
$ defaults write mbeacon measuredPower -integer -55
```

iBeacon's ```measuredPower``` value is RSSI value 1 meter away from beacon.

If you want to measure real RSSI value (easily, I think)
- Set ```mbeacon```'s ```measuredPower``` value around ```-55```
- Find beacon from iOS device with any iBeacon app that displays RSSI value
- Move iOS device 1 meter away from beacon

Update ```mbeacon```'s ```measuredPower``` value using real RSSI value 1 meter away from beacon.

```
# e.g. RSSI value 1 meter away from beacon is -45
$ defaults write mbeacon measuredPower -integer -45
$ mbeacon -uuid "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX" -major 0 -minor 0
```
