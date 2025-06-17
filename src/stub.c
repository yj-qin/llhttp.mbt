#include "llhttp#llhttp.h"
#include "moonbit.h"
#include <stdlib.h>
#include <string.h>

#define CONTAINER_OF(ptr, type, member)                                         \
  ((type *)((char *)(ptr) - offsetof(type, member)))

#define DECREF(data, field) if (data->field) { moonbit_decref(data->field); }

#define CB_WRAPPER(field)                                                      \
  static inline int moonbit_llhttp_##field##_cb(llhttp_t *p) {                 \
    moonbit_llhttp_t *parser = CONTAINER_OF(p, moonbit_llhttp_t, parser);       \
    moonbit_llhttp_data_t *data =                                              \
      (moonbit_llhttp_data_t *)parser->parser.data;                            \
    moonbit_llhttp_cb_t *cb = data->field;                                     \
    moonbit_incref(parser);                                                    \
    moonbit_incref(cb);                                                        \
    return (int)cb->code(cb, parser);                                          \
  }                                                                            \
  MOONBIT_FFI_EXPORT                                                           \
  void moonbit_llhttp_set_##field(                                             \
    moonbit_llhttp_t *parser, moonbit_llhttp_cb_t *cb                          \
  ) {                                                                          \
    moonbit_llhttp_data_t *data =                                              \
      (moonbit_llhttp_data_t *)parser->parser.data;                            \
    DECREF(data, field)                                                        \
    data->field = cb;                                                          \
    llhttp_settings_t *settings =                                              \
      (llhttp_settings_t *)parser->parser.settings;                            \
    settings->field = moonbit_llhttp_##field##_cb;                             \
    moonbit_decref(parser);                                                    \
  }

#define DATA_CB_WRAPPER(field)                                                 \
  static inline int moonbit_llhttp_##field##_cb(                               \
    llhttp_t *p, const char *at, size_t len                                    \
  ) {                                                                          \
    moonbit_llhttp_t *parser = CONTAINER_OF(p, moonbit_llhttp_t, parser);       \
    moonbit_llhttp_data_t *data =                                              \
      (moonbit_llhttp_data_t *)parser->parser.data;                            \
    moonbit_llhttp_data_cb_t *cb = data->field;                                \
    moonbit_incref(parser);                                                    \
    moonbit_incref(cb);                                                        \
    return (int)cb->code(cb, parser, at, len);                                 \
  }                                                                            \
  MOONBIT_FFI_EXPORT                                                           \
  void moonbit_llhttp_set_##field(                                             \
    moonbit_llhttp_t *parser, moonbit_llhttp_data_cb_t *cb                     \
  ) {                                                                          \
    moonbit_llhttp_data_t *data =                                              \
      (moonbit_llhttp_data_t *)parser->parser.data;                            \
    DECREF(data, field)                                                        \
    data->field = cb;                                                          \
    llhttp_settings_t *settings =                                              \
      (llhttp_settings_t *)parser->parser.settings;                            \
    settings->field = moonbit_llhttp_##field##_cb;                             \
    moonbit_decref(parser);                                                    \
  }

typedef struct moonbit_llhttp_s {
  llhttp_t parser;
} moonbit_llhttp_t;

typedef struct moonbit_llhttp_cb_s {
  int32_t (*code)(struct moonbit_llhttp_cb_s *, moonbit_llhttp_t *);
} moonbit_llhttp_cb_t;

typedef struct moonbit_llhttp_data_cb_s {
  int32_t (*code)(
    struct moonbit_llhttp_data_cb_s *,
    moonbit_llhttp_t *,
    const char *,
    size_t
  );
} moonbit_llhttp_data_cb_t;

