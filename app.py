import datetime
import os
from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def index():
    now = datetime.datetime.now().strftime("%H:%M:%S")
    osname = os.name
    hostname = os.getenv('HOSTNAME') or os.getenv('COMPUTERNAME')
    return render_template("index.html", now=now, osname=osname, hostname=hostname)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
