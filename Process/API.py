import os
import cv2
from flask import Flask, request
import tensorflow as tf
import numpy as np
from cvzone.HandTrackingModule import HandDetector

app = Flask(__name__)

classes = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'HI', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'Wael', 'X', 'Y', 'Z', 'communicate', 'deaf',
           'flask', 'flutter', 'help', 'This applicationl', 'khamassi', 'like', 'love', 'made by', 'melek', 'my name is', 'nice', 'people', 'python', 'the technologie', 'this application', 'we', 'you']
x_model = tf.keras.models.load_model(
    "D:/api/signGO-Project/Process/asl_model.h5")


@app.route('/upload', methods=['POST'])
def upload():

    res = ""
    video_file = request.files['video']

    video_path = "result/video.mp4"
    video_file.save(video_path)


    capture = cv2.VideoCapture(video_path)
    target_size = (224, 224)
    detector = HandDetector(maxHands=2)

    ret, frame = capture.read()

    if not ret:
        return

    hands, img = detector.findHands(frame)

    for hand in hands:
        x, y, w, h = hand['bbox']
        if x >= 20 and y >= 20:
            img_crop = img[y - 20:y + h + 20, x - 20:x + w + 20]

            img_resized = cv2.resize(img_crop, target_size)
            img_preprocessed = img_resized / 225.0
            img_input = np.expand_dims(img_preprocessed, axis=0)

            prediction = x_model.predict(img_input)
            predicted_class = np.argmax(prediction)
            confidence = prediction[0][predicted_class]
            if confidence >= 0.7:
                res = classes[predicted_class]
    capture.release()
    os.remove(video_path)
    return res


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)