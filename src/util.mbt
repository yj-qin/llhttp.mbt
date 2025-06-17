///|
fn to_c_str(s : String) -> Bytes {
  let buffer = @buffer.new()
  @encoding.encode_to(s, buffer, encoding=UTF8)
  buffer.write_byte(0)
  return buffer.contents()
}

///|
fn to_mbt_str(bs : Bytes) -> String {
  @encoding.decode_lossy(bs, encoding=UTF8)
}

///|
fn read_str(ptr : @c.Pointer[Byte], len~ : Int = 0) -> String {
  if ptr.is_null() {
    return ""
  }
  if len == 0 {
    let buffer = @buffer.new()
    for i = 0; ptr[i] != 0; i = i + 1 {
      buffer.write_byte(ptr[i])
    }
    buffer.contents() |> to_mbt_str()
  } else {
    read_bytes(ptr, len) |> to_mbt_str()
  }
}

///|
fn read_bytes(ptr : @c.Pointer[Byte], len : Int) -> Bytes {
  let buffer = @buffer.new()
  for i = 0; i < len; i = i + 1 {
    buffer.write_byte(ptr[i])
  }
  buffer.contents()
}
