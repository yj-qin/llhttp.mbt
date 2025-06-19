///|
pub(all) enum Errno {
  OK = 0
  INTERNAL = 1
  STRICT = 2
  CR_EXPECTED = 25
  LF_EXPECTED = 3
  UNEXPECTED_CONTENT_LENGTH = 4
  UNEXPECTED_SPACE = 30
  CLOSED_CONNECTION = 5
  INVALID_METHOD = 6
  INVALID_URL = 7
  INVALID_CONSTANT = 8
  INVALID_VERSION = 9
  INVALID_HEADER_TOKEN = 10
  INVALID_CONTENT_LENGTH = 11
  INVALID_CHUNK_SIZE = 12
  INVALID_STATUS = 13
  INVALID_EOF_STATE = 14
  INVALID_TRANSFER_ENCODING = 15
  CB_MESSAGE_BEGIN = 16
  CB_HEADERS_COMPLETE = 17
  CB_MESSAGE_COMPLETE = 18
  CB_CHUNK_HEADER = 19
  CB_CHUNK_COMPLETE = 20
  PAUSED = 21
  PAUSED_UPGRADE = 22
  PAUSED_H2_UPGRADE = 23
  USER = 24
  CB_URL_COMPLETE = 26
  CB_STATUS_COMPLETE = 27
  CB_METHOD_COMPLETE = 32
  CB_VERSION_COMPLETE = 33
  CB_HEADER_FIELD_COMPLETE = 28
  CB_HEADER_VALUE_COMPLETE = 29
  CB_CHUNK_EXTENSION_NAME_COMPLETE = 34
  CB_CHUNK_EXTENSION_VALUE_COMPLETE = 35
  CB_RESET = 31
  CB_PROTOCOL_COMPLETE = 38
  UNKNOWN = 99
} derive(Show)

///|
pub fn Errno::of_int(errno : Int) -> Errno {
  match errno {
    0 => OK
    1 => INTERNAL
    2 => STRICT
    25 => CR_EXPECTED
    3 => LF_EXPECTED
    4 => UNEXPECTED_CONTENT_LENGTH
    30 => UNEXPECTED_SPACE
    5 => CLOSED_CONNECTION
    6 => INVALID_METHOD
    7 => INVALID_URL
    8 => INVALID_CONSTANT
    9 => INVALID_VERSION
    10 => INVALID_HEADER_TOKEN
    11 => INVALID_CONTENT_LENGTH
    12 => INVALID_CHUNK_SIZE
    13 => INVALID_STATUS
    14 => INVALID_EOF_STATE
    15 => INVALID_TRANSFER_ENCODING
    16 => CB_MESSAGE_BEGIN
    17 => CB_HEADERS_COMPLETE
    18 => CB_MESSAGE_COMPLETE
    19 => CB_CHUNK_HEADER
    20 => CB_CHUNK_COMPLETE
    21 => PAUSED
    22 => PAUSED_UPGRADE
    23 => PAUSED_H2_UPGRADE
    24 => USER
    26 => CB_URL_COMPLETE
    27 => CB_STATUS_COMPLETE
    32 => CB_METHOD_COMPLETE
    33 => CB_VERSION_COMPLETE
    28 => CB_HEADER_FIELD_COMPLETE
    29 => CB_HEADER_VALUE_COMPLETE
    34 => CB_CHUNK_EXTENSION_NAME_COMPLETE
    35 => CB_CHUNK_EXTENSION_VALUE_COMPLETE
    31 => CB_RESET
    38 => CB_PROTOCOL_COMPLETE
    _ => UNKNOWN
  }
}

///|
pub(all) enum ParserType {
  BOTH = 0
  REQUEST = 1
  RESPONSE = 2
  UNKNOWN = 99
} derive(Show)

///|
pub fn ParserType::of_int(typ : Int) -> ParserType {
  match typ {
    0 => BOTH
    1 => REQUEST
    2 => RESPONSE
    _ => UNKNOWN
  }
}

