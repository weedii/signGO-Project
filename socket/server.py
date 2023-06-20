import os
import cv2
from flask import Flask, jsonify, request
import tensorflow as tf
import numpy as np
from cvzone.HandTrackingModule import HandDetector

app = Flask(__name__)
i = 0

classes = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'HI', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'communicate', 'deaf', 'flask',
           'flutter', 'help', 'hope', 'khamassi', 'like', 'love', 'made by', 'melek', 'my name is', 'nice', 'people', 'python', 'technologie', 'this application', 'wael', 'we', 'you']
x_model = tf.keras.models.load_model(
    "D:/api/signGO-Project/socket/xx_eras_model.h5")


@app.route('/upload', methods=['POST'])
def upload():
    global i

    # Check if the request contains a file
    if 'video' not in request.files:
        return 'No video file provided', 400

    video_file = request.files['video']

    # Create a directory to store the frames
    frames_dir = 'result/'
    os.makedirs(frames_dir, exist_ok=True)

    # Save video
    video_path = os.path.join(frames_dir, f'video{i}.mp4')
    video_file.save(video_path)

    # Convert video to frames
    frame_output_dir = os.path.join(frames_dir, 'frames')
    os.makedirs(frame_output_dir, exist_ok=True)

    # Read video frames and save them as images
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
        #cv2.imwrite(frame_path, frame)
        

        hands, img = detector.findHands(frame)

        for hand in hands:
            x, y, w, h = hand['bbox']
            if x >= 20 and y >= 20:
                img_crop = img[y - 20:y + h + 20, x - 20:x + w + 20]
                # Handle edge case when hand is near the borders
                if img_crop.size == 0:
                    continue

                img_resized = cv2.resize(img_crop, target_size)
                img_preprocessed = img_resized / 225.0
                img_input = np.expand_dims(img_preprocessed, axis=0)
                #cv2.imwrite(frame_path, img_resized)
                frame_count += 1

                prediction = x_model.predict(img_input)
                predicted_class = np.argmax(prediction)
                confidence = prediction[0][predicted_class]
                if confidence >= 0.6:
                    # Only display prediction if confidence is above threshold
                    res = classes[predicted_class]

    if 'res' not in locals():
        res = None

    # Create a JSON response
    response = {
        'predicted_class': res
    }

    # Release the video capture
    capture.release()

    if res is None:
        return "nothing"
    return res


if __name__ == '__main__':
    # Run the Flask application
    app.run(debug=True, host='0.0.0.0', port=5001)
