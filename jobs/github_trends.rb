require 'keen'
require 'pushpop-github'

%w(
  github
).each do |organization_name|

  job do

    every 1.hour

    step do
      # todo add this functionality into the plugin
      Github::Repos.new(user: organization_name).list(auto_pagination: true)
    end

    step do |repositories, _|
      Keen.publish_batch(repository_snapshots: repositories.map(&:to_hash))
      puts "Logged #{repositories.size} repositories for #{organization_name}"
    end

  end

end
