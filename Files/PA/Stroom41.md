DateTime.GetCurrentDateTime.Local DateTimeFormat: DateTime.DateTimeFormat.DateAndTime CurrentDateTime=> CurrentDateTime
Text.ConvertDateTimeToText.FromDateTime DateTime: CurrentDateTime StandardFormat: Text.WellKnownDateTimeFormat.LongTime Result=> Starttijd
Excel.Attach DocumentName: $'''E:\\VagrantBP\\Data.xlsx''' Instance=> ExcelInstance
UIAutomation.FocusWindow.FocusByInstanceOrHandle WindowInstance: ExcelInstance
Excel.GetFirstFreeRowOnColumn Instance: ExcelInstance Column: 1 FirstFreeRowOnColumn=> FirstFreeRowOnColumn
Excel.WriteToExcel.WriteCell Instance: ExcelInstance Value: StroomID Column: 1 Row: FirstFreeRowOnColumn
Excel.WriteToExcel.WriteCell Instance: ExcelInstance Value: Starttijd Column: 2 Row: FirstFreeRowOnColumn
UIAutomation.PressButton Button: appmask['Window \'Test.xlsx - Excel\'']['Button \'Opslaan\'']
System.RunApplication.RunApplication ApplicationPath: $'''mstsc.exe''' WorkingDirectory: $'''C:\\WINDOWS\\system32''' WindowStyle: System.ProcessWindowStyle.Normal ProcessId=> AppProcessId
UIAutomation.PressButton Button: appmask['Window \'Verbinding met extern bureaublad\'']['Button \'Verbinden\'']
WAIT 1
MouseAndKeyboard.MoveMouseToImage.ClickImage Images: [imgrepo['StartAf'], imgrepo['Stroom6']] SearchForImageOn: MouseAndKeyboard.SearchTarget.EntireScreen MousePositionOnImage: MouseAndKeyboard.PositionOnImage.MiddleRight OffsetX: 0 OffsetY: 0 Tolerance: 10 MovementStyle: MouseAndKeyboard.MovementStyle.Instant Occurence: 1 Timeout: 5 ClickType: MouseAndKeyboard.ClickType.DoubleClick SecondsBeforeClick: 1 SearchAlgorithm: MouseAndKeyboard.ImageFinderAlgorithm.Legacy

# [ControlRepository][PowerAutomateDesktop]

{
  "ControlRepositorySymbols": [
    {
      "IgnoreImagesOnSerialization": false,
      "ImportMetadata": {
        "DisplayName": "Computer",
        "ConnectionString": "",
        "Type": "Local",
        "DesktopType": "local"
      },
      "Name": "appmask"
    }
  ],
  "ImageRepositorySymbol": {
    "Repository": "{\r\n  \"Folders\": [],\r\n  \"Images\": [\r\n    {\r\n      \"Id\": \"25e0fa82-b1a2-4bce-8d02-745db7fbb725\",\r\n      \"Name\": \"StartAf\",\r\n      \"Screenshot\": \"iVBORw0KGgoAAAANSUhEUgAAAOUAAAAjCAYAAABreM2/AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAASCSURBVHhe7Zq/axVBEMetbPxL7BL/AVEQGwslaGUnWAYxP0RttBXEkKCNpA2KUVAbCwuriCAiCP4ArSw0hggqihhx3N27vZ3Zm7t3dy8x673vgw++d3M7Mzs739t98e3YcZIoJdbXVgEYaSBKABIDogQgMSBKABIDogQgMSBKABIDogQgMSBKABIDogQgMSBKABIDogQgMQaK8g11f11X/A1CSxKAfvGDzl/+SU/fa7aGouwirq7jtCQB6Bc/6ITp9Z1Tv+nSo88le29EeWdmjI7Nryi2FVo4Okazy+b98jTtGZ+mO6V7tocn8xO0Z+aWaqsmm48+12G5RbPjY6ZGtl6sbuq9wzDYN19PV6ejc/Qkuuf/xYryNy0++kWHThHtXfxOrz4Ee392yirBPZ6jYy2E2E0o3fiXsZogH2zpiLJ/ZKK8bd+//0KLl//QrjMbdOP5J2fv0fE1e8rHC9228UdXlLFQIMqtg4nS8Yme39ug8ck/dHjpW7++U9qFlE0eLb7YNXPbvL1mxpnj0YIdnx/fsiOcuc/uwNHRqdQwzm80rrg/i1P4ZflVilLb3dm1OL6bdxF/ghYes3GCKJciRji2huu+dnJMLCQ3BzGO2Svr4n2He4WffC2KOYo18GN5znVzTpFYlBmrL7/TxQtGB5owOP+TKEtH2PizIspYcCWhDBKl88maQokRBCSbsXqnLDctjylFaZqT+XACVX0aTG6zUS5VufnPouGjubr8WW3EfBrURdSB19itG8tNESVfVzfnaI3SRhdlxtrWibIr5STbII+wsnkNNY3haStKTVjW7vyKeDnWX36/NtYjbXZeocFL8+Io+VYhY+iijOsTYmt2m2c239q6iLGD4pjPiijF/Vqdk2YTRNnk9eKhPqatoMtJtiM0g2xkxxaI0r4vjl0MZ7djFZv3pzVuIDQ4F7JFNKzB+VH8ezunlG/hN65HdX2y2NkDUPhyZDWvrYvwrayTQcxxRETZ+PhaR7yLLq1lQrQve73LLsuT7IRfIEVMWyHK0KTBXmDj1QikXpRZHJuf/5df5/EH5esRjW6QY5uJMviw9rKYPLV1Eb61ONm1YnzvRdnyDz0a8e759Z25fpXo4wbRlcnt3Sn9ooWnMrN1EaUbw5rPNgj3HdsFUXNFDBKlizUzHXbMHC6uWGj2sy7KeL55nQaIUvhycw+5uPyrHjoN6uJjlXKOa9xGlM+u0fHxIzS/Ym1v6P65A7R/6ia9Nra3d8/SwX2nafklG7stMFF2+S+RpkwZYTpxKrY2lCfQHtcsWkM0ECU/lnlb5i+7Zps4FoJvogAXUfmYJ/zWiTIfG4taxHdzYr6NiCuFIvKcMPfy+Looi79O52PimjpBFXYDn09lXcq1F37iGvdUlJ1/PFCF2A3N7vjC7JIPzG6p3dsGmTwAfcSKcoif2VXhvy8W4lwn2h3d04U4QQD6x5A/SK9imO+NdWhJAjBKbNp3ys1CSxKAUQKiBCAxIEoAEgOiBCAxIEoAEgOiBCAxIEoAEgOiBCAxIEoAkmKV/gLnlRXPAOccLgAAAABJRU5ErkJggg==\",\r\n      \"ScreenshotPath\": \"imageRepo-screenshots\\\\\\\\40096635-894d-4cdc-9dae-0da7e6ebd7a7.png\"\r\n    },\r\n    {\r\n      \"Id\": \"7b794cf0-89f3-46e5-b22f-6f08ea1b2165\",\r\n      \"Name\": \"Stroom6\",\r\n      \"Screenshot\": \"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\",\r\n      \"ScreenshotPath\": \"imageRepo-screenshots\\\\\\\\a9990d85-d4a3-4b6f-a7e5-99808361578b.png\"\r\n    }\r\n  ],\r\n  \"Version\": 1\r\n}",
    "ImportMetadata": {},
    "Name": "imgrepo"
  },
  "ConnectionReferences": []
}