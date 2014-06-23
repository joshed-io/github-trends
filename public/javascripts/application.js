// Delete these three lines once you have your environment variables set
// The environment-configured 'keen' variable is set in layout.erb

Keen.ready(function(){

  // ----------------------------------------
  // Pageviews Area Chart
  // ----------------------------------------
  var repos_timeline = new Keen.Query("maximum", {
    eventCollection: "repository_snapshots",
    targetProperty: "stargazers_count",
    interval: "daily",
    groupBy: "full_name",
    timeframe: "this_210_hours"
  });

  keenClient.draw(repos_timeline, document.getElementById("chart-01"), {
    chartType: "areachart",
    title: false,
    height: 250,
    width: "auto",
    chartOptions: {
      chartArea: {
        height: "85%",
        left: "5%",
        top: "5%",
        width: "80%"
      },
      isStacked: false
    }
  });

  var repos_now = new Keen.Query("maximum", {
    eventCollection: "repository_snapshots",
    targetProperty: "stargazers_count",
    groupBy: "full_name",
    timeframe: "this_1_hour"
  });

  keenClient.draw(repos_now, document.getElementById("chart-02"), {
    chartType: "piechart",
    title: false,
    height: 250,
    width: "auto",
    chartOptions: {
      chartArea: {
        height: "85%",
        left: "5%",
        top: "5%",
        width: "100%"
      }
    }
  });

});
