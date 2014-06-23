# github-trends

Record your organization's Github repository statistics over time. Visualize the data using the included Sinatra-served dashboard:

![Example Github Trends Dashboard](http://f.cl.ly/items/0c3h3l2E1J1z1m1u3l1A/github_trends.png)

This dashboard shows the number of stars each repository has over time. More metrics can be added using basic JavaScript and HTML. To learn how see the [keen-js documentation](https://github.com/keenlabs/keen-js).

### Installation

Assumes a working Ruby 1.9+ environment.

Clone or fork this repository and install dependencies:

``` shell
$ git clone git@github.com:dzello/github-trends.git
$ cd github-trends
$ bundle install
```

github-trends uses [Keen IO](https://keen.io) to store repository data as it changes over time. Keen IO's free plan is enough to track a bunch of repositories, so head over and [signup](https://keen.io/signup) now.

Once you have a Keen IO account, create a new project and copy the project information and API keys into a `.env` file in the project root, like so:

```
KEEN_PROJECT_ID=aaaaaaaaaaaaaaa
KEEN_WRITE_KEY=xxxxxxxxxxxxxx
KEEN_READ_KEY=zzzzzzzzzzzzzzz
```

Next, modify the list of organizations you want to track. The list is in [jobs/github_trends.rb](jobs/github_trends.rb), just look for this line:

``` ruby
# add the organizations you'd like to track here
organizations = ["github"]

# ...
```

The default is to track only the [github organization](https://github.com/github). Note that all public repositories from each organization will be included.

### Usage

To start the combined data collection and web dashboard process run:

``` shell
$ foreman start
```

Every hour the repository stats will be pulled from the Github API and logged as events to Keen IO (1 per repository).
Once you have some data collected you can use the Keen IO API and workbench to do analysis or use the included dashboard. The included dashboard currently shows the number of Github stars for each repository. The plan is to add more visualizations in the future. Pitch in if this is interesting to you!

### Deployment

A Procfile is included so deploying to Heroku is easy. You will want to deploy this since it needs to run in an ongoing manner to collect the data needed to produce the dashboard.

Here are basic instructions to create a new Heroku app and deploy it:

``` shell
# make sure to commit any changes you made
$ git commit -am 'Added my organizations'

$ heroku create

# push vars in .env file to app config; requires heroku-config plugin
$ heroku config:push

# deploy
$ git push heroku master

# open the web interface
$ heroku open
```

Note - You might not see some data right away. That's because some of the query timeframes are set to end at the previous hour (not the current one). If you don't see any data wait an hour or head over to the Keen IO workbench and analyze it there.

### Credits

github-trends uses [Pushpop](https://github.com/pushpop-project/pushpop), and the [Github Pushpop Plugin](https://github.com/pushpop-project/pushpop-github).

The github-trends dashboard is based on the [dashboard sinatra starter](https://github.com/keenlabs/dashboard-starter-sinatra) kit from Keen IO.
