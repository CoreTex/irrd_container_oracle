# syntax=docker/dockerfile:1
FROM oraclelinux:9-slim
RUN microdnf -y install oracle-epel-release-el9
RUN microdnf -y install gcc redis postgresql-server postgresql postgresql-contrib python3.11 python3.11-devel python3.11-pip python3.11-pyyaml
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2
RUN update-alternatives --install /usr/bin/python3 python /usr/bin/python3.9 1
RUN update-alternatives --install /usr/bin/python3 python /usr/bin/python3.11 2
RUN python3 -m pip install --upgrade pip
RUN python3 -m venv /home/irrd/irrd-venv
RUN useradd irrd
RUN /home/irrd/irrd-venv/bin/pip3 install irrd
RUN mkdir /home/irrd/gnupg-keyring/
RUN su postgres -c 'initdb -D /var/lib/pgsql/data --encoding=UTF-8 --locale=POSIX --auth=scram-sha-256 --auth-local=peer --data-checksums'
COPY irrd.yaml /etc/irrd.yaml
COPY run_irrd.sh run_irrd.sh
RUN chmod +x run_irrd.sh
RUN touch /var/log/irrd.log
RUN chown irrd:irrd /var/log/irrd.log
RUN mkdir -p /var/ftp/
RUN chown -R irrd:irrd /var/ftp/
CMD ./run_irrd.sh
