[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/ryantownsend/event-sourced-cart)

1. Deploy to heroku
2. Attach Kafka
3. Create Kafka topics

```bash
heroku kafka:topics:create carts --app YOUR_APP_NAME_HERE
heroku kafka:topics:create orders --app YOUR_APP_NAME_HERE
```
