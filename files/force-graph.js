// This example is based on https://bl.ocks.org/mbostock/950642

function render(id, json) {
    var width = $(id).width(),
        height = 500
  
    var svg = d3.select(id).append("svg")
        .attr("width", width)
        .attr("height", height);
  
    var force = d3.layout.force()
        .gravity(0.05)
        .distance(150)
        .charge(-100)
        .size([width, height]);
  
    force
        .nodes(json.nodes)
        .links(json.links)
        .start();
  
    var link = svg.selectAll(".link")
        .data(json.links)
      .enter().append("line")
        .attr("class", "link");
  
    var node = svg.selectAll(".node")
        .data(json.nodes)
      .enter().append("g")
        .attr("class", "node")
        .call(force.drag);
  
    node.append("image")
        .attr("xlink:href", "https://lzone.de/images/host_icon.png")
        .attr("x", -8)
        .attr("y", -8)
        .attr("width", 16)
        .attr("height", 16);
  
    node.append("text")
        .attr("dx", 12)
        .attr("dy", ".35em")
        .text(function(d) { return d.name });
  
    force.on("tick", function() {
      link.attr("x1", function(d) { return d.source.x; })
          .attr("y1", function(d) { return d.source.y; })
          .attr("x2", function(d) { return d.target.x; })
          .attr("y2", function(d) { return d.target.y; });
  
      node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
    });
  }
  // End of mbostock example
  
  // Parsing netstat connections and preparing force data
  function refresh() {
          var data = parse('#source');
          render('#graph', data);
      }
  
  function parse(id) {
    var hostNames = [];
      var results = $(id).val()
      .split(/\n/)
      .map(function(line) {
          return line.split(/\s+/);
      })
      .filter(function(line) {
          if(line.length < 6)
              return false;
          if(line[3].indexOf('127') === 0 &&
             line[4].indexOf('127') === 0)
              return false;
          if(line[5] === 'LISTEN')
              return false;
          return line[0].indexOf('tcp') === 0;
      })
      .map(function(line) {
      var host = line[3].split(/:/)[0];
      var rn   = line[4].split(/:/)[0];
      if(-1 === hostNames.indexOf(host))
          hostNames.push(host);
      if(-1 === hostNames.indexOf(rn))
          hostNames.push(rn);
      
      var link = {
              "source" : hostNames.indexOf(host),
              "target" : hostNames.indexOf(rn),
        value  : 1
          };
      console.log(link);
          return link;
      });
    console.log(JSON.stringify({ nodes: hostNames, links: results }));
      return {
        nodes: hostNames.map(function(h) { return { name: h } }),
      links: results
    };
  }
  
  refresh();