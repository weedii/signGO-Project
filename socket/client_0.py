import os
import cv2
from flask import Flask, jsonify, request

app = Flask(__name__)
i = 0


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
    i += 1

    # Convert video to frames
    frame_output_dir = os.path.join(frames_dir, 'frames')
    os.makedirs(frame_output_dir, exist_ok=True)

    # Read video frames and save them as images
    capture = cv2.VideoCapture(video_path)
    frame_count = 0

    while True:
        ret, frame = capture.read()

        if not ret:
            break

        frame_path = os.path.join(
            frame_output_dir, f'frame_{frame_count:05d}.jpg')
        cv2.imwrite(frame_path, frame)

        frame_count += 1

    capture.release()

    ##############################################
    predicted_class = "result will be here"

    # Create a JSON response
    response = {
        'predicted_class': predicted_class
    }

    return jsonify(response)


if __name__ == '__main__':
    # Run the Flask application
    app.run(debug=True, host='0.0.0.0', port=5001)
