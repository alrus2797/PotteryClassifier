from bottle import route, run, view, template, static_file


@route('/')
def root():
    return template('index')

@route('/src/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='./src')



run(host='localhost', port=8080, debug=True, reloader=True)