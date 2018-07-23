# nim-tinyslation

- Text string translation from free online crowdsourced API.
Tinyslation a tiny translation. Sync and Async support (MultiSync).
No API Key required. Works with and without SSL `-d:ssl`. No Auth required.

![screenshot](https://source.unsplash.com/Oxl_KBNqxGA/800x402 "Illustrative Photo by https://unsplash.com/@foxfox")

![screenshot](temp.png "Tinyslation working as standalone App.")


# Use

```nim
>>> import translation
>>> echo MMT().tinyslation("white cat", to="es")  # Sync.
"gato blanco"
>>>
>>> proc async_translation {.async.} = echo await AsyncMMT().tinyslation("black dog", to="es")
>>> wait_for async_translation()                  # Async.
"perro negro"
```


# Install

```
nimble install translation
```


# Requisites

- [Nim](https://nim-lang.org)


# Documentation

<details>
    <summary><b>tinyslation()</b></summary>

**Description:**
Text string translation from [free online crowdsourced API](http://mymemory.translated.net).
The proc does not accept `char` only `string`.

**Arguments:**
- `text` A text to translate, `string` type, required.
- `to` A target language to translate on ISO 2-char language code, `string` type, eg. `"en"` or `"es"`, required.
- `from` A source language to translate on ISO 2-char language code, `string` type, eg. `"en"` or `"es"`, optional, defaults to `"en"`, required.
- `timeout` A Timeout, `int8` type, optional.

**Returns:** A translated text string, `string` type.

</details>
