# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "chromaprint"
  gem.homepage = "https://github.com/TMXCredit/chromaprint"
  gem.license = "MIT"
  gem.summary = %Q{Port of Chromaprint library to Ruby}
  gem.description = %Q{A client-side library that implements a custom algorithm for extracting fingerprints from any audio source}
  gem.authors = ['TMX Credit'            , 'Potapov Sergey']
  gem.email   = ['rubygems@tmxcredit.com', 'blake131313@gmail.com']
  gem.files = Dir["lib/**/*"] + Dir['README.markdown', 'LICENSE.txt']
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "chromaprint #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
