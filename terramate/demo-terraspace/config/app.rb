Terraspace.configure do |config|
  config.logger.level = :info
  config.build.copy_modules = true
  # Nombre de stacks lancées en parallèle dans un lot de « all »
  config.all.concurrency = 4
end
