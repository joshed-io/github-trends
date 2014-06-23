# github-trends

Track and visualize your organization's Github repository statistics over time.

Uses [Pushpop](https://github.com/pushpop-project/pushpop), and the [Github Pushpop Plugin](https://github.com/pushpop-project/pushpop-github).

### Usage

Assumes a working Ruby 1.9+ environment.

Clone or fork this repository and install dependencies:

``` shell
$ git clone git@github.com:dzello/github-trends.git
$ cd github-trends
$ bundle install
```

github-trends uses [Keen IO](https://keen.io) to store repository changes over time. Keen IO's free plan is more than enough to track a large number of repositories, so head over and sign up now.

Once you have a Keen IO account, create a new project and copy the project information and API keys into a `.env` file in the project root, like so:

```
KEEN_PROJECT_ID=aaaaaaaaaaaaaaa
KEEN_WRITE_KEY=xxxxxxxxxxxxxx
KEEN_READ_KEY=zzzzzzzzzzzzzzz
```

Next, modify the list of organizations whose repositories you'd like to visualize. This list is specified in [jobs/github_trends.rb](jobs/github_trends.rb). All public repositories from each organization will be included.

To start the data collection and web dashboard processes simply run:

``` shell
$ foreman start
```

Every hour the repository stats will be pulled from the Github API and logged as events to Keen IO (1 per repository).
Once you have some data collected you can use the Keen IO API and workbench to do analysis or use the included dashboard. The included dashboard currently shows the number of Github stars for each repository over. The plan is to add more visualizations in the future.

### Deploy

A Procfile is included so deploying to Heroku is easy. You will want to deploy it so it runs in an ongoing manner, thus collecting the data needed to produce the dashboard.

Here are basic instructions to create a new Heroku app and deploy it:

``` shell
# make sure to commit any customizations you made
$ git commit -am 'Added my organizations'

$ heroku create

# push vars in .env file to app config; requires heroku-config plugin
$ heroku config:push 

# deploy
$ git push heroku master

# open the web interface
$ heroku open
```