///|
pub(all) enum Method {
  DELETE = 0
  GET = 1
  HEAD = 2
  POST = 3
  PUT = 4
  CONNECT = 5
  OPTIONS = 6
  TRACE = 7
  COPY = 8
  LOCK = 9
  MKCOL = 10
  MOVE = 11
  PROPFIND = 12
  PROPPATCH = 13
  SEARCH = 14
  UNLOCK = 15
  BIND = 16
  REBIND = 17
  UNBIND = 18
  ACL = 19
  REPORT = 20
  MKACTIVITY = 21
  CHECKOUT = 22
  MERGE = 23
  MSEARCH = 24
  NOTIFY = 25
  SUBSCRIBE = 26
  UNSUBSCRIBE = 27
  PATCH = 28
  PURGE = 29
  MKCALENDAR = 30
  LINK = 31
  UNLINK = 32
  SOURCE = 33
  PRI = 34
  DESCRIBE = 35
  ANNOUNCE = 36
  SETUP = 37
  PLAY = 38
  PAUSE = 39
  TEARDOWN = 40
  GET_PARAMETER = 41
  SET_PARAMETER = 42
  REDIRECT = 43
  RECORD = 44
  FLUSH = 45
  QUERY = 46
  UNKNOWN = 99
} derive(Show)

///|
pub fn Method::of_int(mthd : Int) -> Method {
  match mthd {
    0 => DELETE
    1 => GET
    2 => HEAD
    3 => POST
    4 => PUT
    5 => CONNECT
    6 => OPTIONS
    7 => TRACE
    8 => COPY
    9 => LOCK
    10 => MKCOL
    11 => MOVE
    12 => PROPFIND
    13 => PROPPATCH
    14 => SEARCH
    15 => UNLOCK
    16 => BIND
    17 => REBIND
    18 => UNBIND
    19 => ACL
    20 => REPORT
    21 => MKACTIVITY
    22 => CHECKOUT
    23 => MERGE
    24 => MSEARCH
    25 => NOTIFY
    26 => SUBSCRIBE
    27 => UNSUBSCRIBE
    28 => PATCH
    29 => PURGE
    30 => MKCALENDAR
    31 => LINK
    32 => UNLINK
    33 => SOURCE
    34 => PRI
    35 => DESCRIBE
    36 => ANNOUNCE
    37 => SETUP
    38 => PLAY
    39 => PAUSE
    40 => TEARDOWN
    41 => GET_PARAMETER
    42 => SET_PARAMETER
    43 => REDIRECT
    44 => RECORD
    45 => FLUSH
    46 => QUERY
    _ => UNKNOWN
  }
}