typedef struct moonbit_llhttp_data_s {
  moonbit_llhttp_cb_t *on_message_begin;
  moonbit_llhttp_cb_t *on_headers_complete;
  moonbit_llhttp_cb_t *on_message_complete;
  moonbit_llhttp_cb_t *on_protocol_complete;
  moonbit_llhttp_cb_t *on_url_complete;
  moonbit_llhttp_cb_t *on_status_complete;
  moonbit_llhttp_cb_t *on_method_complete;
  moonbit_llhttp_cb_t *on_version_complete;
  moonbit_llhttp_cb_t *on_header_field_complete;
  moonbit_llhttp_cb_t *on_header_value_complete;
  moonbit_llhttp_cb_t *on_chunk_extension_name_complete;
  moonbit_llhttp_cb_t *on_chunk_extension_value_complete;
  moonbit_llhttp_cb_t *on_chunk_header;
  moonbit_llhttp_cb_t *on_chunk_complete;
  moonbit_llhttp_cb_t *on_reset;
  moonbit_llhttp_data_cb_t *on_protocol;
  moonbit_llhttp_data_cb_t *on_url;
  moonbit_llhttp_data_cb_t *on_status;
  moonbit_llhttp_data_cb_t *on_method;
  moonbit_llhttp_data_cb_t *on_version;
  moonbit_llhttp_data_cb_t *on_header_field;
  moonbit_llhttp_data_cb_t *on_header_value;
  moonbit_llhttp_data_cb_t *on_chunk_extension_name;
  moonbit_llhttp_data_cb_t *on_chunk_extension_value;
  moonbit_llhttp_data_cb_t *on_body;
} moonbit_llhttp_data_t;

static inline moonbit_llhttp_data_t *
moonbit_llhttp_data_make() {
  moonbit_llhttp_data_t *data =
    (moonbit_llhttp_data_t *)malloc(sizeof(moonbit_llhttp_data_t));
  memset(data, 0, sizeof(moonbit_llhttp_data_t));
  return data;
}

static inline void
moonbit_llhttp_data_finalize(moonbit_llhttp_data_t *data) {
  DECREF(data, on_message_begin)
  DECREF(data, on_headers_complete)
  DECREF(data, on_message_complete)
  DECREF(data, on_protocol_complete)
  DECREF(data, on_url_complete)
  DECREF(data, on_status_complete)
  DECREF(data, on_method_complete)
  DECREF(data, on_version_complete)
  DECREF(data, on_header_field_complete)
  DECREF(data, on_header_value_complete)
  DECREF(data, on_chunk_extension_name_complete)
  DECREF(data, on_chunk_extension_value_complete)
  DECREF(data, on_chunk_header)
  DECREF(data, on_chunk_complete)
  DECREF(data, on_reset)
  DECREF(data, on_protocol)
  DECREF(data, on_url)
  DECREF(data, on_status)
  DECREF(data, on_method)
  DECREF(data, on_version)
  DECREF(data, on_header_field)
  DECREF(data, on_header_value)
  DECREF(data, on_chunk_extension_name)
  DECREF(data, on_chunk_extension_value)
  DECREF(data, on_body)
}

static inline llhttp_settings_t *
moonbit_llhttp_settings_make() {
  llhttp_settings_t *settings =
    (llhttp_settings_t *)malloc(sizeof(llhttp_settings_t));
  llhttp_settings_init(settings);
  return settings;
}

static inline void
moonbit_llhttp_finalize(void *object) {
  moonbit_llhttp_t *parser = (moonbit_llhttp_t *)object;
  if (parser->parser.settings) {
    free(parser->parser.settings);
  }
  if (parser->parser.data) {
    moonbit_llhttp_data_finalize(parser->parser.data);
    free(parser->parser.data);
  }
}

