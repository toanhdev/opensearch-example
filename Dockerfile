FROM opensearchproject/opensearch:latest

USER root

# Create required directories
RUN mkdir -p /usr/share/opensearch/config/opensearch-security

# Copy configurations and certificates
COPY --chown=opensearch:opensearch opensearch/configs/opensearch.yml /usr/share/opensearch/config/
COPY --chown=opensearch:opensearch opensearch/certs/node-key.pem /usr/share/opensearch/config/
COPY --chown=opensearch:opensearch opensearch/certs/node.pem /usr/share/opensearch/config/
COPY --chown=opensearch:opensearch opensearch/certs/admin-key.pem /usr/share/opensearch/config/
COPY --chown=opensearch:opensearch opensearch/certs/admin.pem /usr/share/opensearch/config/
COPY --chown=opensearch:opensearch opensearch/certs/root-ca.pem /usr/share/opensearch/config/

# Copy security configurations
COPY --chown=opensearch:opensearch opensearch/configs/opensearch-security/config.yml /usr/share/opensearch/config/opensearch-security/
COPY --chown=opensearch:opensearch opensearch/configs/opensearch-security/roles.yml /usr/share/opensearch/config/opensearch-security/
COPY --chown=opensearch:opensearch opensearch/configs/opensearch-security/roles_mapping.yml /usr/share/opensearch/config/opensearch-security/

# Set permissions
RUN chown -R opensearch:opensearch /usr/share/opensearch/config && \
    chmod 750 /usr/share/opensearch/config && \
    chmod 750 /usr/share/opensearch/config/opensearch-security && \
    chmod 640 /usr/share/opensearch/config/*.pem && \
    chmod 640 /usr/share/opensearch/config/opensearch-security/*.yml

USER opensearch
