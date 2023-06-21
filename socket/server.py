import os
import cv2
from flask import Flask, jsonify, request
import tensorflow as tf
import numpy as np
from cvzone.HandTrackingModule import HandDetector

app = Flask(__name__)
i = 0

classes = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'HI', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'Wael', 'X', 'Y', 'Z', 'communicate', 'deaf',
           'flask', 'flutter', 'help', 'This applicationl', 'khamassi', 'like', 'love', 'made by', 'melek', 'my name is', 'nice', 'people', 'python', 'the technologie', 'this application', 'we', 'you']
x_model = tf.keras.models.load_model(
    "D:/api/signGO-Project/socket/khaessi_mouch_houni_eras_model.h5")


@app.route('/upload', methods=['POST'])
def upload():
    global i

    if 'video' not in request.files:
        return 'No video file provided', 400

    video_file = request.files['video']

    frames_dir = 'result/'
    os.makedirs(frames_dir, exist_ok=True)

    video_path = os.path.join(frames_dir, f'video{i}.mp4')
    video_file.save(video_path)

    frame_output_dir = os.path.join(frames_dir, 'frames')
    os.makedirs(frame_output_dir, exist_ok=True)

    capture = cv2.VideoCapture(video_path)
    frame_count = 0
    target_size = (224, 224)

    detector = HandDetector(maxHands=2)

    for j in range(0, 2):
        ret, frame = capture.read()

        if not ret:
            break

        frame_path = os.path.join(
            frame_output_dir, f'frame_{frame_count:05d}.jpg')
        # cv2.imwrite(frame_path, frame)

        hands, img = detector.findHands(frame)

        for hand in hands:
            x, y, w, h = hand['bbox']
            if x >= 20 and y >= 20:
                img_crop = img[y - 20:y + h + 20, x - 20:x + w + 20]
                if img_crop.size == 0:
                    continue

                img_resized = cv2.resize(img_crop, target_size)
                img_preprocessed = img_resized / 225.0
                img_input = np.expand_dims(img_preprocessed, axis=0)
                cv2.imwrite(frame_path, img_resized)
                frame_count += 1

                prediction = x_model.predict(img_input)
                predicted_class = np.argmax(prediction)
                confidence = prediction[0][predicted_class]
                if confidence >= 0.7:
                    res = classes[predicted_class]

    if 'res' not in locals():
        res = None

    response = {
        'predicted_class': res
    }

    capture.release()

    if res is None:
        return ""
    return res


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
