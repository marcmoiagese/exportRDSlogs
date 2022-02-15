# exportRDSlogs
script to allow customer download RDS logs


## To review the available logs
```
# ./Export_RDS-logs.sh 

{
    "DescribeDBLogFiles": [
        {
            "LastWritten": 1644681429208, 
            "LogFileName": "error/postgresql.log.2022-02-12-15", 
            "Size": 4340
        }, 
        {
            "LastWritten": 1644685032429, 
            "LogFileName": "error/postgresql.log.2022-02-12-16", 
            "Size": 3909
        }, 
        {
            "LastWritten": 1644688636273, 
            "LogFileName": "error/postgresql.log.2022-02-12-17", 
            "Size": 3912
        } 
    ]
}
```


### Download logs
You can download one log specifying the date

```
Export_RDS-logs.sh 2022-02-12-15
```

Or you can download a batch of logs if you define a period of dates

```
Export_RDS-logs.sh 2022-02-12-15 2022-02-12-17
```


you need set the instance and the path to store the logs on the follow variables

DESTI="path_to_store_logs"
INSTANCE="instancia"

