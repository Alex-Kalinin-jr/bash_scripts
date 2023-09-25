# Bash Scripts

Some scripts for emulating work with folders and files, and with logs.
***use docker or VM (Ubuntu 20.04 LTS) for running scripts, otherwise you risk to fill your filesystem with garbage***

## 01. File generator

Bash script with 6 parameters. \
**Parameter 1** - absolute or relative path. \
**Parameter 2** - number of subfolders. \
**Parameter 3** - list of English alphabet letters used in folder names (no more than 7 characters). \
**Parameter 4** - number of files in each created folder. \
**Parameter 5** - list of English alphabet letters used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). \
**Parameter 6** - file size (in kilobytes, but not more than 100). \
Example: `main.sh /opt/test 4 az 5 az.az 3`

When the script runs, the folders and files are created in the location specified in parameter 1 with the appropriate names and sizes. The script stops running if there is 1GB of free space left on the file system (in the / partition).\
The log file is created with data on all created folders and files (full path, creation date, file size) in the location of **param 1**

## 02. File system clogging

Bash script with 3 parameters.\
**Parameter 1** - list of English alphabet letters used in folder names (no more than 7 characters). \
**Parameter 2** - list of English alphabet letters used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). \
**Parameter 3** - file size (in Megabytes, but not more than 100).
Example: `main.sh az az.az 3`

When the script runs, files and folders are created in different (any, except paths containing **bin** or **sbin**) locations on the file system.
The number of subfolders is up to 100. The number of files in each folder is a random number (different for each folder). The script stops running when there is 1GB of free space left on the file system (in the / partition). \
The log file is created with data on all created folders and files (full path, creation date, file size) in the **/** location.

## 03. Cleaning the file system

The script is run with 1 parameter. The script can clear the system from the folders and files in 3 ways:

**Parameter 1** The cleaning method (1 or 2 or 3).
1. By log file
2. By creation date and time \
*When deleting by date and time of creation, the user enters the start and end times up to the minute. All files created within the specified time interval will be deleted. The input can be implemented either through parameters or at runtime.* \
3. By name mask (i.e. characters, underlining and date).

## 04. Log generator

Bash script that generates **nginx** log files in *combined* format. The log contains emulated information for 1 day.

A random number between 100 and 1000 entries is generated per day.
For each entry there are randomly generated the following:

1. IP (any correct one, i.e. no ip such as 999.111.777.777)
2. Response codes (200, 201, 400, 401, 403, 404, 500, 501, 502, 503)
3. methods (GET, POST, PUT, PATCH, DELETE)
4. Dates (within a specified log day, should be in ascending order)
5. Agent request URL
6. Agents (Mozilla, Google Chrome, Opera, Safari, Internet Explorer, Microsoft Edge, Crawler and bot, Library and net tool)

## 05. Monitoring

Bash script to parse **nginx** logs from [04](#04-log-generator) via **awk**.
The script is run with 1 parameter, which has a value of 1, 2, 3 or 4. \
Depending on the value of the parameter, it outputs the following: 

1. All entries sorted by response code
2. All unique IPs found in the entries
3. All requests with errors (response code - 4xx or 5xxx)
4. All unique IPs found among the erroneous requests


## 06. GoAccess

GoAccess utility adjusting to get the same information as in [05](#05-monitoring). (goaccess.conf file) \
The web interface of the utility is opened on the local machine.
