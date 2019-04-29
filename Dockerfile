FROM sonarqube:7.7-community
COPY bootstrap.sh ./bin/
RUN chmod +x ./bin/bootstrap.sh
ENTRYPOINT ["./bin/bootstrap.sh"]
