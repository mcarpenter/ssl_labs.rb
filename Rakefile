require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'rdoc/task'
require 'rubygems/package_task'

load File.join(File.dirname(__FILE__), 'lib', 'ssl_labs', 'version.rb')

desc 'Default task (package)'
task :default => [:package]

Rake::TestTask.new('test')

SPECFILE = 'ssl_labs.gemspec'
if File.exist?(SPECFILE)
  spec = eval(File.read(SPECFILE))
  Gem::PackageTask.new(spec).define
end

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'ssl_labs'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.options << '--all'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include(FileList['lib/**/*'])
  rdoc.rdoc_files.include(FileList['test/**/*'])
end
