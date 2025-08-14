$port = New-Object System.IO.Ports.SerialPort
$port.PortName = "COM6"
$port.BaudRate = "9600"
$port.Parity = "None"
$port.DataBits = 8
$port.StopBits = 1
$port.ReadTimeout = 9000 # 9 seconds
#$port.DtrEnable = "true"

$port.open() #opens serial connection

Start-Sleep 5 # wait 2 seconds until Arduino is ready

#$port.Write("93c") #writes your content to the serial connection

try
{
   while($myinput = $port.ReadLine())
   {
   echo "Read input"
   echo $myinput
   }
}

catch [TimeoutException]
{
# Error handling code here
}

finally
{
# Any cleanup code goes here
} 

$port.Close() #closes serial connection