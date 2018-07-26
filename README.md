#### Simple system unix-like checks in the bash shell.

##### To run, you need to describe the configuration file and execute app with him

##### Example with use cron:
```*/1	*	*	*	*   cd /opt/project/monitoring && ./app ./config 2>&1 >> /var/log/monitoring.log"```
