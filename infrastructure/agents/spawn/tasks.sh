#!/usr/bin/env bash

echo 'Added test to SQS queue';
sleep 1;
echo 'Building agent container';
sleep 1.5;
echo 'Polling SQS queue';
sleep 0.2;
echo 'First test started';
sleep 2;
echo 'First test complete';
sleep 0.2
echo 'Second test started';
sleep 2;
echo 'Second test complete';
