open System
open System.Net
open System.IO
open System.Text.RegularExpressions

let getPageData (url : String) =
    let request = WebRequest.Create(url)
    use response = request.GetResponse()
    use stream = response.GetResponseStream()
    use reader = new StreamReader(stream)
    reader.ReadToEnd()

let findLinks html =
    [for link in Regex.Matches(html, "<a href=\"http://.+?\">") -> link.Value.Substring(9, link.Value.Length - 11)]

let getPageDataAsync (url : String) =
    async {
        let request = WebRequest.Create(url)
        use! response = request.AsyncGetResponse()
        use stream = response.GetResponseStream()
        use reader = new StreamReader(stream)
        let html = reader.ReadToEnd()
        do printfn "%s --- %d symbols" url html.Length
    }

let url = "http://se.math.spbu.ru/SE/Members/ylitvinov/14-44/resultsSpring2016_244_Yurii"

url |> getPageData |> findLinks |> List.map getPageDataAsync |> Async.Parallel |> Async.RunSynchronously |> ignore