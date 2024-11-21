class SimpleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Afzal's testing: Yes! Simple Job is performed #{args.inspect}"
  end
end
