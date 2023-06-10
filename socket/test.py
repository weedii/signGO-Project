from flask import Flask, request, jsonify

app = Flask(__name__)

i = 0


@app.route("/upload", methods=["POST"])
def upload():

    global i

    if (request.method == "POST"):
        image = request.files["image"]
        image.save(f"./x/image{i}")
        i += 1

        return jsonify({
            "message": "Image Uploaded Successfully"
        })


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=4000)
