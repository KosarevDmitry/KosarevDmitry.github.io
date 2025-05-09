---
title: EshopContainer
date: 2025-03-02 17:48:52 +0100
categories: [dotnet]
tags: [architecture]
mermaid: true
---

```mermaid
stateDiagram-v2
    [AppHost] --> redis
    [AppHost] --> RabbitMQ
    [AppHost] --> Postgres
	Postgres--> identitydb
	Postgres--> catalogdb
    state First {
        [*] --> fir
        fir --> [*]
    }
    state Second {
        [*] --> sec
        sec --> [*]
    }
    state Third {
        [*] --> thi
        thi --> [*]
    }


```