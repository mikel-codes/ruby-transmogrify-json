require 'rake/testtask'

Rake::TestTask.new(:test) do |task|
  task.libs << 'test'
  task.libs << 'lib'
  task.pattern = 'test/*_test.rb'
end

task ci: ['test']
task :default => :test