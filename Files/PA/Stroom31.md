DateTime.GetCurrentDateTime.Local DateTimeFormat: DateTime.DateTimeFormat.DateAndTime CurrentDateTime=> CurrentDateTime
Text.ConvertDateTimeToText.FromDateTime DateTime: CurrentDateTime StandardFormat: Text.WellKnownDateTimeFormat.LongTime Result=> Starttijd
Excel.Attach DocumentName: $'''E:\\VagrantBP\\Data.xlsx''' Instance=> ExcelInstance
UIAutomation.FocusWindow.FocusByInstanceOrHandle WindowInstance: ExcelInstance
Excel.GetFirstFreeRowOnColumn Instance: ExcelInstance Column: 1 FirstFreeRowOnColumn=> FirstFreeRowOnColumn
Excel.WriteToExcel.WriteCell Instance: ExcelInstance Value: StroomID Column: 1 Row: FirstFreeRowOnColumn
Excel.WriteToExcel.WriteCell Instance: ExcelInstance Value: Starttijd Column: 2 Row: FirstFreeRowOnColumn
UIAutomation.PressButton Button: appmask['Window \'Data.xlsx - Excel\'']['Button \'Opslaan\'']
System.RunApplication.RunApplication ApplicationPath: $'''mstsc.exe''' WorkingDirectory: $'''C:\\WINDOWS\\system32''' WindowStyle: System.ProcessWindowStyle.Normal ProcessId=> AppProcessId
UIAutomation.PressButton Button: appmask['Window \'Verbinding met extern bureaublad\'']['Button \'Verbinden\'']
WAIT 1
MouseAndKeyboard.MoveMouseToImage.ClickImage Images: [imgrepo['Stroom3'], imgrepo['Stroom3ss']] SearchForImageOn: MouseAndKeyboard.SearchTarget.EntireScreen MousePositionOnImage: MouseAndKeyboard.PositionOnImage.MiddleRight OffsetX: -12 OffsetY: 0 Tolerance: 10 MovementStyle: MouseAndKeyboard.MovementStyle.Instant Occurence: 1 Timeout: 5 ClickType: MouseAndKeyboard.ClickType.DoubleClick SecondsBeforeClick: 1 SearchAlgorithm: MouseAndKeyboard.ImageFinderAlgorithm.Legacy

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
    "Repository": "{\r\n  \"Folders\": [],\r\n  \"Images\": [\r\n    {\r\n      \"Id\": \"e5b26dc4-5575-4a42-addb-bff2098d7eae\",\r\n      \"Name\": \"Stroom3\",\r\n      \"Screenshot\": \"iVBORw0KGgoAAAANSUhEUgAAATwAAAAyCAYAAADBeGfCAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAUESURBVHhe7dy/bxxFGMbx/A90pKFCQqJI3NFRhJIySZmOJhKNJe4kKJFQiihC4pyCgip0iOQkJBA0TokcF0SgIGGJMsIyUkzsRLlzXnZmd29nZt/9mXNuffO19FHubnZm31lrnps9Oz733+ETAYAYEHgAokHgAYgGgQcgGgQegGiogbf9x1P54OZMzn0kg/LeF3OZ7hyV6gWANtTAuzTAsMuZ2rSaAaCJGnha0AyJVjMANCHwAESDwAMQDQIPQDQIPADRIPAARIPAAxANAg9ANAg8ANEg8ABEg8ADEI2lBN6f0v/ra2W8JlrNANbMz3O59v2x7GttPS0t8PoEV99+Ws0A1sxPJ3a9v3VjLtt/K+09RBV40/EFuTrZUdp2ZOvKBRnfSx7fG8nGxZFMS8esxu7ksmyM76pt1dL56HOtZ893ZSK7StvpSevduNivZqwpE3hfzmT7zom8ef2lfH7/SP7Vjusgrh1eVZg9mMjVDiHXL4T6eZ3n6qP6TaS9oc8RK2ID74V9vP/bTK5tirz71Qv5/UA5tqXIbmnvyjjZRdidnPN61wVH4BWWEXjLGANryAk86+BYvpu8lDc2T+T2r4f+sS1F9xmeWVx+gDi3s+a5t9vL2ibmtaRfcqu3Zfqbx5nFbXBwG1haxHbcoN/i+OKWznLqqww8bVfqvBae3857cf7LsvXA6efy5pJfm/SNwu8b1OyOWTnX8HqOZKyNEfQvzd/u1Iv2Yny3TkL0zAsDzzqUvftzef+6yId3nstex91efD+0CG9rw+dekGSLOgizUgg1BZ4dMwwE/xzF4sxDJj22eofnH2e45/QDLwkCZwwbfuqYCSXw3Otj+zpz9c+TaDHX2muV2J2Mgv7OeMr3a8teg3D3bp47/XD2qIGX+eeZ3L6R7PY+ncsPf7Xf7a008PrSam7PXxj6gvUXqBsqRtfA00LLtNtxvfNlzHjZ8dWBF7b5C7w0L5dSr96mzD+otxxWNXOtuJ61tXp99P6WMidTS/W4GLyWgTd9tILAa/P18Be9T9ew1GruoliUyi7gFALPPHZvwbxbLtNXacvH0wKkYOrPajXjOMepQaSMn7cvvGLg1c61deClb0pu/7SP8v3KlOaXq7x2GLyh3tLWCXd/3+6nIWe+zOt9dodazZ3ki1YJqtMIPHO8v6Ad5nxV4ZOoD7z0PKa+/F/3dff8TfXqbd0Dr3aurQIvDDW3j97fMnUTbutlqD+00IS7vsO95PWJyOOZyK2PV7vDyxeO2QGUFmefwLN9nEVqFp87dtjuSc9RFRJNgZcu9FGx08u4IRKGknl+WoHXZq61gReMnz4v+tjrEbTrn+HhzHMCb1C/ltLWZhJ6NviUti60mrtKF46yML0Fpy9Q95bLX4jFbVQpCLIQLLgBVXUL1yLwsr7euRLlEHHGTgJyWYFXjF0O/EL99QyvlXm+6Jv9JNft411r97zBPNXvL84OG3gD/MXjKt4uLtnVPUx2dz8muzzt2C60mgGsGRN4yXof3H8tq5J/PrcIvgORd4Jj+tBqBrBmhvrHA6q8yud0dbSaAaDJa/0Mb1m0mgGgCYEHIBoEHoBoEHgAokHgAYgGgQcgGgQegGgQeACiQeABiAaBByAaauBdujlTg2YITG1azQDQRA286c6RvP1Z+pcKhuT8JyfyzfZxqV4AaEMNPABYRwQegGgQeACiQeABiAaBByAST+R/yA4Ik5+CJ9QAAAAASUVORK5CYII=\",\r\n      \"ScreenshotPath\": \"imageRepo-screenshots\\\\\\\\00354abe-7dd5-4f64-8fc3-4548a1291178.png\"\r\n    },\r\n    {\r\n      \"Id\": \"60bffa47-4278-4521-9bc4-e6e2b0376429\",\r\n      \"Name\": \"Stroom3ss\",\r\n      \"Screenshot\": \"iVBORw0KGgoAAAANSUhEUgAAATkAAAAxCAYAAAChxd4oAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAUDSURBVHhe7dyxbxxFFMfx/A90aagoEE3iio4iLV2UdGlpItH47AIqCpQiRYJPVOlSIKQYiwZB4aQjliWKSJaIQEqFouBYlgkISJw4j53Zvds3s2/39jZnbm/ua+mj3N3szL5Za343e7Zz5vBgXwAgVYQcgKQRcgCSRsgBSBohByBphByApDWG3N0Hh3Lh+gs585H0yvufH8vWzpFZMwBojSHXx4AbcbVZNQOA1hhyVrj0iVUzAGiEHICkEXIAkkbIAUgaIQcgaYQcgKQRcgCSRsgBSBohByBphByApBFyAJI205D7Rbp/3TLGm8SqGUBivj+WK5vP5LHV1sLMQ65LWHXtZ9UMIDHfvfLr/e1rx7L9q9E+wVKG3NbaObm8cd9ouy/DS+dkfTN7vDmQlfMD2aocMx+7GxdlZe2O2VYvn48912b+fJduyq7RdnryelfOd6sZiXIhd+O5bN8+kbNXT+Sze0eybx1XYzl3cnUBtnNTLk8RbN2Cp5v/81xd1L9xtNf3OWJOfMj94x8//um5XFkVee+Lf+XBE+NYw5Lert6R9Wy34Hds6vVpFxkhV5pFyM1iDCRIhZz35A/5evha3lp9JcMfD8JjDUv7mZxbUGFoqFtV9zzY1RVtG+61rF92Gzd0/d3jwvgWN7rFqyxcP27Ub3x8ebvmqfpqQ87afarX4vP7eY/Pf1GGO6qfFsxldG3yN4ewb1SzHrN2rvH1HMi6NUbUvzJ/vyMv28vxdZ0E58KLQ857Kg/vHcsHV1/Lh7f/locNu7rl/cFDfMsaPw/Co1jIUYBVgmdSyPkx4xAIz1EuyFGw5MfW7+TC4xx9zjDkssWvxvCBZ46ZMUJOXx/fV801PE+mxVwbr1Vmd2MQ9VfjGd+vob8G8S7dPVf9sHjMkCv89pcMr2W7uk9eyrc/PzWP6UXIdWXV3F64GOxFGi5KHSTOtCFnBZVr9+MG5yu48Yrj60MubgsXdWVemlGv3WbMP6q3GlANc625no21Bn3s/p4xJ1dL/bjovZYh982efes685Br87W3bfeZNiCtmqdRLkTj3f4UQs491rdXwe2U62u0jcazQqPk6i9qdeOo48zwMcYftY+9Ycg1zrV1yOVvRLp/3sf4fhUq8xupvXbovT7drjaJd3lfHeTB5r7c6112gVbNUxktVCOcTiPk3PHhIlbc+eoCJ9Mccvl5XH2jf/Xr+vyT6rXbpg+5xrm2Crk4yHQfu7/n6ibQ0tKnHzxY4t3dn4+y178U+f2lyI2P57uTGy0W905fWZBdQs73UQvTLTg9dtweyM9RFwyTQi5f3INyR1fQwREHkXt+WiHXZq6NIReNnz8v+/jrEbXbn8lh4amQm/uvkLS1mgWdDzujbRpWzdPKF4uxGINFZi9KfTsVLr7yFqmy+IvgK+lQqrs9axFyRd/gXJlqcKixs1CcVciVY1dDvtR8PeNr5Z6P+xY/gdV9gmutzxvN0/z+YnH4kOvJLwPXCXZr2e5tL9vF/ZDt5qxjp2HVDCAxLuSy9d6LP+uqM/q8bRx2hyLvRsd0YdUMIDF9+gP9Om/yuVsTq2YA0ObymdysWDUDgEbIAUgaIQcgaYQcgKQRcgCSRsgBSBohByBphByApBFyAJJGyAFIWmPIXbj+wgyXPnC1WTUDgNYYcls7R/LOp/n/ANAnZ9dO5NbdZ2bNAKA1hhwALDpCDkDSCDkACduX/wB4fc/Cv1qfwQAAAABJRU5ErkJggg==\",\r\n      \"ScreenshotPath\": \"imageRepo-screenshots\\\\\\\\e45bd81e-e96d-4af2-b7ef-58a6e99c74b3.png\"\r\n    }\r\n  ],\r\n  \"Version\": 1\r\n}",
    "ImportMetadata": {},
    "Name": "imgrepo"
  },
  "ConnectionReferences": []
}