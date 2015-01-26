require 'mongo'
require 'mongoid'

connection = Mongo::Connection.new
Mongoid.database = connection["web"]

class Page

	include Mongoid::Document

	field :title, type: String, :defaul => ''
	field :url, type: String, :defaul => ''
	field :keywords, type: Array
	field :description, type: String, :defaul => ''

end