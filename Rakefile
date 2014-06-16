$stdout.sync = true

$: << File.join(File.dirname(__FILE__), './lib')

begin
  require 'rspec/core/rake_task'
  desc 'Run Rspec unit tests'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/**/*_spec.rb'
  end

  task default: :spec
rescue LoadError
end

def require_jobfiles(args)
  require 'pushpop'
  if jobfile = args[:jobfile]
    load "#{File.dirname(__FILE__)}/#{jobfile}"
  else
    Dir.glob("#{File.dirname(__FILE__)}/jobs/**/*.rb").each { |file|
      require file
    }
  end
end

namespace :jobs do
  desc 'Describe jobs'
  task :describe, :jobfile do |_, args|
    require_jobfiles(args)
    Pushpop.jobs.each do |job|
      puts job.name
    end
  end

  desc 'Run each job once'
  task :run_once, :jobfile do |_, args|
    require_jobfiles(args)
    Pushpop.run
  end

  desc 'Run jobs ongoing'
  task :run, :jobfile do |_, args|
    require_jobfiles(args)
    Pushpop.schedule
    Clockwork.manager.run
  end
end
