# github-trends

Do analytics on Github repository trends over time.

Uses [Pushpop](https://github.com/pushpop-project/pushpop), and the [Github Plugin](https://github.com/pushpop-project/pushpop-github).

Make sure to set `KEEN_PROJECT_ID` and `KEEN_WRITE_KEY` on the environment.
If you're using foreman, drop them in a `.env` file.

### Usage

The list of repositories to watch is in [jobs/github_trends.rb](jobs/github_trends.rb).
Add and subtract to this list at your leisure.

To run:

``` shell
$ foreman run rake jobs:run
```

Every hour the repository stats will be pulled from the Github API and logged as an event to Keen IO.
Once you have some data collected you can use the Keen IO API and workbench to do analysis,
or create a dashboard that highlights the metrics you care about.
