---
title: Does it need to refactor this code?
date: 2024-09-28 10:22:46 +0200
categories: [C#]
tags: []
---

```
   private HttpMessageHandlerStage SetupHandlerChain()
        {
            // Clone the settings to get a relatively consistent view that won't change after this point.
            // (This isn't entirely complete, as some of the collections it contains aren't currently deeply cloned.)
            HttpConnectionSettings settings = _settings.CloneAndNormalize();

            HttpConnectionPoolManager poolManager = new HttpConnectionPoolManager(settings);

            HttpMessageHandlerStage handler;

            if (settings._credentials == null)
            {
                handler = new HttpConnectionHandler(poolManager);
            }
            else
            {
                handler = new HttpAuthenticatedConnectionHandler(poolManager);
            }

            // DiagnosticsHandler is inserted before RedirectHandler so that trace propagation is done on redirects as well
            if (DiagnosticsHandler.IsGloballyEnabled() && settings._activityHeadersPropagator is DistributedContextPropagator propagator)
            {
                handler = new DiagnosticsHandler(handler, propagator, settings._allowAutoRedirect);
            }

            handler = new MetricsHandler(handler, settings._meterFactory, out Meter meter);

            settings._metrics = new SocketsHttpHandlerMetrics(meter);

            if (settings._allowAutoRedirect)
            {
                // Just as with WinHttpHandler, for security reasons, we do not support authentication on redirects
                // if the credential is anything other than a CredentialCache.
                // We allow credentials in a CredentialCache since they are specifically tied to URIs.
                HttpMessageHandlerStage redirectHandler =
                    (settings._credentials == null || settings._credentials is CredentialCache) ?
                    handler :
                    new HttpConnectionHandler(poolManager);        // will not authenticate

                handler = new RedirectHandler(settings._maxAutomaticRedirections, handler, redirectHandler);
            }

            if (settings._automaticDecompression != DecompressionMethods.None)
            {
                Debug.Assert(_decompressionHandlerFactory is not null);
                handler = _decompressionHandlerFactory(settings, handler);
            }

            // Ensure a single handler is used for all requests.
            if (Interlocked.CompareExchange(ref _handler, handler, null) != null)
            {
                handler.Dispose();
            }

            return _handler;
        }
```