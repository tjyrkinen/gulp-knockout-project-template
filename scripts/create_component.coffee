exec = require 'sync-exec'
_ = require 'lodash'
fs = require 'fs'
srcPath = './src'

tagName = process.argv.pop()
console.log 'Using tagname: ' + tagName

className = _.capitalize _.camelCase(tagName)

# Insert require into components loader
fs.appendFileSync "#{srcPath}/js/components/index.coffee", """\n
ko.components.register '#{tagName}',
  viewModel: require './#{tagName}'
  template: element: 'component-#{tagName}'
  synchronous: true
"""

console.log 'Updated components/index.coffee'

# Insert include for the component template
fs.appendFileSync "#{srcPath}/html/components/index.jade", """\n
template#component-#{tagName}
  include ./#{tagName}.jade
"""

console.log 'Updated components/index.jade'

# Create template file
if exec("echo \"p #{tagName}\" > #{srcPath}/html/components/#{tagName}.jade").status
  console.log 'Failed creating component .jade'
  process.exit(1)

console.log "Created #{tagName}.jade"

# Create coffee file
cmd = "sed s/{{TAGNAME}}/#{tagName}/ scripts/component_coffee.template | sed s/{{CLASSNAME}}/#{className}/ > #{srcPath}/js/components/#{tagName}.coffee"
if exec(cmd).status
  console.log 'Failed creating component .coffee'
  process.exit(1)

console.log "Created #{tagName}.coffee"

console.log 'All done'