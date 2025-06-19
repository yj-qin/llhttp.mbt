///|
priv struct TestContext {
  mut protocol : String
  mut http_method : String
  mut http_version : String
  mut url : String
  mut status : String
  callback_count : Map[String, Int]
  headers : Map[String, String]
  chunk_extensions : Map[String, String]
  mut body : String
  mut temp_header_field : String
  mut temp_chunk_ext_name : String
} derive(ToJson)

///|
fn TestContext::new() -> TestContext {
  {
    protocol: "",
    http_method: "",
    http_version: "",
    url: "",
    status: "",
    callback_count: Map::new(),
    headers: Map::new(),
    chunk_extensions: Map::new(),
    temp_header_field: "",
    temp_chunk_ext_name: "",
    body: "",
  }
}

///|
fn TestContext::inc_call_count(self : TestContext, key : String) -> Unit {
  self.callback_count[key] = self.callback_count.get_or_default(key, 0) + 1
}

///|
fn setup_parser(ctx : TestContext) -> Parser {
  let parser = @llhttp.Parser::new()
  parser.on_message_begin(_parser => {
    ctx.inc_call_count("message_begin")
    OK
  })
  parser.on_headers_complete(_parser => {
    ctx.inc_call_count("headers_complete")
    OK
  })
  parser.on_message_complete(_parser => {
    ctx.inc_call_count("message_complete")
    OK
  })
  parser.on_protocol_complete(_parser => {
    ctx.inc_call_count("protocol_complete")
    OK
  })
  parser.on_url_complete(_parser => {
    ctx.inc_call_count("url_complete")
    OK
  })
  parser.on_status_complete(_parser => {
    ctx.inc_call_count("status_complete")
    OK
  })
  parser.on_method_complete(_parser => {
    ctx.inc_call_count("method_complete")
    OK
  })
  parser.on_version_complete(_parser => {
    ctx.inc_call_count("version_complete")
    OK
  })
  parser.on_header_field_complete(_parser => {
    ctx.inc_call_count("header_field_complete")
    OK
  })
  parser.on_header_value_complete(_parser => {
    ctx.inc_call_count("header_value_complete")
    OK
  })
  parser.on_chunk_extension_name_complete(_parser => {
    ctx.inc_call_count("chunk_extension_name_complete")
    OK
  })
  parser.on_chunk_extension_value_complete(_parser => {
    ctx.inc_call_count("chunk_extension_value_complete")
    OK
  })
  parser.on_chunk_header(_parser => {
    ctx.inc_call_count("chunk_header")
    OK
  })
  parser.on_chunk_complete(_parser => {
    ctx.inc_call_count("chunk_complete")
    OK
  })
  parser.on_reset(_parser => {
    ctx.inc_call_count("reset")
    OK
  })
  parser.on_protocol((_parser, protocol) => {
    ctx.protocol = protocol
    OK
  })
  parser.on_url((_parser, url) => {
    ctx.url = url
    OK
  })
  parser.on_status((_parser, status) => {
    ctx.status = status
    OK
  })
  parser.on_method((_parser, http_method) => {
    ctx.http_method = http_method
    OK
  })
  parser.on_version((_parser, version) => {
    ctx.http_version = version
    OK
  })
  parser.on_header_field((_parser, field) => {
    ctx.temp_header_field = field
    OK
  })
  parser.on_header_value((_parser, value) => {
    ctx.headers.set(ctx.temp_header_field, value)
    ctx.temp_header_field = ""
    OK
  })
  parser.on_chunk_extension_name((_parser, name) => {
    ctx.temp_chunk_ext_name = name
    OK
  })
  parser.on_chunk_extension_value((_parser, value) => {
    ctx.chunk_extensions[ctx.temp_chunk_ext_name] = value
    ctx.temp_chunk_ext_name = ""
    OK
  })
  parser.on_body((_parser, bytes) => {
    ctx.body += bytes |> @encoding.decode_lossy(encoding=UTF8)
    OK
  })
  parser
}

