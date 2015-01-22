require './models/crawlerWorker.rb'


# Clean the Collection
connection = Mongo::Connection.new
Mongoid.database = connection["web"]
Mongoid.database.collection("pages").drop

while true do
	
	crawlerWorker = CrawlerWorker.new
	crawlerWorker.startListening

	sleep 5

end