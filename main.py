from bottle import route, run, view, template, static_file
from classes import classes_array

@route('/')
def root():
    classes = classes_array
    return template('index', classes = classes)

@route('/thanks')
def thanks():
    return template('thanks')

@route('/src/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='./src')

@route('/images/<filename>')
def server_static(filename):
    print("file:",filename)
    return static_file(filename, root='./src/images/enumerated')


run(host='localhost', port=8080, debug=True, reloader=True)