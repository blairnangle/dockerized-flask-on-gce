import logging
from flask import Flask

app = Flask(__name__)


@app.route("/")
def index():
    logging.basicConfig(level=logging.INFO)
    logging.info('Kicked off flask app!')
    return "Congratulations, it's a web app!"


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=6969, debug=True)
