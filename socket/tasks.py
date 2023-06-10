from celery import Celery
import base64
import cv2
import numpy as np

app = Celery('tasks', broker='pyamqp://192.168.223.33:5001//')

@app.task
def process_image(image_data, i):
    try:
        # Decode the Base64-encoded image data to bytes
        image_bytes = base64.b64decode(image_data)

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

        predicted_class = "result will be here"

        return predicted_class

    except Exception as e:
        return str(e)
