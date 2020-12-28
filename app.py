from flask import Flask, request, jsonify
from backend_deepFake import main_fake
import pyrebase

config = {
    "apiKey": "AIzaSyCuz_lc8ksvAZP2kBHZgnLlbrWDkOEVlc8",
    "authDomain": "deepfake-3e211.firebaseapp.com",
    "databaseURL":"https://deepfake-3e211.firebaseio.com",
    "projectId": "deepfake-3e211",
    "storageBucket": "deepfake-3e211.appspot.com",
    "messagingSenderId": "383982734544",
    "appId": "1:383982734544:web:8d354c701b1aff176ae2d5",
    "measurementId": "G-NERD321PG9"
}



firebase = pyrebase.initialize_app(config)

storage = firebase.storage()

app = Flask(__name__)

@app.route('/api')
def hello_world():
    d={}
    # path = str(request.args['Query'])

    path_on_cloud = "vid1.mp4"
    default_vid_name = "downloads/vid.mp4"

    # storage.child(path_on_cloud).put(path_local)


    storage.child(path_on_cloud).download(default_vid_name)


    val = main_fake(default_vid_name)

    print(val)
    d['Query'] = val

    return jsonify(d)

if __name__ == '__main__':
    app.debug = True
    app.run()  