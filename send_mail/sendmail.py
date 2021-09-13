#!/usr/bin/python

from getpass import *
from smtplib import *
from sys import *
import re

#smtp = SMTP_SSL('smtp.seznam.cz', 465)
smtp = SMTP('smtp.office365.com', 587)
#smtp.ehlo('guest')
#pwd = getpass()
pwd = stdin.readline().strip()
smtp.starttls()
smtp.login('janalr@usi.ch', pwd)
f = open(argv[1])
body = f.read()
f.close()
to = re.search('To: *(.*)', body).group(1)
fr = re.search('From: *(.*)', body).group(1)
smtp.sendmail(fr, to, body)
