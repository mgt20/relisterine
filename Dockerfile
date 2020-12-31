FROM python:3.9.1-slim-buster

RUN apt-get update && apt-get install -yq \
    chromium=83.0.4103.116-1~deb10u3 \
    chromium-driver=83.0.4103.116-1~deb10u3 \
    unzip=6.0-23+deb10u1 \
    xvfb=2:1.20.4-1+deb10u2 \
    curl=7.64.0-4+deb10u1 \
    cron=3.0pl1-134+deb10u1

# create symlinks to chromedriver and geckodriver (to the PATH)
RUN chmod 777 /usr/bin/chromedriver

COPY relisterine.py /relisterine.py
COPY relisterine_config.ini /relisterine_config.ini
COPY requirements.txt /requirements.txt

# RUN echo "* * * * * echo hello" | crontab -
RUN pip3 install -r requirements.txt

RUN echo "0 1 * * * python /relisterine.py" | crontab -

CMD ["cron","-f"]
