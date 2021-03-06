'
' Trims trailing spaces at the end of the files
'

Set fs = CreateObject("Scripting.FileSystemObject")

root_dir = fs.GetParentFolderName(WScript.ScriptFullName)
root_dir = fs.GetAbsolutePathName(root_dir)

ProcessDir(root_dir)

' Trim trailing spaces
Sub TrimFile(file)
	' Create modified file
	Set src = fs.OpenTextFile(file, 1)

	new_str = ""
	Do Until src.AtEndOfStream
		new_str = new_str & RTrim(src.Readline) & vbCrLf
	Loop

	src.Close

	Set dst = fs.OpenTextFile(file, 2, 1)
	dst.Write new_str
	dst.Close
End Sub

' Walk through directory tree
Sub ProcessDir(dir)
	Set dir_obj = fs.GetFolder(dir)

	For Each child_dir In dir_obj.SubFolders
		name = fs.GetFileName(child_dir)
		If Not name = ".git" And Not name = "compiled" Then
			ProcessDir(child_dir)
		End If
	Next

	For Each child_file In dir_obj.Files
		ext = fs.GetExtensionName(child_file)
		name = fs.GetFileName(child_file)

		If (ext = "c" Or ext = "cpp" Or ext = "h" Or ext = "bat" Or _
				ext = "inf" Or ext = "cmd" Or ext = "vbs" Or _
				name = "sources" Or name = "makefile") And _
				Not name = Wscript.ScriptName Then
			TrimFile(child_file)
		End If
	Next
End Sub
