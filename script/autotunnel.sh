#!/usr/bin/sh

# Maintain an ssh tunnel for oracle db connections from
# kmtools.uits.iu.edu. It uses a passwordless private key file. The
# ExitOnForwardFailure option makes sure ssh quits when it detects the
# tunnel has died. The ServerAliveInterval keeps pinging every 5
# seconds so kmtools doesn't kill the connection for being idle. The
# ssh command line is wrapped in a while loop so if it does abort it
# will start up again.

while : 
  do 
    ssh -N -i /home/jorahood/.ssh/wl2_rsa -o ExitOnForwardFailure=yes -o ServerAliveInterval=5 -R 1521:localhost:1521 kmtools.uits.iu.edu 
  done

