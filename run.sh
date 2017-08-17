#!/bin/bash
docker run --name mybot -it -e HUBOT_SLACK_TOKEN='xoxb-229336926231-qqWXx7nTSd1xjX9K98pO736L' -e Hubot_SLACK_TEAM='trueaccord' -e Hubot_SLACK_BOTNAME='debtcat' -d shakataganai/hubot-slack

