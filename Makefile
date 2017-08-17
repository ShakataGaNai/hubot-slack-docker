run:
	docker run --name mybot -it -e HUBOT_GOOGLE_CSE_ID='################' -e HUBOT_GOOGLE_CSE_KEY='#############' -e HUBOT_SLACK_TOKEN='####################' -e Hubot_SLACK_TEAM='######################' -e Hubot_SLACK_BOTNAME='############' -d shakataganai/hubot-slack
build:
	docker build -t shakataganai/hubot-slack .
delete:
	docker rm -f mybot

