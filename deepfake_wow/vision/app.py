from flask import Flask, request, jsonify
from backend_deepFake import main_fake
import pyrebase
import os
import time




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
    start = time.time()
    d={}
    vid_id = str(request.args['id'])
    print("vid_id : ",vid_id)

    print("Fetching Data!")

    # path_on_cloud = "vid.mp4"
    path_on_cloud = vid_id+".mp4"
    default_vid_name = "downloads/"+path_on_cloud

    now = time.time()

    # storage.child(path_on_cloud).put(path_local)
    while(True):
        now = time.time()
        if ((now - start) >= 15) :
            print("inside if time check")

            d['Query'] = "Time out error"
            print("Time out error")
            return jsonify(d)
        try:
            storage.child(path_on_cloud).download(default_vid_name)
            if os.path.exists(default_vid_name):
                print("inside try")
                break
            else:
                continue
        except:
            print("inside except")
            continue

    print("Done Fetching Data")

    val = main_fake(default_vid_name)

    print(val)
    d['Query'] = val

    os.remove(default_vid_name)

    return jsonify(d)

if __name__ == '__main__':
    app.debug = True
    app.run()  