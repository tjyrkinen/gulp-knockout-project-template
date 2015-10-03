###
THIS IS AN AUTOMTICALLY MANAGED FILE
YOU SHOULD NOT EDIT THIS FILE
###

ko = require 'knockout'
fs = require 'fs'

#COMPONENTS
ko.components.register 'app-main',
  viewModel: require './app-main'
  template: fs.readFileSync(__dirname + '/../../../public/components/app-main.html', 'utf8')
