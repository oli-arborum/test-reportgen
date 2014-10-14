#!/bin/bash
echo "generating database schema (file msg.db)..."
sqlite3 msg.db "CREATE TABLE messages( timestamp INT, msec INT, type INT, message TEXT );"

