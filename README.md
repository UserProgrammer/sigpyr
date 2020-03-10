# sigpyr (Signal Pyre)

NAME
	sigpyr - Facilitates the configuration of communication between interdependent nodes on a network.

DESCRIPTION

SYNOPSIS
	sigpyr watch [-p|--port <port>] [-t|--timeout <seconds>] [-s|--signal <message>]

	sigpyr signal host[:<port>]

OPTIONS
	-p|--port	The port number to listen on. Default is 4444.
	-t|--timeout	Time in seconds before terminating the script. Default is 5 seconds.
	-s|--signal	A string message that the listener will wait on. Default is "ready".
