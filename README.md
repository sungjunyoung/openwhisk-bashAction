## bash2action docker image for execute bash script from openwhisk

It allows you to access the value of JSON from the bash by supplying the JSON key as an environment variable. 

## Usage

### Response
Openwhisk can respond only `stdout` of JSON type.
 so if you want to return your custom response, you must 
 return (echo in last) JSON written to `stdout`
 
Like this
```bash
echo "{ \"hello\": \"ran without a docker pull!\" }"
```

If you return simple string, the result would be:
```json
{
  "result": "your custom message"
}
```

### Get values from json

You can access to your JSON values from request by environment variables

1. Objects

    From
    ```json
    {
      "key":{
        "key1":"value1",
        "key2":"value2"
      }
    }
    ```
    
    To
    ```bash
    # in exec
    echo $_key_key1
    echo $_key_key2
 
    # value1
    # value2
    ```

2. List

    From
    ```json
    {
      "key":[
        {"first":"value1"},
        {"second":"value2"}
      ]
    }
    ```

    To
    ```bash
    # in exec
    echo $_key_0_first
    echo $_key_1_first
 
    # value1
    # value2
    ```
    
## How to execute
### In local
1. `docker build -t <your docker tag> .`
2. `docker run -it -p 8080:8080 <your docker tag>`
3. `vi exec`
    ```bash
    #!/bin/bash
    
    echo $_test
    ``` 
4. `zip exec.zip exec && base64 exec.zip`
    ```bash
    UEsDBAoAAAAAAOFteUu08uFhGAAAABgAAAAEABwAZXhlY1VUCQADxvUYWsz1GFp1eAsAAQT1AQAABBQAAAAjIS9iaW4vYmFzaAoKZWNobyAkX3Rlc3RQSwECHgMKAAAAAADhbXlLtPLhYRgAAAAYAAAABAAYAAAAAAABAAAApIEAAAAAZXhlY1VUBQADxvUYWnV4CwABBPUBAAAEFAAAAFBLBQYAAAAAAQABAEoAAABWAAAAAAA=
    ``` 
5. Init your binary

    POST http://localhost:8080/init
    
    JSON body:
    ```json
    {
      "value":{
        "binary":true,
      "code":"UEsDBAoAAAAAAOFteUu08uFhGAAAABgAAAAEABwAZXhlY1VUCQADxvUYWsz1GFp1eAsAAQT1AQAABBQAAAAjIS9iaW4vYmFzaAoKZWNobyAkX3Rlc3RQSwECHgMKAAAAAADhbXlLtPLhYRgAAAAYAAAABAAYAAAAAAABAAAApIEAAAAAZXhlY1VUBQADxvUYWnV4CwABBPUBAAAEFAAAAFBLBQYAAAAAAQABAEoAAABWAAAAAAA"
      }
    }
    ```
6. Execute

    POST http://localhost:8080/run
        
    JSON body:
    
    ```json
    {
        "value":{
            "test":"Hello World!"
        }
    }
    ```
    
    Response would like this
    ```json
    {
        "result":"Hello World!"
    }
    ```
    
    
### in your openwhisk
1. push your docker image to docker hub
2. `wsk action create bash2action --docker <docker image tag (dockerhub)>`
3. `wsk action invoke bash2action --blocking --result -p test "Hello World!"`


## Collaborator
[@upgle](https://github.com/upgle)