///|
test "get request" {
  let get_req : String = "GET /api/user?id=123 HTTP/1.1\r\n" +
    "Host: api.example.com\r\n" +
    "Accept: text/html, application/json\r\n" +
    "Accept-Language: en-US\r\n" +
    "Connection: keep-alive\r\n\r\n"
  let ctx = TestContext::new()
  let parser = setup_parser(ctx)
  let errno = parser.execute(get_req)
  inspect(errno, content="OK")
  inspect(parser.get_type(), content="REQUEST")
  inspect(parser.should_keep_alive(), content="true")
  @json.inspect(ctx, content={
    "protocol": "HTTP",
    "http_method": "GET",
    "http_version": "1.1",
    "url": "/api/user?id=123",
    "status": "",
    "callback_count": {
      "message_begin": 1,
      "method_complete": 1,
      "url_complete": 1,
      "protocol_complete": 1,
      "version_complete": 1,
      "header_field_complete": 4,
      "header_value_complete": 4,
      "headers_complete": 1,
      "message_complete": 1,
    },
    "headers": {
      "Host": "api.example.com",
      "Accept": "text/html, application/json",
      "Accept-Language": "en-US",
      "Connection": "keep-alive",
    },
    "chunk_extensions": {},
    "body": "",
    "temp_header_field": "",
    "temp_chunk_ext_name": "",
  })
}

///|
test "post request" {
  let post_req : String = "POST /api HTTP/1.1\r\n" +
    "Content-Type: application/json\r\n" +
    "Content-Length: 17\r\n\r\n" +
    "{\"data\":\"value\"}"
  let ctx = TestContext::new()
  let parser = setup_parser(ctx)
  let errno = parser.execute(post_req)
  inspect(errno, content="OK")
  inspect(parser.get_type(), content="REQUEST")
  @json.inspect(ctx, content={
    "protocol": "HTTP",
    "http_method": "POST",
    "http_version": "1.1",
    "url": "/api",
    "status": "",
    "callback_count": {
      "message_begin": 1,
      "method_complete": 1,
      "url_complete": 1,
      "protocol_complete": 1,
      "version_complete": 1,
      "header_field_complete": 2,
      "header_value_complete": 2,
      "headers_complete": 1,
    },
    "headers": { "Content-Type": "application/json", "Content-Length": "17" },
    "chunk_extensions": {},
    "body": "{\"data\":\"value\"}",
    "temp_header_field": "",
    "temp_chunk_ext_name": "",
  })
}

///|
test "invalid method request" {
  let invalid_method_req : String = "INVALID /path HTTP/1.1\r\n" +
    "Host: test.com\r\n\r\n"
  let ctx = TestContext::new()
  let parser = setup_parser(ctx)
  let errno = parser.execute(invalid_method_req)
  inspect(errno, content="INVALID_METHOD")
  inspect(parser.get_type(), content="REQUEST")
  inspect(parser.errno(), content="INVALID_METHOD")
  inspect(parser.error_reason(), content="Invalid method encountered")
  @json.inspect(ctx, content={
    "protocol": "",
    "http_method": "",
    "http_version": "",
    "url": "",
    "status": "",
    "callback_count": { "message_begin": 1 },
    "headers": {},
    "chunk_extensions": {},
    "body": "",
    "temp_header_field": "",
    "temp_chunk_ext_name": "",
  })
}

///|
test "chunked request" {
  let chunk1 = "POST /upload HTTP/1.1\r\n" +
    "Transfer-Encoding: chunked\r\n\r\n" +
    "3\r\nabc\r\n"
  let chunk2 = "4\r\ndefg\r\n"
  let chunk3 = "0\r\n\r\n"
  let ctx = TestContext::new()
  let parser = setup_parser(ctx)
  let errno = parser.execute(chunk1)
  inspect(errno, content="OK")
  let errno = parser.execute(chunk2)
  inspect(errno, content="OK")
  let errno = parser.execute(chunk3)
  inspect(errno, content="OK")
  inspect(parser.get_type(), content="REQUEST")
  @json.inspect(ctx, content={
    "protocol": "HTTP",
    "http_method": "POST",
    "http_version": "1.1",
    "url": "/upload",
    "status": "",
    "callback_count": {
      "message_begin": 1,
      "method_complete": 1,
      "url_complete": 1,
      "protocol_complete": 1,
      "version_complete": 1,
      "header_field_complete": 1,
      "header_value_complete": 1,
      "headers_complete": 1,
      "chunk_header": 3,
      "chunk_complete": 3,
      "message_complete": 1,
    },
    "headers": { "Transfer-Encoding": "chunked" },
    "chunk_extensions": {},
    "body": "abcdefg",
    "temp_header_field": "",
    "temp_chunk_ext_name": "",
  })
}

