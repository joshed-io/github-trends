require 'keen'
require 'pushpop-github'

%w(
  pushpop-project/pushpop
  pushpop-project/pushpop-starter
  pushpop-project/pushpop-recipes
  dzello/mongoid_alize
  dzello/aud
  dzello/four
  keenlabs/keen-gem
  keenlabs/keen-js
  keenlabs/pingpong
).each do |repo|

  github_user, github_repo = lambda { repo.split('/') }.call

  job do

    every 1.hour

    github do
      user        github_user
      repository  github_repo
    end

    step do |repository, _|
      Keen.publish("repositories_snapshots", repository.to_hash)
      puts "Logged #{repo} stats"
    end

  end

end
