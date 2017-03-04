#!/usr/bin/env python3

# http://wsgi.tutorial.codepoint.net/parsing-the-request-get
# http://wsgi.tutorial.codepoint.net/parsing-the-request-post

from wsgiref.simple_server import make_server
from cgi import parse_qs, escape

# form method="get" to create a GET request method
# form method="post" etc
html = """
<html>
<body>
    <form method="get" action="">
        <p>
            Age: <input type="text" name="age" value="%(age)s">
        </p>
        <p>
            Hobbies:
            <input
                name="hobbies" type="checkbox" value="software"
                %(checked-software)s
            > Software
            <input
                name="hobbies" type="checkbox" value="tunning"
                %(checked-tunning)s
            > Auto Tunning
        </p>
        <p>
            <input type="submit" value="Submit">
        </p>
    </form>
    <p>
        Age: %(age)s<br>
        Hobbies: %(hobbies)s
    </p>
</body>
</html>
"""

def application(environ, start_response):
    # Answering GET method
    d = parse_qs(environ['QUERY_STRING'])

    # Answering POST method
    # I can't get this one to work, I probably fucked up somewhere, oh well
    # try:
    #     request_body_size = int(environ.get('CONTENT_LENGTH', 0))
    # except(ValueError):
    #     request_body_size = 0
    #
    # request_body = environ['wsgi.input'].read(request_body_size)
    # d = parse_qs(request_body)
    
    age = escape(d.get('age', [''])[0])
    hobbies = [escape(hobby) for hobby in d.get('hobbies', [])]

    response_body = html % {
        'checked-software': 'checked' if 'software' in hobbies else '',
        'checked-tunning': 'checked' if 'tunning' in hobbies else '',
        'age': age or 'Empty',
        'hobbies': ', '.join(hobbies or ['No Hobbies?'])
    }

    status = '200 OK'

    response_headers = [
        ('Content-Type', 'text/html'),
        ('Content-Length', str(len(response_body)))
    ]

    start_response(status, response_headers)
    return [response_body.encode('utf-8')]

if __name__ == '__main__':
    httpd = make_server('localhost', 8051, application)
    httpd.serve_forever()
