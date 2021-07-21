# Sinatra + Nginx + Docker compose

## What is this

Small Sintatra application with nginx proxy
proxy is runned on 444 port, to change it to default you need change ports in [docker-compose.yml](https://github.com/pereslop/self-signed-sinatra/blob/79f60069acc6dc92b8080874fe632e6066fbfe32/docker-compose.yml#L17) and [nginx.conf](https://github.com/pereslop/self-signed-sinatra/blob/79f60069acc6dc92b8080874fe632e6066fbfe32/proxy/nginx.conf#L13)

This might be a useful project if:

- you need a place to spin up and test nginx configs
- you haven't seen an nginx image used without a `Dockerfile`
- you've never linked containers together using docker compose
- you need a super simple example of sinatra app that's wired up correctly to rackup.
- you need to test connection to applications with self-signed cetrificates
Update: I wrote a [blog post](https://booyaa.wtf/2018/sketchpad-project-sinatra-nginx-docker-compose/) explaining the background behind this project.

## Usage

```shell
echo '127.0.0.1 my-site.com' >> /etc/hosts
docker-compose up
```
copy sertificate from your nginx contaiter
```shell
docker cp  <nginx container id>:/etc/ssl/certs/my-site.com.crt /Users/<your_user_folder>
```
then grag and drop it to your Keychain Access

and visit [https://my-site.com:444/api/webhooks](https://my-site.com:444/api/webhooks)

if you want to use your own hostname you need to generate certificate for its hostname
```shell
openssl req -newkey rsa:2048 -nodes -keyout proxy/my-site.com.key -x509 -days 365 -out proxy/my-site.com.crt
```
there you need to to type certificate host, and other 
after losing several seconds of your life, you can clean up using


## Routes and expected outcomes

| Method | Sinatra          | Nginx         | Params (In) | Params (Out) |
|--------|------------------|---------------|-------------|--------------|
| GET    | /api/v2/webhooks | /api/webhooks | none        | version=2    |
| POST   | /api/v2/webhooks | /api/webhooks | none        | version=2    |
| GET    | /api/webhooks    | as-is         | version=3   | as-is        |
| POST   | /api/webhooks    | as-is         | version=3   | as-is        |

## License

MIT
