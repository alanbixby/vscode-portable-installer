# vscode-portable-installer.sh
A bash script to install VSCode in a Linux environment without sudo rights; written and tested on Debian 10.

---

## Run:

```bash
wget https://raw.githubusercontent.com/alanbixby/vscode-portable-installer/master/vscode-portable-installer.sh
chmod +x ./vscode-portable-installer.sh
./vscode-portable-installer.sh
rm ./vscode-portable-installer.sh
```

## IMPORTANT NOTE: 
If you use the [C/C++ Microsoft extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) and have limited system resources, it is **strongly** recommended to reduce your intellisense cahce from 5GB to 512MB or less. On the university machines this script was written for, students are given 8GB partitions, which this cache eats through.

With VSCode open, press `CTRL SHIFT P`, then navigate to `Settings`, search for `Cache Size` and change the `C_Cpp: Intelli Sense Cache Size` from `5120` to a smaller value like `512` or `256`.
