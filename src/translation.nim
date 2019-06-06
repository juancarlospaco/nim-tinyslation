import asyncdispatch, httpclient, json, strformat, uri, parseopt, terminal, random

const base_url =
  when defined(ssl): "https://mymemory.translated.net/api/get?q="  ## SSL.
  else:              "http://mymemory.translated.net/api/get?q="   ## No SSL.
type
  MMT* = HttpClient            ## Sync Client for translations.
  AsyncMMT* = AsyncHttpClient  ## Async Client for translations.


proc tinyslation*(this: MMT | AsyncMMT, text, to: string, frm="en", timeout: int8= 9): Future[string] {.multisync.} =
  ## Text string translation from free online crowdsourced API. Sync and Async.
  assert frm != to and len(text) > 2 and len(frm) == 2 and len(to) == 2, "Tinyslation Wrong Arguments."
  let
    url = fmt"{base_url}{encodeUrl(text)}&langpair={frm}|{to}"
    responz =
      when this is AsyncMMT: await newAsyncHttpClient().get(url)
      else: newHttpClient(timeout=timeout * 1000).get(url)
  result = $parse_json(await responz.body)["responseData"]["translatedText"]


when is_main_module:
  var
    tox, frm: string
  for tipoDeClave, clave, valor in getopt():
    case tipoDeClave
    of cmdShortOption, cmdLongOption:
      case clave
      of "version":             quit("0.2.0", 0)
      of "license", "licencia": quit("GPLv3", 0)
      of "help", "ayuda":       quit("translation --to=es --from=en --color --debug 'white cat'", 0)
      of "to",   "hacia":       tox = valor
      of "from", "desde":       frm = valor
      of "debug":               echo(fmt"Translate from {frm} to {tox}.")
      of "color":
        randomize()
        setBackgroundColor(bgBlack)
        setForegroundColor([fgRed, fgGreen, fgYellow, fgBlue, fgMagenta, fgCyan, fgWhite].sample)
    of cmdArgument:
      echo MMT().tinyslation(clave, to=tox, frm=frm)
    of cmdEnd: assert false


runnableExamples:
  import asyncdispatch, httpclient, json, strformat, uri, parseopt, terminal, random
  proc async_translation {.async.} = echo await AsyncMMT().tinyslation("white cat", to="es")
  wait_for async_translation()
