#!/usr/bin/env python3

# http://wsgi.tutorial.codepoint.net/environment-dictionary
from wsgiref.simple_server import make_server

def application(environ, start_response):
    response_body = [
        '%s: %s' % (key, value) for key, value in sorted(environ.items())
    ]
    response_body = '\n'.join(response_body)

    status = '200 OK'

    response_headers = [
        ('Content-Type', 'text/plain'),
        ('Content-Length', str(len(response_body)))
    ]

    start_response(status, response_headers)

    return map(lambda x: x.encode('utf-8'), [response_body])


httpd = make_server(
    'localhost',
    8051,
    application
)

if __name__ == '__main__':
    print(' # --- Started')
    httpd.handle_request()
    print(' Handled --- #')
