## bash2action docker image for execute bash script from openwhisk 

### TEST : 

#### bash script

```sh
#!/bin/bash

echo $_testObj_testObjKey $_testList_0 $_testList_1 $_testKey
```

#### POST http://localhost:8080/run

```json
{
	"value":{
		"testObj": {" ": "testObjValue"},
    "testList": ["testList0", "testList1", "testList2"],
    "testKey": "testValue"
	}
}
```