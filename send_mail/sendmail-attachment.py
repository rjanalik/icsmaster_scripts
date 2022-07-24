#!/usr/bin/python

import getpass
import smtplib
import sys
import re
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email.encoders import encode_base64

##smtp = SMTP_SSL('smtp.seznam.cz', 465)
#smtp = SMTP('smtp.office365.com', 587)
##smtp.ehlo('guest')
##pwd = getpass()
#pwd = stdin.readline().strip()
#smtp.starttls()
#smtp.login('janalr@usi.ch', pwd)
#f = open("email_input.txt")
f = open(sys.argv[1])
pdffile = sys.argv[2]
body = f.read()
f.close()
to = re.search('To: *(.*)', body).group(1)
fr = re.search('From: *(.*)', body).group(1)
subject = re.search('Subject: *(.*)', body).group(1)
text = body.split("\n",5)[5];
text = MIMEText(text)

msg = MIMEMultipart()
msg['Subject'] = subject
msg['From'] = fr
msg['To'] = to
msg.attach(text)

part = MIMEBase('application', "octet-stream")
part.set_payload(open(pdffile, "rb").read())
encode_base64(part)

part.add_header('Content-Disposition', 'attachment; filename="USI-CSCS_Summer_School_2021_certificate.pdf"')

msg.attach(part)

smtp = smtplib.SMTP('smtp.office365.com', 587)
pwd = sys.stdin.readline().strip()
smtp.starttls()
smtp.login('janalr@usi.ch', pwd)
smtp.sendmail(fr, to, msg.as_string())
