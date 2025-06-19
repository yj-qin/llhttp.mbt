# llhttp.mbt

[llhttp](https://github.com/nodejs/llhttp) bindings for MoonBit. 

# Usage

```moonbit
  let request = "GET /api/user?id=123 HTTP/1.1\r\n" +
  "Host: api.example.com\r\n" +
  "Accept: text/html, application/json\r\n" +
  "Accept-Language: en-US\r\n" +
  "Connection: keep-alive\r\n\r\n"

  let parser = @llhttp.Parser::new()
  parser.on_message_begin((_parser) => {
    println("message begin")
    OK
  })
  parser.on_headers_complete((_parser) => {
    println("headers complete")
    OK
  })
  parser.on_message_complete((_parser) => {
    println("message complete")
    OK
  })
  parser.on_protocol((_parser, protocol) => {
    println("protocol: \{protocol}")
    OK
  })
  parser.on_url((_parser, url) => {
    println("url: \{url}")
    OK
  })
  parser.on_status((_parser, status) => {
    println("status: \{status}")
    OK
  })
  parser.on_method((_parser, http_method) => {
    println("method: \{http_method}")
    OK
  })
  parser.on_version((_parser, version) => {
    println("version: \{version}")
    OK
  })
  parser.on_header_field((_parser, field) => {
    println("header_field: \{field}")
    OK
  })
  parser.on_header_value((_parser, value) => {
    println("header_value: \{value}")
    OK
  })
  let errno = parser.execute(get_request_1)
  println("errno: \{errno}")
  println("type: \{parser.get_type()}")
  println("keep-alive: \{parser.should_keep_alive()}")

  // console output:
  //
  // message begin
  // method: GET
  // url: /api/user?id=123
  // protocol: HTTP
  // version: 1.1
  // header_field: Host
  // header_value: api.example.com
  // header_field: Accept
  // header_value: text/html, application/json
  // header_field: Accept-Language
  // header_value: en-US
  // header_field: Connection
  // header_value: keep-alive
  // headers complete
  // message complete
  // errno: OK
  // type: REQUEST
  // keep-alive: true
```
# License
MIT
