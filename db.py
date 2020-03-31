import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import os
import shutil
from os.path import isfile, join
from classes import classes_array

enumerated_directory = 'src/images/enumerated/'

def enumerate_dataset(files_list):
    filepaths = open(files_list).readlines()
    mapper = {}
    map_file = open('mapped.txt', 'w')
    for number, filepath in enumerate(filepaths):
        filepath = filepath.strip('\n')
        filename = os.path.basename(filepath)
        shutil.copy2(filepath, f'{enumerated_directory}{number}.png')
        print(f'Copying from {filepath} to {enumerated_directory}{filename}')
        map_file.write(f'{number}-{filename}\n')
        mapper[str(number)] = filename
    return mapper

def upload_to_database(db, dataset):
    scores_ref      = db.reference('scores')
    real_names_ref  = db.reference('real_names')

    for number, filename in dataset.items():
        scores_ref.child(number).set(null_values)
        real_names_ref.child(number).set({
            "filename": filename,
            "name": filename.split('.')[0]
        })
        print(f'Successfully uploaded {filename}')





dataset = enumerate_dataset('a.txt')
null_values = { _class:0 for _class in classes_array }

# Fetch the service account key JSON file contents
cred = credentials.Certificate('credentials.json')

# Initialize the app with a service account, granting admin privileges
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://potteryclassifier.firebaseio.com'
})



