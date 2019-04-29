FROM sonarqube:7.7-community
COPY entrypoint.sh ./bin/
ENTRYPOINT ["./bin/entrypoint.sh"]
