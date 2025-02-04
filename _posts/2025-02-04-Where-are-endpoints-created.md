---
title: Where are endpoints created?
date: 2025-02-04 11:02:40 +0100
categories: [AspNetCore]
tags: [Endpoints]
---

Since the CreatePoints call is not done directly. I couldn't see it quickly. I fiddled around. Therefore, for those who, like me, like to answer direct questions with simple answers, I inform you.

Endpoints list creation  are started by `Subscribe()` in Microsoft.AspNetCore.Mvc.Routing. ControllerActionEndpointDataSource ctor.
In the base class `Subscribe` passes `UpdateEndpoints` as action   to `ChangeToken.OnChange`.
The `UpdateEndpoints()` calls `CreatePoints()`.

There is not enough information for one post, but it needs to be saved somewhere.