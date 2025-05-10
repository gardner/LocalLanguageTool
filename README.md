# LocalLanguageTool
Self-hosted LanguageTool private instance is an offline alternative to Grammarly

![lagnuage tool screenshot](https://languagetool.org/images/mac_illustration.png)

Setting up LanguageTool is easy. If you have DNS ad blocking enabled then you will want to disable abTesting as described in this post.

## docker-compose.yml
```yaml
services:
  languagetool:
    image: silviof/docker-languagetool:latest
    restart: unless-stopped
    command: java -cp languagetool-server.jar org.languagetool.server.HTTPServer --port 8010 --public --allow-origin '*' --config /etc/http_server.cfg
    ports:
      - 127.0.0.1:8010:8010
    volumes:
      - ./ngrams:/ngrams
      - ./http_server.cfg:/etc/http_server.cfg
```

# Download ngrams

These weigh about `8.3`GB

```bash
mkdir ngrams
wget https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip
(cd ngrams && unzip ../ngrams-en-20150817.zip)
rm -f ngrams-en-20150817.zip
```

# Disable AB Testing

To prevent outgoing network requests to fetch said tests:

```
cat <<EOF > http_server.cfg
languageModel=/ngrams
abTest=null
abTestClients=null
EOF
```
## Start Server

```bash
docker compose up -d
```

## Install Browser Extension

* From Chrome [Web Store](https://chromewebstore.google.com/detail/grammar-checker-paraphras/oldceeleldhonbafppcapldpdifcinji
)
* From [Mozilla](https://addons.mozilla.org/en-US/firefox/addon/languagetool/)

## Configure Browser Extension

In advanced config set API server to `http://127.0.0.1:8010/v2`

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/m4rouvvqex4eq0fsqfmq.png)

