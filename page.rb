require 'mongo'
require 'mongoid'

# gem install bson_ext
databaseName = "web"

connection = Mongo::Connection.new
Mongoid.database = connection[databaseName]

class Page

	include Mongoid::Document

	field :title, type: String

end

page = Page.new
page.title = "epsi"
page.save

