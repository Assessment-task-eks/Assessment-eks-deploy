from flask import Flask, jsonify, request
from datetime import datetime
import uuid

app = Flask(__name__)

accounts = [
    {
        "accountNumber": "1234567890",
        "accountHolder": "John Doe",
        "balance": 10000
    },
    {
        "accountNumber": "9876543210",
        "accountHolder": "Jane Smith",
        "balance": 25000
    }
]


@app.route("/")
def home():
    return jsonify({
        "application": "Bank API",
        "status": "Running",
        "version": "1.0.0"
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "UP"
    })


@app.route("/accounts", methods=["GET"])
def get_accounts():
    return jsonify(accounts)


@app.route("/accounts/<account_number>", methods=["GET"])
def get_account(account_number):
    for account in accounts:
        if account["accountNumber"] == account_number:
            return jsonify(account)
    return jsonify({"message": "Account not found"}), 404


@app.route("/transfer", methods=["POST"])
def transfer():
    data = request.get_json()

    response = {
        "transactionId": str(uuid.uuid4())[:8].upper(),
        "fromAccount": data.get("fromAccount"),
        "toAccount": data.get("toAccount"),
        "amount": data.get("amount"),
        "status": "SUCCESS",
        "timestamp": datetime.utcnow().isoformat()
    }

    return jsonify(response), 201


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
