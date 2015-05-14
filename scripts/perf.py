#!/usr/bin/env python
import time
import socket
import threading

MESSAGE = [
"MSH|^~\&|ADT1|MCM|LABADT|MCM|19880818112600|SECURITY|ADT^A01|MSG00001|P|2.3|",
"EVN|A01|198808181123||",
"PID|||PATID1234^5^M11||JONES^WILLIAM^A^III||19610615|M||C|1200 N ELM STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434||S||PATID12345001^2^M10|123456789|987654^NC|",
"NK1|JONES^BARBARA^K|WIFE||||||NK^NEXT OF KIN<",
"PV1|1|I|2000^2012^01||||004777^LEBAUER^SIDNEY^J.|||SUR||||ADM|A0|"
]

THREADS = 2
COUNT = 2000
ERRORS = 0
SUCCESS = 0

def make_request(todo):
    success = 0
    errors = 0

    for x in range(todo):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect(("192.168.20.20", 8000))
        for m in MESSAGE:
            s.send(m + "\r\n")
        read = s.recv(4096)
        if "EA" in read:
            errors += 1

        if "MSH" in read:
            success += 1

        if not read:
            errors += 1

    #print "Success: {}\t Errors: {}".format(success, errors)

if __name__ == "__main__":

    if COUNT >= 5000:
        print "Skipping sequential test for {} connections".format(COUNT)
    else:
        print "Starting sequential perf test - {} connections ".format(COUNT)
        start = time.time()
        make_request(COUNT)
        end = time.time()
        print " -- Processed {} connections in {}".format(COUNT, end-start)

    print "Starting concurrent perf test - {} connections in {} threads ".format(COUNT, THREADS)
    start = time.time()
    threads = []
    for i in range(THREADS):
        t = threading.Thread(target=make_request, args=(COUNT/THREADS,))
        threads.append(t)
        t.start()
    for t in threads:
        t.join()
    end = time.time()
    print " -- Processed {} connections in {}".format(COUNT, end-start)

