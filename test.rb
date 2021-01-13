require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.mount('/quality_goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'quality_goya.rb')
server.mount('/consumption_goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'consumption_goya.rb')
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'new.html.erb')
server.start