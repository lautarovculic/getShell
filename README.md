# getShell (bash)
This Bash script enables remote shell access via a provided URL, executing commands on the remote system and displaying the results.

## Usage

To use this script, follow these steps:

1. Clone this repository to your local system.

```bash
git clone https://github.com/your_username/your_repository.git
```
2. Navigate to the cloned directory.
    
```bash
cd getShell
```
3. Run the getShell.sh script providing the URL of the remote shell.

```bash
./getShell.sh -u URL
```
Where URL is the address of the remote shell you wish to access.

## Options

The script supports the following options:

    -u URL: Specifies the URL of the remote shell.
    -h: Displays the help panel, describing the usage and available options of the script.

## Requirements

This script requires having the curl command installed on your system to make HTTP requests to the remote shell.

## Example
```bash
./getShell.sh -u http://127.0.0.1:1337/shell.php
```
This command will establish a connection to the remote shell hosted at http://127.0.0.1:1337/shell.php.

# getShell (python)

This Python script provides functionality for a remote shell, allowing users to execute commands on the remote system and view the output.

## Usage

Same as bash, but run the remote_shell.py script.
```bash
rlwrap python3 getShell.py
```
You will be prompted with a shell prompt where you can input commands. Enter commands as needed.

## Requirements

    Python 3
    requests library (pip install requests)

## Features

    Executes commands on the remote system.
    Displays the output of the executed commands.
    Supports clearing the output after each command execution.

## Note

Ensure that the remote server's IP address and endpoint in the script match your setup. Modify the requests.get calls in the runCMD and writeCMD functions accordingly.

## Thanks
To s4vitar (https://github.com/s4vitar) for the bash course, where I take those scripts.