///|
pub(all) enum Status {
  CONTINUE = 100
  SWITCHING_PROTOCOLS = 101
  PROCESSING = 102
  EARLY_HINTS = 103
  RESPONSE_IS_STALE = 110
  REVALIDATION_FAILED = 111
  DISCONNECTED_OPERATION = 112
  HEURISTIC_EXPIRATION = 113
  MISCELLANEOUS_WARNING = 199
  OK = 200
  CREATED = 201
  ACCEPTED = 202
  NON_AUTHORITATIVE_INFORMATION = 203
  NO_CONTENT = 204
  RESET_CONTENT = 205
  PARTIAL_CONTENT = 206
  MULTI_STATUS = 207
  ALREADY_REPORTED = 208
  TRANSFORMATION_APPLIED = 214
  IM_USED = 226
  MISCELLANEOUS_PERSISTENT_WARNING = 299
  MULTIPLE_CHOICES = 300
  MOVED_PERMANENTLY = 301
  FOUND = 302
  SEE_OTHER = 303
  NOT_MODIFIED = 304
  USE_PROXY = 305
  SWITCH_PROXY = 306
  TEMPORARY_REDIRECT = 307
  PERMANENT_REDIRECT = 308
  BAD_REQUEST = 400
  UNAUTHORIZED = 401
  PAYMENT_REQUIRED = 402
  FORBIDDEN = 403
  NOT_FOUND = 404
  METHOD_NOT_ALLOWED = 405
  NOT_ACCEPTABLE = 406
  PROXY_AUTHENTICATION_REQUIRED = 407
  REQUEST_TIMEOUT = 408
  CONFLICT = 409
  GONE = 410
  LENGTH_REQUIRED = 411
  PRECONDITION_FAILED = 412
  PAYLOAD_TOO_LARGE = 413
  URI_TOO_LONG = 414
  UNSUPPORTED_MEDIA_TYPE = 415
  RANGE_NOT_SATISFIABLE = 416
  EXPECTATION_FAILED = 417
  IM_A_TEAPOT = 418
  PAGE_EXPIRED = 419
  ENHANCE_YOUR_CALM = 420
  MISDIRECTED_REQUEST = 421
  UNPROCESSABLE_ENTITY = 422
  LOCKED = 423
  FAILED_DEPENDENCY = 424
  TOO_EARLY = 425
  UPGRADE_REQUIRED = 426
  PRECONDITION_REQUIRED = 428
  TOO_MANY_REQUESTS = 429
  REQUEST_HEADER_FIELDS_TOO_LARGE_UNOFFICIAL = 430
  REQUEST_HEADER_FIELDS_TOO_LARGE = 431
  LOGIN_TIMEOUT = 440
  NO_RESPONSE = 444
  RETRY_WITH = 449
  BLOCKED_BY_PARENTAL_CONTROL = 450
  UNAVAILABLE_FOR_LEGAL_REASONS = 451
  CLIENT_CLOSED_LOAD_BALANCED_REQUEST = 460
  INVALID_X_FORWARDED_FOR = 463
  REQUEST_HEADER_TOO_LARGE = 494
  SSL_CERTIFICATE_ERROR = 495
  SSL_CERTIFICATE_REQUIRED = 496
  HTTP_REQUEST_SENT_TO_HTTPS_PORT = 497
  INVALID_TOKEN = 498
  CLIENT_CLOSED_REQUEST = 499
  INTERNAL_SERVER_ERROR = 500
  NOT_IMPLEMENTED = 501
  BAD_GATEWAY = 502
  SERVICE_UNAVAILABLE = 503
  GATEWAY_TIMEOUT = 504
  HTTP_VERSION_NOT_SUPPORTED = 505
  VARIANT_ALSO_NEGOTIATES = 506
  INSUFFICIENT_STORAGE = 507
  LOOP_DETECTED = 508
  BANDWIDTH_LIMIT_EXCEEDED = 509
  NOT_EXTENDED = 510
  NETWORK_AUTHENTICATION_REQUIRED = 511
  WEB_SERVER_UNKNOWN_ERROR = 520
  WEB_SERVER_IS_DOWN = 521
  CONNECTION_TIMEOUT = 522
  ORIGIN_IS_UNREACHABLE = 523
  TIMEOUT_OCCURED = 524
  SSL_HANDSHAKE_FAILED = 525
  INVALID_SSL_CERTIFICATE = 526
  RAILGUN_ERROR = 527
  SITE_IS_OVERLOADED = 529
  SITE_IS_FROZEN = 530
  IDENTITY_PROVIDER_AUTHENTICATION_ERROR = 561
  NETWORK_READ_TIMEOUT = 598
  NETWORK_CONNECT_TIMEOUT = 599
  UNKNOWN = 999
} derive(Show)

