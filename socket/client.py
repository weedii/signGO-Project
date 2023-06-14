import base64
import os
from flask import Flask, request, jsonify
import cv2
import numpy as np
from celery import Celery

app = Flask(__name__)
celery = Celery('module1', broker='redis://localhost:6379/0')

i = 0

@celery.task(bind=True)
def process_image(self, image_data):
    try:
        # Decode the Base64-encoded image data to bytes
        image_bytes = base64.b64decode(image_data)

        # Convert the image bytes to a NumPy array
        image_array = np.frombuffer(image_bytes, dtype=np.uint8)

        # Decode the image array and convert it to a normal image
        image = cv2.imdecode(image_array, cv2.IMREAD_COLOR)

        return image
    except Exception as e:
        return str(e)

@app.route('/upload', methods=['POST'])
def upload():
    global i
    try:
        image_data = request.data

        image = process_image.delay(image_data).get()  # Asynchronously call the process_image task and get the result

        if image is None:
            print("Failed to convert image")

        # Create the directory if it doesn't exist
        if not os.path.exists('x'):
            os.makedirs('x')

        image_path = f'x/image{i}.png'
        cv2.imwrite(image_path, image)
        i += 1

        predicted_class = "result will be here"

        response = {
            'predicted_class': predicted_class,
            'image_path': image_path
        }

        return jsonify(response)

    except Exception as e:
        return str(e)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
