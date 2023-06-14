import base64
import socket
from flask import Flask, request, jsonify
import cv2
import numpy as np
from celery import Celery
from celery.utils.log import get_task_logger


app = Flask(__name__)

# # Create a socket object
# client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# # Connect to the server
# server_address = ('localhost', 5000)
# client_socket.connect(server_address)

i = 0
dic = {}
j = 0

@app.route('/upload', methods=['POST'])
def upload():
    global i, j
    try:
        # Get the uploaded image from the request
        image_data = request.data
        dic[j] = image_data
        j += 1
        # Decode the Base64-encoded image data to bytes
        image_bytes = base64.b64decode(dic[j - 1])
        print(image_bytes)
        # Convert the image bytes to a NumPy array
        image_array = np.frombuffer(image_bytes, dtype=np.uint8)
        print(f"image_array shape: {image_array.shape}")
        print(f"image_array dtype: {image_array.dtype}")

        # Decode the image array and convert it to a normal image
        image = cv2.imdecode(image_array, cv2.IMREAD_COLOR)
        if image is None:
            print("Failed to convert image")

        # Save the image to a file
        cv2.imwrite(f"x/image{i}.png", image)
        i += 1

        ##############################################
        predicted_class = "result will be here"

        # Create a JSON response
        response = {
            'predicted_class': predicted_class
        }

        return jsonify(response)

    except Exception as e:
        #client_socket.sendall('test')
        return str(e)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
