import flask
from flask import jsonify
from create_dataset import get_user_comments, get_user_logs, get_userid
import os

app = flask.Flask(__name__)

DB1_PARAMS = {
    'dbname': os.getenv('DB1_NAME', 'postgres'),
    'user': os.getenv('DB1_USER', 'postgres'),
    'password': os.getenv('DB1_PASSWORD', 'postgres'),
    'host': os.getenv('DB1_HOST', 'localhost'),
    'port': os.getenv('DB1_PORT', '5432')
}

DB2_PARAMS = {
    'dbname': os.getenv('DB2_NAME', 'postgres'),
    'user': os.getenv('DB2_USER', 'postgres'),
    'password': os.getenv('DB2_PASSWORD', 'postgres'),
    'host': os.getenv('DB2_HOST', 'localhost'),
    'port': os.getenv('DB2_PORT', '5432')
}

db1_url = f"postgresql+psycopg2://{DB1_PARAMS['user']}:{DB1_PARAMS['password']}@{DB1_PARAMS['host']}:{DB1_PARAMS['port']}/{DB1_PARAMS['dbname']}"
db2_url = f"postgresql+psycopg2://{DB2_PARAMS['user']}:{DB2_PARAMS['password']}@{DB2_PARAMS['host']}:{DB2_PARAMS['port']}/{DB2_PARAMS['dbname']}"


@app.route('/api/comments', methods=['GET'])
def get_comments():
    login = flask.request.args.get('login')
    if not login:
        return jsonify({"error": "Login is required"}), 400
    user_id = get_userid(login, db1_url)
    if user_id is None:
        return jsonify({"error": "User not found"}), 404
    return get_user_comments(login, db1_url).to_json(orient='records')


@app.route('/api/general', methods=['GET'])
def get_logs():
    login = flask.request.args.get('login')
    if not login:
        return jsonify({"error": "Login is required"}), 400
    user_id = get_userid(login, db1_url)
    if user_id is None:
        return jsonify({"error": "User not found"}), 404
    return get_user_logs(login, db2_url, db1_url).to_json(orient='records')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
