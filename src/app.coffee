window.App= Ember.Application.create
  LOG_TRANSITIONS: true

App.ApplicationAdapter = DS.LSAdapter.extend
  namespace: 'tiger'