MOONBIT_FFI_EXPORT
moonbit_llhttp_t *
moonbit_llhttp_make(llhttp_type_t type) {
  moonbit_llhttp_t *parser = (moonbit_llhttp_t *)moonbit_make_external_object(
    moonbit_llhttp_finalize, sizeof(moonbit_llhttp_t)
  );
  memset(parser, 0, sizeof(moonbit_llhttp_t));
  llhttp_settings_t *settings = moonbit_llhttp_settings_make();
  llhttp_init(&parser->parser, type, settings);
  parser->parser.data = moonbit_llhttp_data_make();
  return parser;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_llhttp_execute(moonbit_llhttp_t *parser, moonbit_bytes_t data) {
  size_t len = strlen((const char *)data);
  llhttp_errno_t errno =
    llhttp_execute(&parser->parser, (const char *)data, len);
  moonbit_decref(parser);
  moonbit_decref(data);
  return errno;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_llhttp_get_type(moonbit_llhttp_t *parser) {
  int32_t type = llhttp_get_type(&parser->parser);
  moonbit_decref(parser);
  return type;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_llhttp_get_http_major(moonbit_llhttp_t *parser) {
  int32_t major = llhttp_get_http_major(&parser->parser);
  moonbit_decref(parser);
  return major;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_llhttp_get_http_minor(moonbit_llhttp_t *parser) {
  int32_t minor = llhttp_get_http_minor(&parser->parser);
  moonbit_decref(parser);
  return minor;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_llhttp_get_method(moonbit_llhttp_t *parser) {
  int32_t method = llhttp_get_method(&parser->parser);
  moonbit_decref(parser);
  return method;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_llhttp_get_status_code(moonbit_llhttp_t *parser) {
  int32_t status = llhttp_get_status_code(&parser->parser);
  moonbit_decref(parser);
  return status;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_llhttp_get_upgrade(moonbit_llhttp_t *parser) {
  int32_t upgrade = llhttp_get_upgrade(&parser->parser);
  moonbit_decref(parser);
  return upgrade;
}

MOONBIT_FFI_EXPORT
void
moonbit_llhttp_reset(moonbit_llhttp_t *parser) {
  llhttp_reset(&parser->parser);
  moonbit_decref(parser);
}

MOONBIT_FFI_EXPORT
llhttp_errno_t
moonbit_llhttp_finish(moonbit_llhttp_t *parser) {
  llhttp_errno_t errno = llhttp_finish(&parser->parser);
  moonbit_decref(parser);
  return errno;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_llhttp_message_needs_eof(moonbit_llhttp_t *parser) {
  int32_t needs_eof = llhttp_message_needs_eof(&parser->parser);
  moonbit_decref(parser);
  return needs_eof;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_llhttp_should_keep_alive(moonbit_llhttp_t *parser) {
  int32_t should_keep_alive = llhttp_should_keep_alive(&parser->parser);
  moonbit_decref(parser);
  return should_keep_alive;
}

MOONBIT_FFI_EXPORT
void
moonbit_llhttp_pause(moonbit_llhttp_t *parser) {
  llhttp_pause(&parser->parser);
  moonbit_decref(parser);
}

MOONBIT_FFI_EXPORT
void
moonbit_llhttp_resume(moonbit_llhttp_t *parser) {
  llhttp_resume(&parser->parser);
  moonbit_decref(parser);
}

MOONBIT_FFI_EXPORT
void
moonbit_llhttp_resume_after_upgrade(moonbit_llhttp_t *parser) {
  llhttp_resume_after_upgrade(&parser->parser);
  moonbit_decref(parser);
}

MOONBIT_FFI_EXPORT
llhttp_errno_t
moonbit_llhttp_get_errno(moonbit_llhttp_t *parser) {
  llhttp_errno_t errno = llhttp_get_errno(&parser->parser);
  moonbit_decref(parser);
  return errno;
}

MOONBIT_FFI_EXPORT
const char *
moonbit_llhttp_get_error_reason(moonbit_llhttp_t *parser) {
  const char *reason = llhttp_get_error_reason(&parser->parser);
  moonbit_decref(parser);
  return reason;
}

MOONBIT_FFI_EXPORT
void
moonbit_llhttp_set_error_reason(moonbit_llhttp_t *parser, moonbit_bytes_t data) {
  llhttp_set_error_reason(&parser->parser, (const char*)data);
  moonbit_decref(data);
  moonbit_decref(parser);
}

MOONBIT_FFI_EXPORT
const char *
moonbit_llhttp_get_error_pos(moonbit_llhttp_t *parser) {
  const char *pos = llhttp_get_error_pos(&parser->parser);
  moonbit_decref(parser);
  return pos;
}

CB_WRAPPER(on_message_begin)
CB_WRAPPER(on_headers_complete)
CB_WRAPPER(on_message_complete)
CB_WRAPPER(on_protocol_complete)
CB_WRAPPER(on_url_complete)
CB_WRAPPER(on_status_complete)
CB_WRAPPER(on_method_complete)
CB_WRAPPER(on_version_complete)
CB_WRAPPER(on_header_field_complete)
CB_WRAPPER(on_header_value_complete)
CB_WRAPPER(on_chunk_extension_name_complete)
CB_WRAPPER(on_chunk_extension_value_complete)
CB_WRAPPER(on_chunk_header)
CB_WRAPPER(on_chunk_complete)
CB_WRAPPER(on_reset)

DATA_CB_WRAPPER(on_protocol)
DATA_CB_WRAPPER(on_url)
DATA_CB_WRAPPER(on_status)
DATA_CB_WRAPPER(on_method)
DATA_CB_WRAPPER(on_version)
DATA_CB_WRAPPER(on_header_field)
DATA_CB_WRAPPER(on_header_value)
DATA_CB_WRAPPER(on_chunk_extension_name)
DATA_CB_WRAPPER(on_chunk_extension_value)
DATA_CB_WRAPPER(on_body)