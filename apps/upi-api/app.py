from flask import Flask, jsonify, request
from datetime import datetime
import uuid

app = Flask(__name__)

transactions = [
    {
        "transactionId": "TXN1001",
        "fromAccount": "9876543210",
        "toAccount": "1234567890",
        "amount": 500,
        "status": "SUCCESS",
        "timestamp": "2026-08-07T10:00:00"
    },
    {
        "transactionId": "TXN1002",
        "fromAccount": "1111222233",
        "toAccount": "4444555566",
        "amount": 250,
        "status": "SUCCESS",
        "timestamp": "2026-08-07T10:15:00"
    }
]


@app.route("/")
def home():
    return jsonify({
        "application": "UPI API",
        "status": "Running",
        "version": "1.0.0"
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "UP"
    })


@app.route("/transactions", methods=["GET"])
def get_transactions():
    return jsonify(transactions)


@app.route("/transactions/<transaction_id>", methods=["GET"])
def get_transaction(transaction_id):
    for txn in transactions:
        if txn["transactionId"] == transaction_id:
            return jsonify(txn)
    return jsonify({"message": "Transaction not found"}), 404


@app.route("/transactions", methods=["POST"])
def create_transaction():
    data = request.get_json()

    transaction = {
        "transactionId": str(uuid.uuid4())[:8].upper(),
        "fromAccount": data.get("fromAccount"),
        "toAccount": data.get("toAccount"),
        "amount": data.get("amount"),
        "status": "SUCCESS",
        "timestamp": datetime.utcnow().isoformat()
    }

    transactions.append(transaction)

    return jsonify(transaction), 201


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
