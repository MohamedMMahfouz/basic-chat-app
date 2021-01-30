# README

This is a simple Ruby on Rails app that accepts applications and generate tokens for them, once an application is generated you can create a chat record and then create messages for ur chats. Each chat has a number sequence for its chat such that no two chats can have the same number for the same app. The same goes for messages. The app keeps in mind scalability and race conditions possibilities. The application has a counter called chats_count wich has the value of its chats count. Same for the Chats. Elastic search is used to search for a message and partially match the content of messages

# USAGE
To run the project and run 
````bash
docker-compose up
````
this will create the needed containers which are:
1) db #mysql is used in this project
2) sidekiq
3) app #our rails app
4) elastic_search
5) redis

# API DOC
after running the project locally visit: http://localhost:3000/api-docs/index.html to see the endpoints and try them with swagger

# SPECS
the project is tested using RSPEC, to run the tests run:
````bash
rspec
````

# Caveats
1) The generation of sequences is made with Redis Help to avoid race condition.
On creating a chat or message, A redis unique key is incremented and its value returned in response as well as passing it to a job along with creation params which is queued by sidekiq to create the chat or message later. This insures that no race conditions happens as well as having faster requests processing. However the cost is that the chats and messages will not persist immediately in the database and might take some time depending upon the queue size and queued jobs.

2) The chats_count & messages_count is generated with rails built in counter_cache, however counter caches are not immune to race conditions and might be out of sync everyonce in a while. To resolve this, a cron job is executed every (range of time) which makes 2 raw SQL queries that sync the counters for both tables 


