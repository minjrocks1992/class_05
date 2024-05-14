https://www.redswitches.com/blog/install-apache-tomcat-on-ubuntu/

   88  cd /tmp
   89  ls
   90  wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.20/bin/apache-tomcat-10.0.20.tar.gz
   91  sudo groupadd tomcat
   92  sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
   93  curl -o https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.23/bin/apache-tomcat-10.1.23.tar.gz
   94  curl -O https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.23/bin/apache-tomcat-10.1.23.tar.gz
   95  ls
   96  sudo mkdir /opt/tomcat
   97  tar -xvz apache-tomcat-10.1.23.tar.gz
   98  sudo mkdir /opt/tomcat
   99  sudo tar xzvf apache-tomcat-10*tar.gz -C /opt/tomcat --strip-components=1
  100  ls /opt/tomcat/
  101  sudo chown -RH tomcat: /opt/tomcat
  102  sudo chmod +x /opt/tomcat/bin/*.sh
  103  sudo update-java-alternatives -l
  104  vi /etc/systemd/system/tomcat.service
  105  sudo systemctl daemon-reload
  106  sudo systemctl start tomcat
  107  sudo systemctl status tomcat
  108  history

---------------------------------------------------- tomcat start wuto with function ---------------------------

#!/bin/bash


send_email() {
    python3 - <<END
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Email configuration
gmail_sender = 'minj1992@gmail.com'
gmail_receiver = 'minj1992@gmail.com'
gmail_password = 'youremailsmtpapssword'

def send_email():
    subject = "Notification: Tomcat Status"
    body = "HI Team, \n Tomcat Status: Tomcat is Running"

    msg = MIMEMultipart()
    msg['From'] = gmail_sender
    msg['To'] = gmail_receiver
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))

    try:
     
        with smtplib.SMTP_SSL('smtp.gmail.com', 465) as server:
           
            server.login(gmail_sender, gmail_password)

          
            server.sendmail(gmail_sender, gmail_receiver, msg.as_string())

        print("Email sent successfully!")

    except Exception as e:
        print(f"Error: {str(e)}")

if __name__ == "__main__":
    send_email()

END
}


tomcat_status=$(systemctl is-active tomcat)


if [ "$tomcat_status" != "active" ]; then
    systemctl start tomcat
    echo "Tomcat started successfully."
    send_email
else
    echo "Tomcat is already running."
fi

-------------------------tomcat start auto without function ------------------
#!/bin/bash

tomcat_status=$(systemctl is-active tomcat)


if [ "$tomcat_status" != "active" ]; then
    systemctl start tomcat
    echo "Tomcat started successfully."
    python3 - <<END
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart


gmail_sender = 'minj1992@gmail.com'
gmail_receiver = 'minj1992@gmail.com'
gmail_password = 'gmailsmtppassword'

def send_email():
    subject = "Notification: Tomcat Status"
    body = "HI Team, \n Tomcat Status: Tomcat is Running"

    msg = MIMEMultipart()
    msg['From'] = gmail_sender
    msg['To'] = gmail_receiver
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))

    try:
   
        with smtplib.SMTP_SSL('smtp.gmail.com', 465) as server:
            
            server.login(gmail_sender, gmail_password)

           
            server.sendmail(gmail_sender, gmail_receiver, msg.as_string())

        print("Email sent successfully!")

    except Exception as e:
        print(f"Error: {str(e)}")

if __name__ == "__main__":
    send_email()

END
 echo "sent email"
else
    echo "Tomcat is already running."
fi
