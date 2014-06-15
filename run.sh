#!/bin/bash

java -jar /app/web.jar -DDATABASE_URL=$DATABASE_URL -DDATABASE_DIALECT=org.hibernate.dialect.MySQLDialect -DDATABASE_DRIVER=com.mysql.jdbc.Driver -DDATABASE_HBM2DDL=update -DDATABASE_PASSWORD=$DATABASE_PASSWORD -DDATABASE_USERNAME=$DATABASE_USERNAME