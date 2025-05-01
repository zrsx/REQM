import ctypes
import json
import os
import sys
if sys.platform.startswith('win'):
    lib_name = 'mreq.dll'
elif sys.platform.startswith('darwin'):
    lib_name = 'libmreq.dylib'
else:
    lib_name = 'libmreq.so'
lib_path = os.path.join(os.path.dirname(__file__), lib_name)
lib = ctypes.CDLL(lib_path)

class Response:
    def __init__(self, status, reason, text, headers):
        self.status_code = status
        self.reason = reason
        self._text = text
        self.headers = headers

    def text(self):
        return self._text

    def json(self):
        return (self._text).json()
    def __str__(self):
        return f"<mreq {self.status_code} {self.reason}>"

def _call(method, url, headers=None, body=""):
    header_str = json.dumps(headers or {})
    lib.request.argtypes = [ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p]
    lib.request.restype = ctypes.c_char_p
    res = lib.request(method.encode(), url.encode(), header_str.encode(), body.encode()).decode()
    data = json.loads(res)
    return Response(data["status"], data["reason"], data["body"], data["headers"])

def get(url, headers=None):
    return _call("GET", url, headers)

def post(url, headers=None, body=""):
    return _call("POST", url, headers, body)

def put(url, headers=None, body=""):
    return _call("PUT", url, headers, body)

def delete(url, headers=None):
    return _call("DELETE", url, headers)

def patch(url, headers=None, body=""):
    return _call("PATCH", url, headers, body)

def head(url, headers=None):
    return _call("HEAD", url, headers)

def options(url, headers=None):
    return _call("OPTIONS", url, headers)
