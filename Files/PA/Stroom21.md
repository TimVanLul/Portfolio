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
MouseAndKeyboard.MoveMouseToImage.ClickImage Images: [imgrepo['StartWeb'], imgrepo['Test']] SearchForImageOn: MouseAndKeyboard.SearchTarget.EntireScreen MousePositionOnImage: MouseAndKeyboard.PositionOnImage.MiddleRight OffsetX: 0 OffsetY: 0 Tolerance: 10 MovementStyle: MouseAndKeyboard.MovementStyle.Instant Occurence: 1 Timeout: 5 ClickType: MouseAndKeyboard.ClickType.DoubleClick SecondsBeforeClick: 1 SearchAlgorithm: MouseAndKeyboard.ImageFinderAlgorithm.Legacy

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
    "Repository": "{\r\n  \"Folders\": [],\r\n  \"Images\": [\r\n    {\r\n      \"Id\": \"adb67e8e-f60e-4a1e-b091-17664fa69191\",\r\n      \"Name\": \"StartWeb\",\r\n      \"Screenshot\": \"iVBORw0KGgoAAAANSUhEUgAAAO8AAAAqCAYAAABbVQy+AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAARdSURBVHhe7ZvPS5RBGMc9deovqEunoJt669bBjl0C9S+ooxBCbhBBEHgyT+ulQ3npIATuHiJCAsFLoEKIQaD3UBTcXLPW9Wlm3l/PzDvvz23Xnd3vwgfXd2aeeWaYzz7vruvIr8YJAQDcA/IC4CihvOvfT+n+QotGHlNfcXf+guqbzVjiAAw7obwTfShugMyNJw0AYPLapOkneNIAAMgLgLNAXgAcBfIC4CiQFwBHgbwAOArkBcBRIC8AjgJ5AXAUyAuAo0BeAByltLw/qPzjjSVeFjxpAAaTP/RisUXfDmxtcTqSt4yEZcfxpAEYTP7SI3HWr8226fXGqaVdZ+DlrVdGabq6aWnbpKWpUarUxPPaHI2PzVE91udq2K5O0nhl1dqWjLce+1p7AdtPazvIRsrbpuWNC3rwhOjeu3PaP7L18xj8ypsk5laVpgsIW06ocvRyrv8H5O0cT96afH5wRsuLl3S90qYPuw1L32GQt7FKlbH4oSoqCOTNAvJ2DpNX0aDdj20an7mkhyu/6VDrOxTyerfOugzGQdOqsN9WldfEuKkqLcnx8rmPGicrumjbDmNabtFVXGNc2N+bJ4zL8kuU13a3wK6Z86t1h/NP0tIWGxcQi2m+2Nn2Koob76evS18zSMeU1+N475xevSS6MX9BX/aiKjwcH1iZt87m79oB9g+fIWZMqCx5VUwmjGWOSDRdkOTKq/eT8Dl1eYWELIYSOU9MtTe8r5TZzzvHmrQXCbM/yMAur0eDvq606Zaows/WmnQsrvVc3rLoCymKXk30Qy6wHEKzYhSV1yagbFdxtfl8ZDy/f7K8ZptcVyRHbF0cS74BMibPW911BH0z8grXlLBvqTkBg5zyfm6qW+iO5M3z2Fmzjykqvr6Q4kQHTz/wii7IK58Ht44c1S7HWtqCeDZJIlglZGJJTFFUHEv8oD0kXItcu4wtf3p7FMmZsaaUfYO8eenRbXMaZlV+f+gJKx/yepmqHeRZmkBQi3TdqryJh1bOlySSIF3eSCguVnCdz5+Vb4T/glYTefljvPxXQ4mja0ki2veN5wSy6NEHVjbMatzYF9erRD9bRIszV1t5g8MVVQrWVkZeNYZVcCkHj222a3hzJB3qLHm9ijsXVWAfLoopjfw9WV6/vxA1XLd6gRGy8jE51qTNofZEzxGkweTt5p+K8jIrBFYSW9qKwJMui5LCdvhyyBu8b5aCBm1ePO+alC1WZXyhI/hBjuIFaHHT5PXHmvJr86s1sdhC9jR546LZ50hek79vwaf0iiTRgR1P3q5/SSMJrbqKarsjqu4nUX1tfYvAkwZgMJHy9uDrkUkE72dDiY+I7hh9ysCTBmAw6dE/JiTRyfvaNHjSAIAuyNsteNIAAMgLgLNAXgAcBfIC4CiQFwBHgbwAOArkBcBRIC8AjgJ5AXAUyAuAo4TyTiy0rNL0AzI3njQAgMlb32zS7edtqzxXyc2nbXq7fhZLHIDh5oT+AdFCbUdTylHrAAAAAElFTkSuQmCC\",\r\n      \"ScreenshotPath\": \"imageRepo-screenshots\\\\\\\\6a9d07dd-1df9-4e16-9b18-2c8a0d8f310a.png\"\r\n    },\r\n    {\r\n      \"Id\": \"a31d35c6-1dcc-42b8-bf69-397ad11890fe\",\r\n      \"Name\": \"Test\",\r\n      \"Screenshot\": \"iVBORw0KGgoAAAANSUhEUgAAAPQAAAAvCAYAAADU1ucSAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAR3SURBVHhe7Zs9Sx1BFIZTpck/sEmVIp1apUthmyIg+gcCKSXgRwqbpLCJSERJJbYS0FgEAgYiWARFSCEIhhSpJCQqRkxQ4kc8mZn9mpk9u7O7et2b2ffCg9edmTNnlnn27N6rN/b3dggA4AcQGgCPgNAAeASEBsAjIDQAHuEUenljn3rGT+jGY2or7o2d0uLaAZszAE3FKXQ7yhwhc+NyBqCpOIXmRGonuJwBaCoQGgCPgNAAeASEBsAjIDQAHgGhAfAICA2AR0BoADwCQgPgERAaAI+A0AB4xJUL/YWqv2aYeC64nAHwi2ManfhDn7a5NpOWCF1FzKrjuJwB8ItjeiT2+s3Bc3qx8pNpT2is0IvDndQ/tcq0rdJ0XyeNLIj3C0PU3TVEi6k+9bA+1Uvdw/NsWzbBevi1Xgfa+WTbgRsp9DnNrpzSgydE92eP6PN3rl+TK3SWrGuT1F9C4mqSVeM657o6IPTlCYR+I99vH9LsxAXdenpGrzd2U30bfMs9TyNd6Y1WVhoI7QJCXx5NaMUubbw9o66BC3o495u+aX0b/Qwtb7tNQazNZ1TrsG1KHhPj+iZpWo6X70PUOFn5Rdt6HJO5vVdxrXFx/2CeOK6WX6bQ3F2FdsyeX607nr+Xpte0cRGpmPYFkDtXSdx0P3Nd5ppBPrbQATtbR/T8GVHH2Cm93wqqdbM/FLNvu+3fjU0dbkhL1pRkLqFVTE0iZo5EPlOa7Apt9pPoc5pCCzG1GEruIjHVudH7SsHDvAusybhw2P2BA17ogD36OHdOt0W1Hlk6aB+hq8LlXByz6pgbX8BsTLuylBWak1K2q7jGfCEyXtg/W2i7Ta4rESa1Lh0m3wgZU89b3Z1EfR15xWvKOG+5OQGLgkK/a5HQRV6bH/gxZS8GXM5lSDajKYGiBULL99Ftp45ql2OZtigeJ06CVjE12SS2PCoOEz9qj4nXItcuY8ufwTlKhHWsKee8Qeii1HjLnYddvef2AonlSx6vUt25nEsRScuI2KoKnbmR5XxZcgnyhU4k02WLjuvzu/JNCC9yCyKvcEyQ/3wsdnIsS07+vOk5ARc1fijGYVftX1/F8VdEP86IXg7UW6GjDZdUFK2titBqjFbppTB6bLvdIJgja6O7hA4q81BSqUN0eWyR5O/ZQof9hbzxutVFRwisjymwJmMOdU7MHEEemtDX/bVVUQaF1Epspq0MXM5lUaJwG7KA0NFzuJQ2agviBcekgKlqFEqeoG/uJF6EETdP6HCsfUEw5ldr0mKLC0Ce0Gn5+Dmy1xSet+jbAUWW/IAnELqWPyzJwqjCoipviuq8JKo017cMXM4A+IUUuqY//cwiej6Oxd4numv1qQKXMwB+UeM/Z2RxmefkPLicAWgqtT1DXxVczgA0FQgNgEdAaAA8AkID4BEQGgCPgNAAeASEBsAjIDQAHgGhAfAICA2ARziF7hk/YUVqB2RuXM4ANBWn0ItrB3Rn9JwVqk46hv/SzPIhmzMATcUpNADg/wFCA+ANO/QPqxDDiwBJrDgAAAAASUVORK5CYII=\",\r\n      \"ScreenshotPath\": \"imageRepo-screenshots\\\\\\\\be6b3b5f-c169-4e27-b7dc-1f63c229ddc2.png\"\r\n    }\r\n  ],\r\n  \"Version\": 1\r\n}",
    "ImportMetadata": {},
    "Name": "imgrepo"
  },
  "ConnectionReferences": []
}