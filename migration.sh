#!/bin/bash

chmod +x /root/minio-binaries/mc
export PATH=$PATH:/root/minio-binaries/
mc config host add migration_task http://minioapi.dev.sealos.top database database --api s3v4
mc cp migration_task/database-test/$FILE_NAME ./
if [ "$DATABASE_TYPE" = "apecloud-mysql" ]; then
    mysql -u $DATABASE_USER -h $DATABASE_HOST -p$DATABASE_PASSWORD $DATABASE_NAME < $FILE_NAME
elif  [ "$DATABASE_TYPE" = "postgresql" ];then
    PGPASSWORD=$DATABASE_PASSWORD psql -U $DATABASE_USER -d $DATABASE_NAME -h $DATABASE_HOST -f $FILE_NAME
elif  [ "$DATABASE_TYPE" = "mongodb" ];then
    mongo --version
    mongoimport --username $DATABASE_USER --password $DATABASE_PASSWORD -h $DATABASE_HOST --authenticationDatabase admin --db $DATABASE_NAME --collection $COLLECTION_NAME --jsonArray $FILE_NAME
else
  echo "the database type does not match"
fi