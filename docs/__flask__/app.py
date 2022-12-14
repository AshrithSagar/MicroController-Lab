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
app.config['FREEZER_DESTINATION_IGNORE'] = ['.nojekyll', '__flask__']
freezer = Freezer(app)


@app.route("/")
def index():
    file = os.path.join("../../", 'README.md')
    with open(file, 'r') as f:
        indexContents = f.read()

    data = {
        "indexContents": indexContents
    }
    return render_template("index.html", data=data)


@app.route("/Experiment-<int:experimentNumber>/")
def experiment(experimentNumber):
    folder = os.path.join("../../", 'Experiment-'+str(experimentNumber))
    folderContents = sorted(os.listdir(folder))

    fileContents = {}
    for fileName in folderContents:
        filePath = os.path.join(folder, fileName)
        with open(filePath, 'r') as f:
            fileContents[fileName] = f.read()

    data = {
        "experimentNumber": experimentNumber,
        "folderContents": folderContents,
        "fileContents": fileContents
    }
    return render_template("experiment.html", data=data), 200, {'Content-Type': 'text/html; charset=utf-8'}


@freezer.register_generator
def experiment():
    for experimentNumber in [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12]:
        yield {'experimentNumber': experimentNumber}


@app.route("/Experiment-<int:experimentNumber>/<fileName>/")
def filePage(experimentNumber, fileName):
    filePath = os.path.join("../../", 'Experiment-' +
                            str(experimentNumber), fileName)
    with open(filePath, 'r') as f:
        fileData = f.read()

    data = {
        "experimentNumber": experimentNumber,
        "fileName": fileName,
        "fileData": fileData
    }
    return render_template("filePage.html", data=data), 200, {'Content-Type': 'text/html; charset=utf-8'}


@freezer.register_generator
def filePage():
    for experimentNumber in [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12]:
        folder = os.path.join("../../", 'Experiment-'+str(experimentNumber))
        folderContents = sorted(os.listdir(folder))
        for fileName in folderContents:
            yield {'experimentNumber': experimentNumber, 'fileName': fileName}


if __name__ == '__main__':
    freezer.freeze()  # Freeze the app into FREEZER_DESTINATION
    freezer.serve(debug=True)  # Serve the app locally from FREEZER_DESTINATION

    # freezer.run()  # Choose for URL checking
    # app.run()  # Choose to run locally from Flask
