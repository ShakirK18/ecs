from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return '''
    <html>
        <head>
            <title>Hello from ECS</title>
            <style>
                body { font-family: Arial; text-align: center; margin-top: 50px; }
            </style>
        </head>
        <body>
            <h1>Hello from ECS! 🚀</h1>
            <p>This is running in an ECS container</p>
        </body>
    </html>
    '''

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)