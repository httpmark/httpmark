const net = require('net');
const exec = require('child_process').exec;

function runMyProcess(socket) {
  const process = exec('/var/task/tasks.sh');
  process.stdout.setEncoding('utf-8');
  process.stdout.on('data', function(data) {
    socket.write(data);
  });
}

exports.handler = function(event, context, callback) {
  const taskRoot = process.env['LAMBDA_TASK_ROOT'] || __dirname;
  process.env.PATH += ':' + taskRoot;
  const client = new net.Socket();
  client.connect(event.tcpPort, event.tcpHost, function(){
	  runMyProcess(client);
	  setTimeout(function() {
	    return context.succeed();
	  }, 5000)
  });
}
