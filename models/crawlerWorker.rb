require 'redis'
require 'json'
require 'mechanize'
require 'mongo'
require 'mongoid'
require './models/worker.rb'
require './models/page.rb'

class CrawlerWorker < Worker

	def startListening
		currentJob = @redis.lpop("jobsToDo")

		if !currentJob.nil?
			jobParsed = JSON.parse currentJob
			job = Worker.new
			job.setJob(jobParsed['task'], jobParsed['url'])

			puts "======================================"
			puts "#{job.task} on #{job.url}"
			saveWebPage(job.url)
			@redis.rpush('jobsDone', job.toJson)

			#self.showJobsToDo
			#self.showJobsDone
		end
	end

	def saveWebPage(url)
		connection = Mongo::Connection.new
		Mongoid.database = connection["web"]

		webPage = Mechanize.new.get(url)
		page = Page.new
		page.title = webPage.title
		page.url = url

		keywords = webPage.at('meta[@name="keywords"]')
		if(!keywords.nil?)
			page.keywords = keywords[:content].split(",")
		end
		
		descrition = webPage.at('meta[name="description"]')
		if(!descrition.nil?)
			page.description = descrition[:content]
		end

		page.save

		puts "Saved : #{webPage.title}"
		puts "======================================"
	end

	def showJobsToDo
		jobsToDoCount = @redis.llen 'jobsToDo'
		puts "Jobs that need to be done #{jobsToDoCount} :"
		puts @redis.lrange("jobsToDo", 0, -1)
	end

	def showJobsDone
		jobsDoneCount = @redis.llen 'jobsDone'
		puts "Done jobs #{jobsDoneCount} :"
		puts @redis.lrange("jobsDone", 0, -1)
	end
end