#!/usr/bin/env sh

CORERULESET_VERSION=3.3.2
CORERULESET_CONF=/opt/nginx/conf/modsecurity.conf

rm -fR /opt/nginx/conf/coreruleset/

wget -O /tmp/coreruleset.zip https://github.com/coreruleset/coreruleset/archive/refs/tags/v$CORERULESET_VERSION.zip
unzip /tmp/coreruleset.zip -d /tmp/coreruleset
mv /tmp/coreruleset/coreruleset-$CORERULESET_VERSION /opt/nginx/conf/coreruleset

cp /opt/nginx/conf/coreruleset/crs-setup.conf.example /opt/nginx/conf/coreruleset/crs-setup.conf

if [ ! -f $CORERULESET_CONF ]; then

  echo "SecRuleEngine On" >> $CORERULESET_CONF
  echo "SecAuditEngine On" >> $CORERULESET_CONF
  echo "SecAuditLog /opt/nginx/logs/audit.log" >> $CORERULESET_CONF
  echo "SecAuditLogParts ABCFHZ" >> $CORERULESET_CONF
  echo "SecAuditLogType concurrent" >> $CORERULESET_CONF
  echo "SecAuditLogStorageDir /opt/nginx/logs" >> $CORERULESET_CONF
  echo "Include /opt/nginx/conf/coreruleset/crs-setup.conf" >> $CORERULESET_CONF
  echo "Include /opt/nginx/conf/coreruleset/rules/*.conf" >> $CORERULESET_CONF
fi


rm -f /tmp/coreruleset.zip
rm -fR /tmp/coreruleset


