# REQM: A High-Performance HTTP Request Library for Python

`REQM` is a high-performance HTTP request library written in C++ and exposed to Python. It leverages `libcurl` to handle HTTP requests and responses asynchronously and synchronously, with advanced features like cookie handling, proxies, retries, and custom headers. This package provides an easy-to-use Python interface to send GET, POST, PUT, DELETE, and other HTTP methods, making it a robust tool for HTTP operations.

---

## Table of Contents

- [Features](#features)
- [Installation](#installation)
  - [Run the `setup.sh` Script](#run-the-setupsh-script)
- [Usage](#usage)
- [Example](#example)
- [License](#license)

---

## Features

- **Synchronous and Asynchronous HTTP Requests**  
  Perform HTTP requests in a blocking (synchronous) or non-blocking (asynchronous) way with coroutines.
  
- **Supports All HTTP Methods**  
  GET, POST, PUT, DELETE, PATCH, OPTIONS, and HEAD methods are supported.
  
- **Advanced Features**  
  - Full cookie, proxy, and retry handling.
  - Custom headers and request bodies.
  
- **Cross-Platform**  
  Works on Linux, macOS, and Windows using the appropriate shared library (`.so`, `.dylib`, or `.dll`).

- **High Performance**  
  Utilizes `libcurl` for high-performance HTTP requests.

---

## Installation

To install the `REQM` library, use the `setup.sh` script. This script will download and install the required files for your platform (Linux, macOS, or Windows). Make sure you have an active internet connection for downloading dependencies.

### Run the `setup.sh` Script

1. Download or clone the `REQM` repository to your machine.
2. Open a terminal and navigate to the project directory.
3. Run the `setup.sh` script:

   ```bash
   bash setup.sh
   ```

4. The script will:
   - Check for required dependencies (`git`, `curl`, `python3`).
   - Clone the repository if not already cloned.
   - Download the required `.so`, `.dylib`, or `.dll` files and `nlohmann-json` header for the project.
   - Install the library into your Python environment.

   The script will automatically download the necessary libraries and install the `REQM` module. You may need `sudo` privileges if you're installing it system-wide or if Python is installed for all users.

---

## Usage

Once `REQM` is installed, you can use it in your Python projects. The module supports both synchronous and asynchronous HTTP requests. Here are a few examples of how to use it.

### Synchronous Request Example

```python
import reqm

# Make a synchronous GET request
response = reqm.get("https://httpbin.org/get")
print(response.status_code)
print(response.text)
```

### Asynchronous Request Example

```python
import reqm
import asyncio

async def fetch_data():
    # Make an asynchronous GET request
    response = await reqm.async_get("https://httpbin.org/get")
    print(response.status_code)
    print(response.text)

# Run the asynchronous function
asyncio.run(fetch_data())
```

### Custom Headers and POST Request Example

```python
import reqm

headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer your_token"
}

# Make a synchronous POST request with custom headers and JSON body
response = reqm.post("https://httpbin.org/post", json={"key": "value"}, headers=headers)
print(response.status_code)
print(response.json())
```

### Handling Cookies

```python
import reqm

# Enable cookie handling
cookies = reqm.cookies()

# Make a GET request and store cookies
response = reqm.get("https://httpbin.org/cookies/set?key=value", cookies=cookies)
print(response.cookies)
```

### Retry Mechanism Example

```python
import reqm

# Perform a GET request with retries
response = reqm.get("https://httpbin.org/get", retries=3)
print(response.status_code)
```

---

## Example

```python
import reqm
import asyncio

async def main():
    # Asynchronous GET request
    response = await reqm.async_get("https://httpbin.org/get")
    print(response.status_code)
    print(response.json())

    # Synchronous POST request
    headers = {"Content-Type": "application/json"}
    response = reqm.post("https://httpbin.org/post", json={"key": "value"}, headers=headers)
    print(response.status_code)
    print(response.json())

asyncio.run(main())
```

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
