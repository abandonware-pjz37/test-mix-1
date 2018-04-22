#include <unicode/utypes.h>
#include <rapidjson/reader.h>
#include <websocketpp/version.hpp>
#include <duktape.h>
#include <google/protobuf/message.h>

#if !defined(SKIP_FOLLY)
# include <folly/Chrono.h>
#endif

#if !defined(SKIP_WEBKIT)
# include <cstring> // std::memmove

# include <JavaScriptCore/JSBase.h>
# include <JavaScriptCore/JSContextRef.h>
# include <JavaScriptCore/JSObjectRef.h>
# include <JavaScriptCore/JSStringRef.h>
# include <JavaScriptCore/JSTypedArray.h>
# include <JavaScriptCore/JSValueRef.h>
# include <JavaScriptCore/JavaScript.h>
# include <JavaScriptCore/WebKitAvailability.h>

# include <wtf/Algorithms.h>
# include <wtf/Assertions.h>
# include <wtf/dtoa/double.h> // std::memmove is missing
# include <wtf/persistence/PersistentDecoder.h>
# include <wtf/text/ASCIIFastPath.h>
# include <wtf/threads/BinarySemaphore.h>
# include <wtf/unicode/UTF8.h>
#endif

int main() {
}
