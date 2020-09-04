** Under Development **

# CFWheels plugin of oauth2

A CFWheels plugin of the oauth2 library by Matt Gifford found here [oauth2 CFC](https://github.com/coldfumonkeh/oauth2)

## Example Usage

Add provider settings in config/settings.cfm:

```
// Third Party provider settings
oauth2 = {
  "providers" = {
    "exampleProvider" = {
        "provider"="",
        "client_id"="",
        "client_secret"="",
        "authEndpoint"="",
        "accessTokenEndpoint"="",
        "redirect_uri"=""
    }
  }
};
set(oauth2=oauth2);
```

Init your provider

```
var auth = new oauth2(get("oauth2.providers.exampleProvider"));
```

Original README below:

# oauth2

A ColdFusion CFC to manage authentication using the OAuth2 protocol.

[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/tested-with-testbox.svg)](https://cfmlbadges.monkehworks.com)
[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/compatibility-coldfusion-9.svg)](https://cfmlbadges.monkehworks.com)
[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/compatibility-coldfusion-10.svg)](https://cfmlbadges.monkehworks.com)
[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/compatibility-lucee-45.svg)](https://cfmlbadges.monkehworks.com)
[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/compatibility-lucee-5.svg)](https://cfmlbadges.monkehworks.com)

## Base Component

The core component `oauth2.cfc` can be used as a standalone OAuth2 tool for most providers.

Instantiate the component and pass in the required properties like so:

```
var oOauth2 = new oauth2(
	client_id           = '1234567890',
	client_secret       = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX',
	authEndpoint        = 'http://authprovider.fake/authorize',
	accessTokenEndpoint = 'http://authprovider.fake/token',
	redirect_uri        = 'http://redirect.fake'
);
```

Build the URL that you can then use to redirect the user to the provider for authorization:

```
var strURL = oOauth2.buildRedirectToAuthURL()
```

On your redirect page, once you have received your `code` value from the provider, you can then request the access token like so:

```
var sData = oOauth2.makeAccessTokenRequest( code = url.code );
```

## Providers

Some initial providers have been created for you, more will come.

These are:

* bitbucket
* bitly
* dropbox
* facebook
* freeagent
* freshbooks
* github
* gitlab
* google
* instagram
* linkedin
* microsoft
* monzo
* slack
* soundcloud
* spotify
* strava
* streamlabs

The provider components extend the core component to help lighten the load. They simply help to provide correct OAuth2 access to the provider in question as some have different requirements for parameters to send through.

Instantiation for the provider components is the same as the core, although you don't have to send through the `authEndpoint` and `accessTokenEndpoint` values as they are included in the provider components for you.

### Adding to the providers

You can easily create your own additional providers. If you do, please make a pull request to add them back into the main repository for others to benefit.

To do so, take a look at one of the existing provider components. These extend the core and will always need their own `init`, `buildRedirectToAuthURL` and `makeAccessTokenRequest` methods to make sure the correct required values are sent through to the providers API.



### LinkedIn

#### Instantiation

```
var oLinkedIn = new linkedIn(
	client_id           = '1234567890',
	client_secret       = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX',
	redirect_uri        = 'http://redirect.fake'
);
```

#### Authorization

LinkedIn requires a `state` value for authorization to help protect against CSRF attacks. In this example I'm setting a UUID which can then be persisted to the `redirect_uri` page, but obviously you can make it whatever you want.

```
var strState = createUUID();
var strURL = oLinkedIn.buildRedirectToAuthURL( state = strState );
```

You can optionally choose to send through `scope` values for access. These are sent through as an array into the method, which converts them into query string parameters for you:

```
var strState = createUUID();
var aScope = [
	'r_fullprofile',
	'r_emailaddress',
	'w_share'
];
var strURL = oLinkedIn.buildRedirectToAuthURL(
	state = strState,
	scope = aScope
);
```

### Google

#### Instantiation

```
var oGoogle = new google(
	client_id           = '1234567890',
	client_secret       = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX',
	redirect_uri        = 'http://redirect.fake'
);
```

#### Authorization

Google **recommend** that you send more properties through for the authorization endpoint request. As a result, anything they have recommended I've set to required, which are:

* `scope`
* `access_type` ( defaults to `online` )
* `state`

Optional parameters are:

* `include_granted_scopes` ( defaults to `true` )
* `login_hint`
* `prompt`

```
var strState = createUUID();
var aScope = [
	'https://www.googleapis.com/auth/drive.readonly',
	'https://www.googleapis.com/auth/analytics.readonly'
];
var strURL = oGoogle.buildRedirectToAuthURL(
	scope = aScope,
	state = strState
);
```

Testing
----------------
The component has been tested on Adobe ColdFusion 9 and 10 and Lucee 4.5.


Download
----------------
[OAuth2 CFC](https://github.com/coldfumonkeh/oauth2/downloads)


### 1.1.9 - November 13, 2017

- Created one new provider component
  - Freeagent

### 1.1.8 - October 12, 2017

- Created one new provider component
  - Strava

### 1.1.7 - October 12, 2017

- Created one new provider component
  - Spotify

### 1.1.6 - October 11, 2017

- Created one new provider component
  - Freshbooks

### 1.1.5 - October 11, 2017

- Created two new provider components
  - Facebook
  - Microsoft

### 1.1.4 - October 4, 2017

- Created new provider component
  - Slack

### 1.1.3 - August 1, 2017

- Created new provider components
  - Bitly
  - Gitlab

### 1.1.2 - July 31, 2017

- Created four new provider components
  - Bitbucket
  - Dropbox
  - Github
  - Instagram

### 1.1.0 - July 26, 2017

- Updated core oauth2 component
  - streamlined functions
  - removed unnecessary meta data
  - revised `makeAccessTokenRequest` in light of new provider capabilities (sending through custom formfields)
- Created two new provider components
  - LinkedIn
  - Google

### 1.0.0 - June 03, 2012

- Commit: Initial Release


MIT License

Copyright (c) 2012 Matt Gifford (Monkeh Works Ltd)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
