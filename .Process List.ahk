MyGui := Gui(, "Process List")
LV := MyGui.Add("ListView", "x2 y0 w400 h500", ["Process Name","Command Line"])
for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
    LV.Add("", process.Name, process.CommandLine)
MyGui.Show