///|
pub fn Status::of_int(status : Int) -> Status {
  match status {
    100 => CONTINUE
    101 => SWITCHING_PROTOCOLS
    102 => PROCESSING
    103 => EARLY_HINTS
    110 => RESPONSE_IS_STALE
    111 => REVALIDATION_FAILED
    112 => DISCONNECTED_OPERATION
    113 => HEURISTIC_EXPIRATION
    199 => MISCELLANEOUS_WARNING
    200 => OK
    201 => CREATED
    202 => ACCEPTED
    203 => NON_AUTHORITATIVE_INFORMATION
    204 => NO_CONTENT
    205 => RESET_CONTENT
    206 => PARTIAL_CONTENT
    207 => MULTI_STATUS
    208 => ALREADY_REPORTED
    214 => TRANSFORMATION_APPLIED
    226 => IM_USED
    299 => MISCELLANEOUS_PERSISTENT_WARNING
    300 => MULTIPLE_CHOICES
    301 => MOVED_PERMANENTLY
    302 => FOUND
    303 => SEE_OTHER
    304 => NOT_MODIFIED
    305 => USE_PROXY
    306 => SWITCH_PROXY
    307 => TEMPORARY_REDIRECT
    308 => PERMANENT_REDIRECT
    400 => BAD_REQUEST
    401 => UNAUTHORIZED
    402 => PAYMENT_REQUIRED
    403 => FORBIDDEN
    404 => NOT_FOUND
    405 => METHOD_NOT_ALLOWED
    406 => NOT_ACCEPTABLE
    407 => PROXY_AUTHENTICATION_REQUIRED
    408 => REQUEST_TIMEOUT
    409 => CONFLICT
    410 => GONE
    411 => LENGTH_REQUIRED
    412 => PRECONDITION_FAILED
    413 => PAYLOAD_TOO_LARGE
    414 => URI_TOO_LONG
    415 => UNSUPPORTED_MEDIA_TYPE
    416 => RANGE_NOT_SATISFIABLE
    417 => EXPECTATION_FAILED
    418 => IM_A_TEAPOT
    419 => PAGE_EXPIRED
    420 => ENHANCE_YOUR_CALM
    421 => MISDIRECTED_REQUEST
    422 => UNPROCESSABLE_ENTITY
    423 => LOCKED
    424 => FAILED_DEPENDENCY
    425 => TOO_EARLY
    426 => UPGRADE_REQUIRED
    428 => PRECONDITION_REQUIRED
    429 => TOO_MANY_REQUESTS
    430 => REQUEST_HEADER_FIELDS_TOO_LARGE_UNOFFICIAL
    431 => REQUEST_HEADER_FIELDS_TOO_LARGE
    440 => LOGIN_TIMEOUT
    444 => NO_RESPONSE
    449 => RETRY_WITH
    450 => BLOCKED_BY_PARENTAL_CONTROL
    451 => UNAVAILABLE_FOR_LEGAL_REASONS
    460 => CLIENT_CLOSED_LOAD_BALANCED_REQUEST
    463 => INVALID_X_FORWARDED_FOR
    494 => REQUEST_HEADER_TOO_LARGE
    495 => SSL_CERTIFICATE_ERROR
    496 => SSL_CERTIFICATE_REQUIRED
    497 => HTTP_REQUEST_SENT_TO_HTTPS_PORT
    498 => INVALID_TOKEN
    499 => CLIENT_CLOSED_REQUEST
    500 => INTERNAL_SERVER_ERROR
    501 => NOT_IMPLEMENTED
    502 => BAD_GATEWAY
    503 => SERVICE_UNAVAILABLE
    504 => GATEWAY_TIMEOUT
    505 => HTTP_VERSION_NOT_SUPPORTED
    506 => VARIANT_ALSO_NEGOTIATES
    507 => INSUFFICIENT_STORAGE
    508 => LOOP_DETECTED
    509 => BANDWIDTH_LIMIT_EXCEEDED
    510 => NOT_EXTENDED
    511 => NETWORK_AUTHENTICATION_REQUIRED
    520 => WEB_SERVER_UNKNOWN_ERROR
    521 => WEB_SERVER_IS_DOWN
    522 => CONNECTION_TIMEOUT
    523 => ORIGIN_IS_UNREACHABLE
    524 => TIMEOUT_OCCURED
    525 => SSL_HANDSHAKE_FAILED
    526 => INVALID_SSL_CERTIFICATE
    527 => RAILGUN_ERROR
    529 => SITE_IS_OVERLOADED
    530 => SITE_IS_FROZEN
    561 => IDENTITY_PROVIDER_AUTHENTICATION_ERROR
    598 => NETWORK_READ_TIMEOUT
    599 => NETWORK_CONNECT_TIMEOUT
    _ => UNKNOWN
  }
}

///|
type Parser

///|
/// Make a new parser and initialize the parser with specific type.
/// 
/// Example:
/// 
/// ```moonbit
/// let request = "GET /api/user?id=123 HTTP/1.1\r\n" +
/// "Host: api.example.com\r\n" +
/// "Accept: text/html, application/json\r\n" +
/// "Accept-Language: en-US\r\n" +
/// "Connection: keep-alive\r\n\r\n"
/// 
/// let parser = @llhttp.Parser::new()
/// parser.on_message_begin((_parser) => {
///   println("message begin")
///   OK
/// })
/// parser.on_headers_complete((_parser) => {
///   println("headers complete")
///   OK
/// })
/// parser.on_message_complete((_parser) => {
///   println("message complete")
///   OK
/// })
/// parser.on_protocol((_parser, protocol) => {
///   println("protocol: \{protocol}")
///   OK
/// })
/// parser.on_url((_parser, url) => {
///   println("url: \{url}")
///   OK
/// })
/// parser.on_status((_parser, status) => {
///   println("status: \{status}")
///   OK
/// })
/// parser.on_method((_parser, http_method) => {
///   println("method: \{http_method}")
///   OK
/// })
/// parser.on_version((_parser, version) => {
///   println("version: \{version}")
///   OK
/// })
/// parser.on_header_field((_parser, field) => {
///   println("header_field: \{field}")
///   OK
/// })
/// parser.on_header_value((_parser, value) => {
///   println("header_value: \{value}")
///   OK
/// })
/// let errno = parser.execute(request)
/// println("errno: \{errno}")
/// println("type: \{parser.get_type()}")
/// println("keep-alive: \{parser.should_keep_alive()}")
/// ```
pub extern "c" fn Parser::new(parser_type~ : ParserType = BOTH) -> Parser = "moonbit_llhttp_make"

