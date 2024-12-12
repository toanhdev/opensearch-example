FROM opensearchproject/opensearch-dashboards:latest

USER root

# Copy configurations and certificates
COPY --chown=opensearch-dashboards:opensearch-dashboards opensearch_dashboards/configs/opensearch_dashboards.yml /usr/share/opensearch-dashboards/config/


# Set permissions
RUN chown -R opensearch-dashboards:opensearch-dashboards /usr/share/opensearch-dashboards/config && \
    chmod 750 /usr/share/opensearch-dashboards/config

USER opensearch-dashboards