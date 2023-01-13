#!/bin/sh

/root/.wasmtime/bin/wasmtime .${SCRIPT_NAME} \
  --env QUERY_STRING="${QUERY_STRING}"\
  --env CONTENT_LENGTH="${CONTENT_LENGTH}"\
  --env PATH="${PATH}"\
  --env HTTP_USER_AGENT="${HTTP_USER_AGENT}"\
  --env REMOTE_ADDR="${REMOTE_ADDR}"\
  --env REMOTE_PORT="${REMOTE_PORT}"\
  --env REQUEST_METHOD="${REQUEST_METHOD}"\
  --env REQUEST_SCHEME="${REQUEST_SCHEME}"\
  --env REQUEST_URI="${REQUEST_URI}"\
  --env HTTP_HOST="${HTTP_HOST}"

# TODO: Add these as needed.
#DOCUMENT_ROOT='/workspaces/dev-wasm-rust/'
#GATEWAY_INTERFACE='CGI/1.1'
#HTTP_ACCEPT='text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'
#HTTP_ACCEPT_ENCODING='gzip, deflate, br'
#HTTP_ACCEPT_LANGUAGE='en-US,en;q=0.9'
#HTTP_CACHE_CONTROL='max-age=0'
#HTTP_CONNECTION='Keep-Alive'
#HTTP_DNT='1'
#HTTP_PROXY_CONNECTION='Keep-Alive'
#HTTP_SEC_CH_UA='"Not?A_Brand";v="8", "Chromium";v="108", "Microsoft Edge";v="108"'
#HTTP_SEC_CH_UA_MOBILE='?0'
#HTTP_SEC_CH_UA_PLATFORM='"Windows"'
#HTTP_SEC_FETCH_DEST='document'
#HTTP_SEC_FETCH_MODE='navigate'
#HTTP_SEC_FETCH_SITE='none'
#HTTP_SEC_FETCH_USER='?1'
#HTTP_SEC_GPC='1'
#HTTP_UPGRADE_INSECURE_REQUESTS='1'
#HTTP_USER_AGENT='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.54'
#HTTP_X_FORWARDED_FOR='97.113.163.223'
#HTTP_X_FORWARDED_HOST='brendandburns-glorious-space-train-w47j4w5r76hrq9-3000.preview.app.github.dev'
#HTTP_X_FORWARDED_PORT='443'
#HTTP_X_FORWARDED_PROTO='https'
#HTTP_X_FORWARDED_SCHEME='https'
#HTTP_X_ORIGINAL_URI='/wagi.wasm?name=brendan'
#HTTP_X_REAL_IP='97.113.163.223'
#HTTP_X_REQUEST_ID='48c4c49a63ad0847a3e63088b42d9327'
#HTTP_X_SCHEME='https'