///|
extern "c" fn llhttp_get_type(parser : Parser) -> Int = "moonbit_llhttp_get_type"

///|
/// Current type of the parser.
pub fn Parser::get_type(self : Parser) -> ParserType {
  llhttp_get_type(self) |> ParserType::of_int()
}

///|
/// Current HTTP major version.
pub extern "c" fn Parser::get_http_major(self : Parser) -> Int = "moonbit_llhttp_get_http_major"

///|
/// Current HTTP minor version.
pub extern "c" fn Parser::get_http_minor(self : Parser) -> Int = "moonbit_llhttp_get_http_minor"

///|
extern "c" fn llhttp_get_method(parser : Parser) -> Int = "moonbit_llhttp_get_method"

///|
/// Current HTTP method.
pub fn Parser::get_method(self : Parser) -> Method {
  llhttp_get_method(self) |> Method::of_int()
}

///|
extern "c" fn llhttp_get_status_code(parser : Parser) -> Int = "moonbit_llhttp_get_status_code"

///|
/// Current HTTP status code.
pub fn Parser::get_status_code(self : Parser) -> Status {
  llhttp_get_status_code(self) |> Status::of_int()
}

///|
extern "c" fn llhttp_get_upgrade(parser : Parser) -> Int = "moonbit_llhttp_get_upgrade"

///|
/// Returns true if the current request is a upgrade request.
pub fn Parser::get_upgrade(self : Parser) -> Bool {
  llhttp_get_upgrade(self) == 1
}

///|
/// Reset an already initialized parser back to the start state, preserving the
/// existing parser type, callback settings.
pub extern "c" fn Parser::reset(self : Parser) -> Unit = "moonbit_llhttp_reset"

///|
extern "c" fn llhttp_execute(parser : Parser, data : Bytes) -> Int = "moonbit_llhttp_execute"

///|
/// Parse full or partial request/response, invoking user callbacks along the
/// way.
/// 
/// If any of the callbacks returns errno not equal to `OK` - the parsing
/// interrupts, and such errno is returned from `execute()`. If
/// `PAUSED` was used as a errno, the execution can be resumed with
/// `resume()` call.
/// 
/// In a special case of CONNECT/Upgrade request/response `PAUSED_UPGRADE`
/// is returned after fully parsing the request/response. If the user wishes to
/// continue parsing, they need to invoke `resume_after_upgrade()`.
/// 
/// NOTE: if this function ever returns a non-pause type error, it will continue
/// to return the same error upon each successive call up until `reset()`
/// is called.
pub fn Parser::execute(self : Parser, data : String) -> Errno {
  let err = llhttp_execute(self, data |> to_c_str())
  Errno::of_int(err)
}

///|
extern "c" fn llhttp_finish(parser : Parser) -> Int = "moonbit_llhttp_finish"

///|
/// This method should be called when the other side has no further bytes to
/// send (e.g. shutdown of readable side of the TCP connection.)
/// 
/// Requests without `Content-Length` and other messages might require treating
/// all incoming bytes as the part of the body, up to the last byte of the
/// connection. This method will invoke `on_message_complete()` callback if the
/// request was terminated safely. Otherwise a error code would be returned.
pub fn Parser::finish(self : Parser) -> Errno {
  let err = llhttp_finish(self)
  Errno::of_int(err)
}

///|
extern "c" fn llhttp_message_needs_eof(parser : Parser) -> Int = "moonbit_llhttp_message_needs_eof"

///|
/// Returns true if the incoming message is parsed until the last byte, and has
/// to be completed by calling `finish()` on EOF.
pub fn Parser::message_needs_eof(self : Parser) -> Bool {
  llhttp_message_needs_eof(self) == 1
}

///|
extern "c" fn llhttp_should_keep_alive(parser : Parser) -> Int = "moonbit_llhttp_should_keep_alive"

