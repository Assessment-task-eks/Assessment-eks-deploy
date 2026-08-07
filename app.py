from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "service": "Bank API",
        "status": "Running",
        "version": "1.0"
    })

@app.route("/health")
def health():
    return jsonify({"status":"UP"})

@app.route("/accounts")
def accounts():
    return jsonify([
        {
            "accountNumber":"123456789",
            "name":"John",
            "balance":10000
        },
        {
            "accountNumber":"987654321",
            "name":"David",
            "balance":5000
        }
    ])

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
