FROM elasticsearch:latest

# Install Kopf plugin.
RUN /usr/share/elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf/2.0

# Run elasticsearch and make it accessible from outside.
CMD ["elasticsearch", "-Des.network.bind_host=0.0.0.0"]