///|
/// Returns true if there might be any other messages following the last that was
/// successfully parsed.
pub fn Parser::should_keep_alive(self : Parser) -> Bool {
  llhttp_should_keep_alive(self) == 1
}

///|
/// Make further calls of `execute()` return `PAUSED` and set
/// appropriate error reason.
/// 
/// Important: do not call this from user callbacks! User callbacks must return
/// `PAUSED` if pausing is required.
pub extern "c" fn Parser::pause(self : Parser) -> Unit = "moonbit_llhttp_pause"

///|
/// Might be called to resume the execution after the pause in user's callback.
///
/// Call this only if `execute()` returns `PAUSED`.
pub extern "c" fn Parser::resume_execute(self : Parser) -> Unit = "moonbit_llhttp_resume"

///|
/// Might be called to resume the execution after the pause in user's callback.
///
/// Call this only if `execute()` returns `PAUSED_UPGRADE`.
pub extern "c" fn Parser::resume_after_upgrade(parser : Parser) -> Unit = "moonbit_llhttp_resume_after_upgrade"

///|
extern "c" fn llhttp_get_errno(parser : Parser) -> Int = "moonbit_llhttp_get_errno"

///|
/// Returns the latest errno.
pub fn Parser::errno(self : Parser) -> Errno {
  let errno = llhttp_get_errno(self)
  Errno::of_int(errno)
}

///|
extern "c" fn llhttp_get_error_reason(parser : Parser) -> @c.Pointer[Byte] = "moonbit_llhttp_get_error_reason"

///|
/// Returns the latest error reason.
/// 
/// Note: User callback should set error reason when returning the error. See
/// `set_error_reason()` for details.
pub fn Parser::error_reason(self : Parser) -> String {
  llhttp_get_error_reason(self) |> read_str()
}

///|
extern "c" fn llhttp_set_error_reason(parser : Parser, reason : Bytes) -> Unit = "moonbit_llhttp_set_error_reason"

///|
/// Sets the error reason.
/// 
/// Note: `USER` error code might be useful in user callbacks.
pub fn Parser::set_error_reason(self : Parser, reason : String) -> Unit {
  llhttp_set_error_reason(self, reason |> to_c_str())
}

///|
extern "c" fn llhttp_get_error_pos(parser : Parser) -> @c.Pointer[Byte] = "moonbit_llhttp_get_error_pos"

///|
pub fn Parser::error_pos(self : Parser) -> String {
  llhttp_get_error_pos(self) |> read_str()
}

