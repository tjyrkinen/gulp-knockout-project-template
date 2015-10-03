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
  template: fs.readFileSync(__dirname + '/../../../public/components/#{tagName}.html', 'utf8')
"""

# cmd = """sed -i .bk '/#COMPONENTS/a\\
# #{componentRegister}' #{srcPath}/js/components/index.coffee"""
# if exec(cmd).status != 0
#   console.log 'Failed inserting require line into main.coffee'
#   process.exit(1)

console.log 'Updated components/index.coffee'

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