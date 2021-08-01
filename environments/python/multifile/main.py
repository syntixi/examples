from http.server import HTTPServer, BaseHTTPRequestHandler
import readfile
import os

HOST_ADDRESS = "0.0.0.0"
HOST_PORT = 80

class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

        current_dir = os.path.dirname(__file__)
        self.wfile.write(bytes(readfile.readFile(os.path.join(current_dir, "message.txt")),"utf-8"))

        return

def run(server_class=HTTPServer, handler_class=BaseHTTPRequestHandler):
    server_address = (HOST_ADDRESS, HOST_PORT)
    httpd = server_class(server_address, handler_class)
    httpd.serve_forever()

if __name__ == '__main__':
    run(handler_class=RequestHandler)
