window.App= Ember.Application.create
  LOG_TRANSITIONS: false 

App.ApplicationAdapter = DS.LSAdapter.extend
  namespace: 'myblog'
