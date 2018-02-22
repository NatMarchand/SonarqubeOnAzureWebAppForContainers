FROM sonarqube:7.0-alpine
COPY entrypoint.sh /bin/
ENTRYPOINT ["/bin/entrypoint.sh"]