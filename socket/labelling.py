# import necessary libraries
import cv2  # OpenCV library for image and video processing
# Custom module for hand detection
from cvzone.HandTrackingModule import HandDetector
import numpy as np  # Numpy library for mathematical operations
import math
import time

# create a video capture object that captures video from the default camera (index 0)
cap = cv2.VideoCapture(0)


# create a hand detector object that can detect up to one hand in a frame
detector = HandDetector(maxHands=1)

folder = "Data/"
count = 0
# start an infinite loop
while True:
    # read a frame from the video capture object
    # success is a boolean that indicates whether a frame was successfully read
    # img is the image frame that was read
    success, img = cap.read()

    # detect any hands in the image using the hand detector object
    # hands is a list of dictionaries containing information about the detected hands
    # img is the image with any annotations added by the hand detector
    hands, img = detector.findHands(img)

    # if at least one hand was detected
    if hands:
        # get the dictionary containing the information about the first detected hand
        hand = hands[0]

        # get the bounding box coordinates of the hand
        # x,y represent the top-left corner of the bounding box, w is the width, h is the height
        x, y, w, h = hand['bbox']

        # create a white image with a size of 300x300 pixels and 3 color channels
        imgWhite = np.ones((300, 300, 3), np.uint8) + 225

        # crop the image to the region containing the hand, adding a 20-pixel border around it
        imgCrop = img[y - 20: y + h + 20, x - 20: x + w + 20]

        # get the shape of the cropped image
        imgCropShape = imgCrop.shape

        # add the cropped image to the white image at the top-left corner

        aspectRatio = h/w
        if aspectRatio > 1:
            k = 300/h
            wcal = math.ceil(k*w)
            imgResize = cv2.resize(imgCrop, (wcal, 300))
            imgResizeShape = imgResize.shape
            wGap = math.ceil((300 - wcal) / 2)
            imgWhite[:, wGap:wcal + wGap] = imgResize

        else:
            k = 300/w
            hcal = math.ceil(k*h)
            imgResize = cv2.resize(imgCrop, (300, hcal))
            imgResizeShape = imgResize.shape
            hGap = math.ceil((300 - hcal) / 2)
            imgWhite[hGap:hcal + hGap, :] = imgResize

        # display the cropped image and the white image with the cropped image added to it
        cv2.imshow("imgCrop", imgCrop)
        cv2.imshow("imgWhite", imgWhite)

    # display the original image with any annotations added by the hand detector
    cv2.imshow("Image", img)

    # wait for a key press (waits 1 millisecond)
    key = cv2.waitKey(1)
    if key == ord("s"):
        count += 1
        cv2.imwrite(f"{folder}/Image_{time.time()}.jpg", imgWhite)
        print(count)
