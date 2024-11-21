require 'sidekiq'

class SimpleSidekiqJob
  include Sidekiq::Job

  def perform(*args)
    puts "Afzal's Sidekiq: Job is performed with arguments: #{args.inspect}"
  end
end
