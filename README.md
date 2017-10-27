# React-Native-Amplitude
React-Native wrapper for the Amplitude SDK
***
## Getting started
```
npm install rnamplitudebridge --save
```

### Include the Amplitude SDK
Include the Amplitude SDK in your project to make it available to the wrapper (bridge) library. You can find instructions for installing the SDK [here](https://github.com/amplitude/Amplitude-iOS). We recommend installing the SDK as a POD for your iOS project.  The PVAmplitudeBridge project will search for header files in the Pods directory.

### Linking the project
You need to link the pvamplitudebridge project so that it will be reachable in your project.
```
$ react-native link rnamplitudebridge
```

### Manual Installation
##### iOS
1. In Xcode, use the project navigator to add files to the `Libraries` folder by right clicking on `Add Files to [your project's name]`
2. Go to `node_modules` -> `rnamplitudebridge` and add `PVAmplitudeBridge.xcodeproj`
3. In Xcode, select your project in the project navigator.  Add the `libPVAmplitudeBridge.a` to your project's `Build Phases` -> `Link Binary With Libraries`
4. Run your project (`Cmd+R`)

### Usage
#### Initialize Amplitude
```javascript
import PVAmplitude from 'rnamplitudebridge'

PVAmplitude.initializeApiKey("[Enter your Amplitude API key]")
```

#### Track an Event
```javascript
PVAmplitude.logEvent("TestEvent-1")
```

#### Track an Event with Properties
```javascript
let properties = {propA: "value A", propB: "value B"}
PVAmplitude.logEventWithProperties("EventWithProperties", properties)
```

### Setting Event Properties
```javascript
logEvent(eventName)

logEventWithProperties(eventName, eventPropertiesDictionary) 

logEventWithPropertiesAndSession(eventName, eventPropertiesDictionary, isOutOfSession) 

logEventWithGroups(eventName, eventPropertiesDictionary, groups)

logEventWithGroupsAndSession(eventName, eventPropertiesDictionary, groups, isOutofSession)
```

### Tracking Sessions
```javascript
trackSessions(shouldTrack)

minTimeBetweenSessionsMillis(timeInMillis) 

// returns a promise
getCurrentSessionId()

logOut()
```

### Setting Custom User IDS and Setting User Properties
```javascript
setUserId(userId)

identifySet(key, value)

identifySetOnce(key, value) 
  
identifyUnset(key)

identifyAdd(key, value)

identifyAppendArray(key, value)

identifyAppendDictionary(key, value)

identifyPrependArray(key, value) 

identifyPrependDictionary(key, value)

clearUserProperties() 
```