///|
test "websocket upgrade request" {
  let ws_upgrade_req : String = "GET /chat HTTP/1.1\r\n" +
    "Upgrade: websocket\r\n" +
    "Connection: Upgrade\r\n" +
    "Sec-WebSocket-Key: abcde\r\n\r\n"
  let ctx = TestContext::new()
  let parser = setup_parser(ctx)
  let errno = parser.execute(ws_upgrade_req)
  inspect(errno, content="PAUSED_UPGRADE")
  inspect(parser.get_type(), content="REQUEST")
  inspect(parser.get_upgrade(), content="true")
  @json.inspect(ctx, content={
    "protocol": "HTTP",
    "http_method": "GET",
    "http_version": "1.1",
    "url": "/chat",
    "status": "",
    "callback_count": {
      "message_begin": 1,
      "method_complete": 1,
      "url_complete": 1,
      "protocol_complete": 1,
      "version_complete": 1,
      "header_field_complete": 3,
      "header_value_complete": 3,
      "headers_complete": 1,
      "message_complete": 1,
    },
    "headers": {
      "Upgrade": "websocket",
      "Connection": "Upgrade",
      "Sec-WebSocket-Key": "abcde",
    },
    "chunk_extensions": {},
    "body": "",
    "temp_header_field": "",
    "temp_chunk_ext_name": "",
  })
}

///|
test "ok response" {
  let ok_resp : String = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nContent-Length: 11\r\n\r\nHello World"
  let ctx = TestContext::new()
  let parser = setup_parser(ctx)
  let errno = parser.execute(ok_resp)
  inspect(errno, content="OK")
  inspect(parser.get_type(), content="RESPONSE")
  @json.inspect(ctx, content={
    "protocol": "",
    "http_method": "HTTP/",
    "http_version": "1.1",
    "url": "",
    "status": "OK",
    "callback_count": {
      "message_begin": 1,
      "version_complete": 1,
      "status_complete": 1,
      "header_field_complete": 2,
      "header_value_complete": 2,
      "headers_complete": 1,
      "message_complete": 1,
    },
    "headers": { "Content-Type": "text/html", "Content-Length": "11" },
    "chunk_extensions": {},
    "body": "Hello World",
    "temp_header_field": "",
    "temp_chunk_ext_name": "",
  })
}

///|
test "chunked response" {
  let chunk1 = "HTTP/1.1 200 OK\r\nTransfer-Encoding: chunked\r\n\r\n5\r\nHello\r\n"
  let chunk2 = "8\r\n, world!\r\n"
  let chunk3 = "0\r\n\r\n"
  let ctx = TestContext::new()
  let parser = setup_parser(ctx)
  let errno = parser.execute(chunk1)
  inspect(errno, content="OK")
  let errno = parser.execute(chunk2)
  inspect(errno, content="OK")
  let errno = parser.execute(chunk3)
  inspect(errno, content="OK")
  inspect(parser.get_type(), content="RESPONSE")
  @json.inspect(ctx, content={
    "protocol": "",
    "http_method": "HTTP/",
    "http_version": "1.1",
    "url": "",
    "status": "OK",
    "callback_count": {
      "message_begin": 1,
      "version_complete": 1,
      "status_complete": 1,
      "header_field_complete": 1,
      "header_value_complete": 1,
      "headers_complete": 1,
      "chunk_header": 3,
      "chunk_complete": 3,
      "message_complete": 1,
    },
    "headers": { "Transfer-Encoding": "chunked" },
    "chunk_extensions": {},
    "body": "Hello, world!",
    "temp_header_field": "",
    "temp_chunk_ext_name": "",
  })
}
