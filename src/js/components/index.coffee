###
THIS IS AN AUTOMATICALLY MANAGED FILE BY SCRIPTS
###

ko = require 'knockout'
fs = require 'fs'

#COMPONENTS
ko.components.register 'app-main',
  viewModel: require './app-main'
  template: element: 'component-app-main'