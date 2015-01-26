require './models/crawlerWorker.rb'

# Clean the Collection
connection = Mongo::Connection.new
Mongoid.database = connection["web"]
Mongoid.database.collection("pages").drop

crawlerWorker = CrawlerWorker.new
while true do
	
	crawlerWorker.doJob

	sleep 5

end