///|
pub extern "c" fn Parser::on_message_begin(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_message_begin"

///|
pub extern "c" fn Parser::on_headers_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_headers_complete"

///|
pub extern "c" fn Parser::on_message_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_message_complete"

///|
pub extern "c" fn Parser::on_protocol_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_protocol_complete"

///|
pub extern "c" fn Parser::on_url_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_url_complete"

///|
pub extern "c" fn Parser::on_status_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_status_complete"

///|
pub extern "c" fn Parser::on_method_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_method_complete"

///|
pub extern "c" fn Parser::on_version_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_version_complete"

///|
pub extern "c" fn Parser::on_header_field_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_header_field_complete"

///|
pub extern "c" fn Parser::on_header_value_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_header_value_complete"

///|
pub extern "c" fn Parser::on_chunk_extension_name_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_chunk_extension_name_complete"

///|
pub extern "c" fn Parser::on_chunk_extension_value_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_chunk_extension_value_complete"

///|
pub extern "c" fn Parser::on_chunk_header(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_chunk_header"

///|
pub extern "c" fn Parser::on_chunk_complete(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_chunk_complete"

///|
pub extern "c" fn Parser::on_reset(
  self : Parser,
  callback : (Parser) -> Errno
) -> Unit = "moonbit_llhttp_set_on_reset"

///|
extern "c" fn llhttp_set_on_protocol(
  parser : Parser,
  callback : (Parser, @c.Pointer[Byte], Int) -> Errno
) -> Unit = "moonbit_llhttp_set_on_protocol"

///|
fn string_callback(
  cb : (Parser, String) -> Errno
) -> (Parser, @c.Pointer[Byte], Int) -> Errno {
  (parser : Parser, ptr : @c.Pointer[Byte], len : Int) => cb(
    parser,
    read_str(ptr, len~),
  )
}

///|
fn bytes_callback(
  cb : (Parser, Bytes) -> Errno
) -> (Parser, @c.Pointer[Byte], Int) -> Errno {
  (parser : Parser, ptr : @c.Pointer[Byte], len : Int) => cb(
    parser,
    read_bytes(ptr, len),
  )
}

///|
pub fn Parser::on_protocol(
  self : Parser,
  callback : (Parser, String) -> Errno
) -> Unit {
  llhttp_set_on_protocol(self, string_callback(callback))
}

///|
extern "c" fn llhttp_set_on_url(
  parser : Parser,
  callback : (Parser, @c.Pointer[Byte], Int) -> Errno
) -> Unit = "moonbit_llhttp_set_on_url"

///|
pub fn Parser::on_url(
  self : Parser,
  callback : (Parser, String) -> Errno
) -> Unit {
  llhttp_set_on_url(self, string_callback(callback))
}

///|
extern "c" fn llhttp_set_on_status(
  parser : Parser,
  callback : (Parser, @c.Pointer[Byte], Int) -> Errno
) -> Unit = "moonbit_llhttp_set_on_status"

///|
pub fn Parser::on_status(
  self : Parser,
  callback : (Parser, String) -> Errno
) -> Unit {
  llhttp_set_on_status(self, string_callback(callback))
}

///|
extern "c" fn llhttp_set_on_method(
  parser : Parser,
  callback : (Parser, @c.Pointer[Byte], Int) -> Errno
) -> Unit = "moonbit_llhttp_set_on_method"

///|
pub fn Parser::on_method(
  self : Parser,
  callback : (Parser, String) -> Errno
) -> Unit {
  llhttp_set_on_method(self, string_callback(callback))
}

///|
extern "c" fn llhttp_set_on_version(
  parser : Parser,
  callback : (Parser, @c.Pointer[Byte], Int) -> Errno
) -> Unit = "moonbit_llhttp_set_on_version"

///|
pub fn Parser::on_version(
  self : Parser,
  callback : (Parser, String) -> Errno
) -> Unit {
  llhttp_set_on_version(self, string_callback(callback))
}

///|
extern "c" fn llhttp_set_on_header_field(
  parser : Parser,
  callback : (Parser, @c.Pointer[Byte], Int) -> Errno
) -> Unit = "moonbit_llhttp_set_on_header_field"

///|
pub fn Parser::on_header_field(
  self : Parser,
  callback : (Parser, String) -> Errno
) -> Unit {
  llhttp_set_on_header_field(self, string_callback(callback))
}

///|
extern "c" fn llhttp_set_on_header_value(
  parser : Parser,
  callback : (Parser, @c.Pointer[Byte], Int) -> Errno
) -> Unit = "moonbit_llhttp_set_on_header_value"

///|
pub fn Parser::on_header_value(
  self : Parser,
  callback : (Parser, String) -> Errno
) -> Unit {
  llhttp_set_on_header_value(self, string_callback(callback))
}

///|
extern "c" fn llhttp_set_on_chunk_extension_name(
  parser : Parser,
  callback : (Parser, @c.Pointer[Byte], Int) -> Errno
) -> Unit = "moonbit_llhttp_set_on_chunk_extension_name"

///|
pub fn Parser::on_chunk_extension_name(
  self : Parser,
  callback : (Parser, String) -> Errno
) -> Unit {
  llhttp_set_on_chunk_extension_name(self, string_callback(callback))
}

///|
extern "c" fn llhttp_set_on_chunk_extension_value(
  parser : Parser,
  callback : (Parser, @c.Pointer[Byte], Int) -> Errno
) -> Unit = "moonbit_llhttp_set_on_chunk_extension_value"

///|
pub fn Parser::on_chunk_extension_value(
  self : Parser,
  callback : (Parser, String) -> Errno
) -> Unit {
  llhttp_set_on_chunk_extension_value(self, string_callback(callback))
}

///|
extern "c" fn llhttp_set_on_body(
  parser : Parser,
  callback : (Parser, @c.Pointer[Byte], Int) -> Errno
) -> Unit = "moonbit_llhttp_set_on_body"

///|
pub fn Parser::on_body(
  self : Parser,
  callback : (Parser, Bytes) -> Errno
) -> Unit {
  llhttp_set_on_body(self, bytes_callback(callback))
}
