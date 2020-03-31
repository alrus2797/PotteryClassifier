from bottle import route, run, view, template, static_file
from classes import classes_array
import sys
import os

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


if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == "local":
        run(host="localhost", port=8000, debug=True, reloader=True)
    else:
        run(host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))