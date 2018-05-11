import httpclient, json, strformat, uri, pylib

proc tinyslation*(text: string, to: string, frm: string="en", fallback_value: string=""): string =
    ## Text string translation from free online crowdsourced API.
    assert frm != to and len(text) > 2 and len(frm) == 2 and len(to) == 2
    let ul = fmt"http://mymemory.translated.net/api/get?q={encodeUrl(text)}&langpair={frm}|{to}"
    try:
        result = $parse_json(get(ul).body)["responseData"]["translatedText"]
    except Exception:
        result = if fallback_value: fallback_value else: text


# if is_main_module:
#     echo tinyslation("white cat", to="es")  # "gato blanco"
