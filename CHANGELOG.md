## v0.9.1

- Fix default arrow size being the normal size, instead of none
- Increase waypoint reached default to 50

## v0.9.0

Feature: Waypoints!

- Fix changing arrow sizes settings
- Add ability to receive external waypoints
- Add ability to see the direction to a waypoint
- Add setting to configure when a waypoint is reached and the next waypoint will be used

## v0.8.3

- Fix a memory leak on views due to update timers not releasing their subscribee
- Update version number because I forgot since v0.7.0... oops.

## v0.8.2

- Fix time format being swapped

## v0.8.1

- Add fitFields for Gp3s projects like gps-speedsurfing

## v0.7.0

Features
- Replace average speed over x seconds instead of max speed over x seconds
- Add average 30m and 60m.
- Add max average view 
- Add max average data fields for 2s 10s, 30m and 60m 
- Add back from activity recording menu to prevent stopping recording when accidentally pressing the start/stop button

Bugfix
- Remove safety checks on interacting with the activity. It seems some actions and UI updates can lack behind to we shouldn't throw on invalid state, we just ignore it for now.
- Reduce usage of timers using a global app timer.

## v0.6.3

- 1Fix speed aggregation memory leak and working

## v0.6.2

- Bugfix datafield creation for 2s and 10s max speed

## v0.6.1

- Bugfix invalid check for Instinct Solar devices

## v0.6.0

- Introduce special cases for Instinct 3 Solar, Instinct 2 Solar, Instinct 2S Solar, Instinct 2X Solar to move the top right quarter into the extra watch window.

## v0.5.2

- Reduce memory and system load by lazy initializing views when required


## v0.4.0

Mapview for supported devices

- Add mapview with your waypoint on it
- Set minimum API to 3.1.0 and add all devices

## v0.3.0

Add background option and about menu

- Add background setting
- Add about menu
- Add handling of setting device settings through connect app

## v0.2.0

Conversions and fixes

- Added unit conversion for imperial units
- Add fit field meta data
- Add A WAY TO EXIT THE APP.... using the back button

## v0.1.0

Initial release

- Add pointer to starting location
- Add two views, one with overall information, one with speed information
- Add 2s and 10s speed max
