---
title: Container healthcheck loop
date: 2025-02-06 13:59:03 +0100
categories: [docker]
tags: [docker]
---

A year ago I was figuring out the topic and simultaneously practicing with `puml`. Sometimes it is very useful in a graphic form, it seems clear to me.

- Script 

	```bash
	FROM ubuntu 
	HEALTHCHECK --interval=12s --timeout=3s \ 
	CMD curl -f http://localhost/ || exit 1 
	```

- Args

	- `--interval=DURATION (default: 30s) `
	- `--timeout=DURATION (default: 30s) `
	- `--retries=N (default: 3) `
	- `--start-period=DURATION (default: 0s) `
	- `--start-interval=DURATION (default: 5s) `

- Loop

![Healthcheck loop](/assets/scheme_healthcheck_loop.png)
