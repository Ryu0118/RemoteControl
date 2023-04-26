var server = require('ws').Server
var wss = new server({
	host: '0.0.0.0',
	port: 8020
});

wss.on('connection', function(ws) {
	console.log("connected")

	ws.on('message', function(message) {
		console.log('received: %s', message);

		wss.clients.forEach(client => {
			client.send(message);
		});
	});
});
