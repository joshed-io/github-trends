require 'sinatra'

class App < Sinatra::Base

  get '/' do
    erb :index, :locals => { 
      :keen => {
        :project_id => ENV['KEEN_PROJECT_ID'],
        :read_key => ENV['KEEN_READ_KEY'],
        :write_key => ENV['KEEN_WRITE_KEY']
      }
    }
  end

  require_relative 'jobs/github_trends'
  Pushpop.schedule
  Thread.new {
    Clockwork.manager.run
  }

end
