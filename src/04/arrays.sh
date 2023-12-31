#! /bin/bash

CODES=( 201 204 400 401 403 404 500 501 502 503 )
METHODS=( GET POST PUT PATCH DELETE )
AGENTS=( Chrome , Edge , Firefox , Opera )
VERSIONS=( HTTP/1.1 HTTP/2 HTTP/3 )

#200 - OK
#+Standard response for successful HTTP requests.
#+The actual response will depend on the request method used.
#+In a GET request, the response will contain an entity corresponding
#+to the requested resource. In a POST request, the response will contain
#+an entity describing or containing the result of the action.

#201 - Created
#+The request has been fulfilled, resulting in the creation of a new resource.

#204 - No content
#+The server successfully processed the request, and is not returning any content.

#400 - BAD REQUEST
#+The server cannot or will not process the request 
#+due to an apparent client error (e.g., malformed request syntax,
#+size too large, invalid request message framing, or deceptive request routing).

#401 - UNAUTHORIZED
# Similar to 403 Forbidden, but specifically for use when authentication 
# is required and has failed or has not yet been provided. The response 
# must include a WWW-Authenticate header field containing a challenge 
# applicable to the requested resource. See Basic access authentication 
# and Digest access authentication. 401 semantically means "unauthorised", 
# the user does not have valid authentication credentials for the target resource.
# Some sites incorrectly issue HTTP 401 when an IP address is banned from the website 
# (usually the website domain) and that specific address is refused permission to access a website.

#403 -  FORBIDDEN
# The request contained valid data and was understood by the server, 
# but the server is refusing action. This may be due to the user not 
# having the necessary permissions for a resource or needing an account 
# of some sort, or attempting a prohibited action (e.g. creating 
# a duplicate record where only one is allowed). This code is also 
# typically used if the request provided authentication by answering the 
# WWW-Authenticate header field challenge, but the server did not accept 
# that authentication. The request should not be repeated.

#404 - NOT FOUND
# The requested resource could not be found but may be available 
# in the future. Subsequent requests by the client are permissible

#500 - INTERNAL SERVER ERROR
# A generic error message, given when an unexpected condition 
# was encountered and no more specific message is suitable.

#501 - NOT IMPLEMENTED
# The server either does not recognize the request method, 
# or it lacks the ability to fulfil the request. Usually 
# this implies future availability (e.g., a new feature of a web-service API).

#502 - BAD GATEWAY
# The server was acting as a gateway or proxy and 
# received an invalid response from the upstream server.

#503 -SERVICE UNAVAILABLE
# The server cannot handle the request (because it is overloaded 
# or down for maintenance). Generally, this is a temporary state.








