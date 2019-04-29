require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new do |i|
  i.libs << 'test'
  i.test_files = FileList['test/test_*.rb']
end

task default: :test
