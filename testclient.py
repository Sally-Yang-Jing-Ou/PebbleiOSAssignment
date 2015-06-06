import socket
import binascii

HOST = '127.0.0.1'    # The remote host
PORT = 1234              # The same port as used by the server
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((HOST, PORT))
s.sendall('Hello, world')
all_data = []
for i in range(0, 10):
	try:
	    data = s.recv(7)
	    readable_data = binascii.b2a_hex(data)
	    print("Received packet %s" % readable_data)
	    all_data.append(readable_data)
	except socket.error, e:
	    if isinstance(e.args, tuple) and e[0] == errno.EPIPE:
	        # client disconnected
	        break
	    else:
	        raise
s.close()
print 'Received', repr(all_data)