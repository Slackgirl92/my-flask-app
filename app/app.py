from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World 2!'

if __name__ == '__main__':
    app.run(debug=False, port=5000, host='0.0.0.0')
