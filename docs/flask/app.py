import os

from flask import Flask, render_template
from flask_frozen import Freezer


app = Flask(__name__)
# Enter your GitHub Pages URL here
app.config['FREEZER_BASE_URL'] = 'https://docs/MicroController-Lab/'

# As configured in GitHub Pages Settings
app.config['FREEZER_DESTINATION'] = '../'

app.config['FREEZER_RELATIVE_URLS'] = False  # Default
app.config['FREEZER_IGNORE_MIMETYPE_WARNINGS'] = False
app.config['FREEZER_DESTINATION_IGNORE'] = ['.nojekyll', 'flask']
freezer = Freezer(app)


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/experiment-<int:experimentNumber>.html")
def experiment(experimentNumber):
    folderData = {}
    folder = os.path.join("../../", 'Experiment-'+str(experimentNumber))
    for file in sorted(os.listdir(folder)):
        filePath = os.path.join(folder, file)
        with open(filePath, 'r') as f:
            folderData[file] = f.read()

    data = {
        "experimentNumber": experimentNumber,
        "folderData": folderData
    }
    return render_template("experiment.html", data=data), 200, {'Content-Type': 'text/html; charset=utf-8'}


@freezer.register_generator
def experiment():
    for experimentNumber in [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12]:
        yield {'experimentNumber': experimentNumber}


if __name__ == '__main__':
    freezer.freeze()  # Freeze the app into FREEZER_DESTINATION
    freezer.serve()  # Serve the app locally from FREEZER_DESTINATION

    # freezer.run()  # Choose for URL checking
    # app.run()  # Choose to run locally from Flask
