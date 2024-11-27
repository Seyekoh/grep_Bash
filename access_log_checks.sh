#!/bin/bash

LOG_FILE="access.log"

OUTPUT_FILE="audit_rpt.txt"

# Clear the previous report
> "$OUTPUT_FILE"

BLACKLISTED_IP="173.255.170.15"

SQL_PATTERNS=("UNION" "SELECT" "' OR 1=1" "DROP TABLE")

# Process log file for blacklisted IP
grep -n "$BLACKLISTED_IP" "$LOG_FILE" | while IFS=: read -r line_num line_content
do
    echo "$line_num, bad IP found" >> "$OUTPUT_FILE"
done

# Process log file for SQL Injection attempts
for pattern in "${SQL_PATTERNS[@]}"
do
    grep -n "$pattern" "$LOG_FILE" | while IFS=: read -r line_num line_content
    do
        echo "$line_num, SQL Injection attempt found" >> "$OUTPUT_FILE"
    done
done

echo "Audit report generated in $OUTPUT_FILE"

