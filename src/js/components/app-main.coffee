ko = require 'knockout'

module.exports = class AppMain
  constructor: ({message}) ->
    @hello = ko.observable message