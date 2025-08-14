# Make Virtual Port if you want to test in same PC

PS C:\Users\root> $port= new-Object System.IO.Ports.SerialPort COM3,9600,None,8,one
PS C:\Users\root> $port.open()
PS C:\Users\root> $port.open()
PS C:\Users\root> $port.ReadLine()
hello
PS C:\Users\root>