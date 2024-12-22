# LLM Service

LLM Service is a service that provides LLM related features in School Interview System.

> [!WARNING]
> LLM Service is not designed to work with Docker.(But backend-app is designed to work with docker)

## Background

I'll explain why I created LLM Service.

Backend app had some LLM features. I wanted to test only LLM feature on the computer in lab which has powerful GPU. So, it's better to split it into two apps, backend-app, llm-service.(like micro services)

Docker was going to be used with this app, but I decided not to do so. We can access LLM server in our lab with only SSH. We are not allowed to use Remote Desktop feature. Even if I want to change memory limit for a container, I can't change it with GUI. It's inconvinient to work with docker under the limitation.

That's why Docker is not used in LLM Service.

## How to setup

You need to run these commands on LLM Server in our lab at `llm-service` directory.

```
\Users\ymtla\AppData\Roaming\pypoetry\venv\Scripts\poetry shell
python -m venv .venv
poetry install
```

### Related documents on setup

(Only development members can see this document below)

https://school-interview.atlassian.net/wiki/spaces/a8558504ee1440048aefa419afc80e13/pages/34537473/Poetry+Python+Python

## How to run

(You need to turn on poetry shell.)

```
poetry run uvicorn src.main:app --reload  --host 0.0.0.0 --port 8001
```
