# Third-party notices

`ProximiioMap` links third-party software. Their licences require that the
notices below be reproduced **in the documentation or other materials of the
product you ship** — not just in this repository.

**If your app links `ProximiioMapKit` (directly or through `ProximiioMap`), you
must surface this page to your users.** The usual place is a "Legal" or
"Acknowledgements" screen in Settings. Shipping the map without it is a licence
violation, and it is the app author's obligation, not ours — we can only hand
you the text.

---

## MapLibre Native (iOS)

Pinned version: **6.29.0**
Distribution: <https://github.com/maplibre/maplibre-gl-native-distribution>
Upstream: <https://github.com/maplibre/maplibre-native>
Licence: BSD 2-Clause. Full text also in `ThirdParty-MapLibre-LICENSE.txt`.

```
BSD 2-Clause License

Copyright (c) 2021 MapLibre contributors

Copyright (c) 2018-2021 MapTiler.com

Copyright (c) 2014-2020 Mapbox

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in
  the documentation and/or other materials provided with the
  distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```

MapLibre Native descends from Mapbox GL Native as it stood before Mapbox's
licence change, which is why the Mapbox copyright line is part of the required
notice.

### What MapLibre costs your app

MapLibre is a **dynamic** framework and is embedded and signed into your bundle.
Measured at 6.29.0: device slice 7 823 872 bytes; the whole xcframework 25 MB on
disk. This is the reason the map is a separate package from the SDK — an app
that positions but does not draw a venue map never pays it.

---

## Proximi.io iOS SDK

`ProximiioMap` depends on `proximiio-ios-sdk-v6`. It is Proximi.io software and
carries no separate third-party obligation here, but it links **GRDB** (MIT),
whose notice the SDK is responsible for surfacing. If your app links the SDK —
and every consumer of this package does — check the SDK's own notices too.
