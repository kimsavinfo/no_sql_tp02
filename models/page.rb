require 'mongo'
require 'mongoid'


class Page

	include Mongoid::Document

	field :title, type: String, :defaul => ''
	field :url, type: String, :defaul => ''
	field :keywords, type: Array, :defaul => ''
	field :description, type: String, :defaul => ''

end