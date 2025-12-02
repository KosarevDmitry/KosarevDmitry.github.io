---
title: Architecture patterns
date: 2025-11-30 20:34:21 +0100
categories: [architecture]
tags: []
mermaid: true
---

- **ambassador**

![ambassador](https://github.com/MicrosoftDocs/architecture-center/blob/main/docs/patterns/_images/ambassador.png?raw=true){: width="70%" height="70%" }

You have an application you want, but you don't intend to modify it  adding new features. It's impossible. Don't waste your time on it. An aging general will never learn new skills. He can't even type on a computer, but he can handle his own work, he used to do.

So, you create or hire a smart executive, a secretary-manager, who manages everything in the office. The old application only works as before. It  redirects the resalt to the new proxy app that addresses new issues, implements advanced, cutting-edge features and options. It's important that the manager has access to always be aware of the main application's operation. They should to works in same security scope. 
Usual practice  is when the director's electronic signature keys are held by the chief accountant. Director have to trast to accountant.
Proxy app and legacy app should to run on the same host.



- **corruption layer**
 
![corruption](https://github.com/MicrosoftDocs/architecture-center/blob/main/docs/patterns/_images/anti-corruption-layer.png?raw=true){: width="70%" height="70%" }

- **async request**

202 (accepted) then ok (pending, underway) then  302(redirection) to retrieve recource 

![corruption](https://github.com/MicrosoftDocs/architecture-center/blob/main/docs/patterns/_images/async-request.png?raw=true){: width="70%" height="70%" }

															   


