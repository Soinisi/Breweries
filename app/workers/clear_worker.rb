class ClearWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
	
	#recurrence { daily }
  
  def perform(name, location)
  	expire_fragment(name)
		write_fragment(name, location)
	end
end
