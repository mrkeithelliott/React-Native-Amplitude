//  Created by react-native-create-bridge

import { NativeModules } from 'react-native'

const { PVAmplitudeBridge } = NativeModules

export default {
  initializeApiKey(key) {
    PVAmplitudeBridge.initializeApiKey(key)
  },

  logEvent(eventName) {
    PVAmplitudeBridge.logEvent(eventName)
  },

  logEventWithProperties(eventName, eventPropertiesDictionary) {
    PVAmplitudeBridge.logEventWithProperties(eventName, eventPropertiesDictionary)
  },

  logEventWithPropertiesAndSession(eventName, eventPropertiesDictionary, isOutOfSession) {
    PVAmplitudeBridge.logEventWithPropertiesAndSession(eventName, eventPropertiesDictionary, isOutOfSession)
  },

  logEventWithGroups(eventName, eventPropertiesDictionary, groups) {
    PVAmplitudeBridge.logEventWithGroups(eventName, eventPropertiesDictionary, groups)
  },

  logEventWithGroupsAndSession(eventName, eventPropertiesDictionary, groups, isOutofSession) {
    PVAmplitudeBridge.logEventWithGroupsAndSession(eventName, eventPropertiesDictionary, groups, isOutofSession)
  },

  trackSessions(shouldTrack) {
    PVAmplitudeBridge.trackSessions(shouldTrack)
  },

  minTimeBetweenSessionsMillis(timeInMillis) {
    PVAmplitudeBridge.minTimeBetweenSessionsMillis(timeInMillis)
  },

  // returns a promise
  getCurrentSessionId() {
    return PVAmplitudeBridge.getCurrentSessionId();
  },

  setUserId(userId) {
    PVAmplitudeBridge.setUserId(userId)
  },

  logOut() {
    PVAmplitudeBridge.logOut()
  },

  identifySet(key, value) {
    PVAmplitudeBridge.identifySet(key, value)
  },

  identifySetOnce(key, value) {
    PVAmplitudeBridge.identifySetOnce(key, value)
  },

  identifyUnset(key) {
    PVAmplitudeBridge.identifyUnset(key)
  },

  identifyAdd(key, value) {
    PVAmplitudeBridge.identifyAdd(key, value)
  },

  identifyAppendArray(key, value) {
    PVAmplitudeBridge.identifyAppendArray(key, value)
  },

  identifyAppendDictionary(key, value) {
    PVAmplitudeBridge.identifyAppendDictionary(key, value)
  },

  identifyPrependArray(key, value) {
    PVAmplitudeBridge.identifyPrependArray(key, value)
  },

  identifyPrependDictionary(key, value) {
    PVAmplitudeBridge.identifyPrependDictionary(key, value)
  },

  clearUserProperties() {
    PVAmplitudeBridge.clearUserProperties()
  }
}
