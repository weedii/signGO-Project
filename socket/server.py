import socket
import cv2
import numpy as np

# Create a socket object
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to a specific address and port
server_address = ('localhost', 5000)
server_socket.bind(server_address)

# Listen for incoming connections
server_socket.listen(1)
print('Waiting for a client to connect...')

# Accept a client connection
client_socket, client_address = server_socket.accept()
print('Client connected:', client_address)

# Receive and process images, and send back strings
while True:
    # Receive image data from the client
    image_data = b''
    while True:
        data = client_socket.recv(1000000)
        if not data:
            break
        image_data += data
        print('Received image data length:', len(image_data))


        # Convert the received image data to OpenCV format
        nparr = np.frombuffer(image_data, np.uint8)
        frame = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

        # Process the frame and obtain a string result
        # Replace this with your own image processing logic
        processed_result = 'mrigel woslot sahbi'


        # Send the processed result back to the client
        client_socket.sendall(processed_result.encode())

# Close the client socket
client_socket.close()

# Close the server socket
server_socket.close()
