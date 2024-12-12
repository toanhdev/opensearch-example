chmod +x /usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh && /usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh     -cd /usr/share/opensearch/config/opensearch-security     -icl     -nhnv     -cacert /usr/share/opensearch/config/root-ca.pem     -cert /usr/share/opensearch/config/node.pem     -key /usr/share/opensearch/config/node-key.pem     -h localhost

./securityadmin.sh -cd ../../../config/opensearch-security/ -icl -nhnv \
>   -cacert ../../../config/root-ca.pem \
>   -cert ../../../config/kirk.pem \
>   -key ../../../config/kirk-key.pem


chmod +x /usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh && /usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh -cd /usr/share/opensearch/config/opensearch-security     -icl     -nhnv     -cacert /usr/share/opensearch/config/root-ca.pem -cert /usr/share/opensearch/config/admin.pem -key /usr/share/opensearch/config/admin-key.pem -h localhost -p 9200 -protocol https
