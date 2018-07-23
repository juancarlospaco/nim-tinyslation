import asyncdispatch, httpclient, json, strformat, uri

const base_url =
  when defined(ssl): "https://mymemory.translated.net/api/get?q="  ## SSL.
  else:              "http://mymemory.translated.net/api/get?q="   ## No SSL.
type
  MMT* = HttpClient            ## Sync Client for translations.
  AsyncMMT* = AsyncHttpClient  ## Async Client for translations.


proc tinyslation*(this: MMT | AsyncMMT, text: string, to: string, frm="en", timeout: int8= 9): Future[string] {.multisync.} =
  ## Text string translation from free online crowdsourced API. Sync and Async.
  assert frm != to and len(text) > 2 and len(frm) == 2 and len(to) == 2, "Tinyslation Wrong Arguments."
  let
    url = fmt"{base_url}{encodeUrl(text)}&langpair={frm}|{to}"
    responz =
      when this is AsyncMMT: await newAsyncHttpClient().get(url)
      else: newHttpClient(timeout=timeout * 1000).get(url)
  result = $parse_json(await responz.body)["responseData"]["translatedText"]


when is_main_module:
  echo MMT().tinyslation("white cat", to="es")

  proc async_translation {.async.} = echo await AsyncMMT().tinyslation("white cat", to="es")

  wait_for async_translation()
