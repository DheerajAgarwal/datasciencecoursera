library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "feae1f509fea24ff93be",
                   secret = "0e2f458f4fce6ac662cf8e65bb690828ca906797")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)

##Now content is a JSON data (I don't know how and why)
## Hence converting the content
library(jsonlite)
input <- content(req)
output <- fromJSON(toJSON(input))

output2 <- output[output$name=="datasharing",]
output3 <- output2$created_at
print(output3)