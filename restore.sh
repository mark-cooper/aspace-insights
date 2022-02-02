#!/bin/bash

aws s3 cp s3://aspace-las-insights-bastion/insights.sql . --profile archivesspace
PGPASSWORD=password psql -h 127.0.0.1 -U postgres -c 'DROP DATABASE aspace_insights_development'
PGPASSWORD=password psql -h 127.0.0.1 -U postgres -c 'CREATE DATABASE aspace_insights_development'
PGPASSWORD=password psql -h 127.0.0.1 -U postgres -c 'CREATE ROLE insightsadmin'
PGPASSWORD=password psql -h 127.0.0.1 -U postgres -c 'CREATE ROLE rdsadmin'
PGPASSWORD=password psql -h 127.0.0.1 -U postgres -d aspace_insights_development < insights.sql
