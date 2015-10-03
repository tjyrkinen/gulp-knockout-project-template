console.log 'Script started.'

window.ko = ko = require 'knockout'
require 'knockout.punches'
ko.punches.enableAll()

require './components'

class Application
  constructor: ->

app = new Application
ko.applyBindings app


console.log 'Application initialized'
